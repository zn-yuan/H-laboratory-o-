//
//  Server.m
//  laboratory
//
//  Created by hryan on 16/3/7.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "Server.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <unistd.h>
#import <CFNetwork/CFNetwork.h>
#import <CFNetwork/CFSocketStream.h>
#import "Connection.h"

@interface Server ()<NSNetServiceDelegate>


- (BOOL) createServer;
- (void) terminateServer;

- (BOOL) publishService;
- (void) unpublishService;

@end

@implementation Server


- (BOOL)start {
    
    BOOL succeed = [self createServer];
    if (!succeed) {
        return NO;
    }
    succeed = [self publishService];
    if (!succeed) {
        return NO;
    }
    return YES;
}


-(void) stop {
    [self terminateServer];
    [self unpublishService];
    
}
#pragma mark ----
#pragma mark Callbacks

- (void)handleNewNativeSocket:(CFSocketNativeHandle)nativeSocketHandle {
    Connection *connection = [[Connection alloc]initWithnativeSocketHandle:nativeSocketHandle];
    if (connection == nil) {
        return;
    }
    
    BOOL succeed = [connection connect];
    if (!succeed) {
        [connection close];
    }
    
    [_delegate handleNewConnection:connection];
}

static void serverAcceptCallback(CFSocketRef socket,CFSocketCallBackType type, CFDataRef address, const void *data,void *info) {
    if(type  != kCFSocketAcceptCallBack) {
        return;
    }
    
//    研究了下，socket应该是一开始创建的socket；而data是在有新的连接时创建的socket，相当于accept的返回值。
//
    
    CFSocketNativeHandle nativeSocketHandle = *(CFSocketNativeHandle *)data;
    Server *server = (__bridge Server *)info;
    [server handleNewNativeSocket:nativeSocketHandle];
}

#pragma mark -
#pragma mark  Sockets and streams

- (BOOL) createServer {
    
    
    //// PART 1: Create a socket that can accept connections
    //
    // Socket context
    //  struct CFSocketContext {
    //   CFIndex version;
    //   void *info;
    //   CFAllocatorRetainCallBack retain;
    //   CFAllocatorReleaseCallBack release;
    //   CFAllocatorCopyDescriptionCallBack copyDescription;
    //  };
    
    CFSocketContext socketCtxt = {0, (__bridge void *)(self), NULL, NULL,NULL };
    
    _listeningSocket = CFSocketCreate(kCFAllocatorDefault,
                                      PF_INET, // The protocol family for the socket
                                      SOCK_STREAM, // The socket type to create
                                      IPPROTO_TCP, // The protocol for the socket. TCP vs UDP.
                                      kCFSocketAcceptCallBack, // New connections will be automatically accepted and the callback is called with the data argument being a pointer to a CFSocketNativeHandle of the child socket.
                                      (CFSocketCallBack)serverAcceptCallback,
                                      &socketCtxt);
    
     // Previous call might have failed
    if (_listeningSocket == NULL) {
        return NO;
    }
    
     // getsockopt will return existing socket option value via this variable
    int existingValue = 1;
    
    // Make sure that same listening socket address gets reused after every connection
    // int setsockopt(int socket, int level, int option_name, const void *option_value, socklen_t option_len);
    //    http://baike.baidu.com/link?url=vSh_vOzhOCHxcvAt4584JJvp4gF6lMCB0litXSCr_ekzt1RK9mJLpXS1l72XKxuHQtLN4FpKMi8_P1Ompdik3a
    CFSocketNativeHandle socketNativeHandle = CFSocketGetNative(_listeningSocket);
    
    setsockopt(socketNativeHandle, SOL_SOCKET, SO_REUSEADDR, &existingValue, sizeof(existingValue));
    
    //// PART 2: Bind our socket to an endpoint.
    //
    // We will be listening on all available interfaces/addresses.
    // Port will be assigned automatically by kernel.
    struct sockaddr_in socketAddress;
    memset(&socketAddress, 0, sizeof(socketAddress));
    socketAddress.sin_len = sizeof(socketAddress);
    socketAddress.sin_family = AF_INET; // Address family (IPv4 vs IPv6)
    socketAddress.sin_port = 0; // Actual port will get assigned automatically by kernel
    socketAddress.sin_addr.s_addr = htonl(INADDR_ANY);   // We must use "network byte order" format (big-endian) for the value here
    
    // Convert the endpoint data structure into something that CFSocket can use
    NSData *socketAddressData = [NSData dataWithBytes:&socketAddress length:sizeof(socketAddress)];
    
    if (CFSocketSetAddress(_listeningSocket, (__bridge CFDataRef)socketAddressData) !=  kCFSocketSuccess) {
        if (_listeningSocket != NULL) {
            CFRelease(_listeningSocket);
            _listeningSocket = NULL;
        }
        return NO;
    }
    
    NSData *socketAddressActualData = (__bridge_transfer NSData*)CFSocketCopyAddress(_listeningSocket);
    
    struct sockaddr_in socketAddressActual;
    memcpy(&socketAddressActual, [socketAddressActualData bytes], [socketAddressActualData length]);
    
    self.port = ntohl(socketAddressActual.sin_port);
    CFRunLoopRef currentRunLoop = CFRunLoopGetCurrent();
    CFRunLoopSourceRef runLoopSource = CFSocketCreateRunLoopSource(kCFAllocatorDefault, _listeningSocket, 0);
    CFRunLoopAddSource(currentRunLoop, runLoopSource, kCFRunLoopCommonModes);
    CFRelease(runLoopSource);
    
    return YES;
}


- (void) terminateServer {
    if (_listeningSocket != nil) {
        CFSocketInvalidate(_listeningSocket);
        CFRelease(_listeningSocket);
        _listeningSocket = nil;
    }
}

#pragma mark -
#pragma mark Bonjour
- (BOOL) publishService {
    
    NSString *chatRoomName = [NSString stringWithFormat:@"%@'s chat room",@"hzf"];
    self.netService = [[NSNetService alloc]initWithDomain:@"" type:@"_chatty._tcp" name:chatRoomName port:self.port];
    if (self.netService == nil) {
        return NO;
    }
    [self.netService scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [self.netService setDelegate:self];
    [self.netService publish];
    
    return YES;
}
- (void) unpublishService {
    if (self.netService) {
        [self.netService removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        self.netService = nil;
    }
}

#pragma mark --
#pragma mark NSNetServiceDelegate

- (void)netServiceDidPublish:(NSNetService *)sender {
     NSLog(@" >> netServiceDidPublish: %@", [sender name]);
}

- (void)netService:(NSNetService *)sender didNotPublish:(NSDictionary<NSString *, NSNumber *> *)errorDict {
    if (sender != self.netService) {
        return;
    }
    [self terminateServer];
    [self unpublishService];
    [_delegate serverFailed:self reason:@"Failed to publish service via Bonjour (duplicate server name?)"];
}

- (void)netServiceDidResolveAddress:(NSNetService *)sender {
    
    
}

- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary<NSString *, NSNumber *> *)errorDict {
    
}

- (void)netServiceDidStop:(NSNetService *)sender {
    NSLog(@" >> netServiceDidStop: %@", [sender name]);
}


@end
