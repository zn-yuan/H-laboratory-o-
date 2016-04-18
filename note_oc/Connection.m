//
//  Connection.m
//  laboratory
//
//  Created by hryan on 16/3/7.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "Connection.h"

@interface Connection ()


- (void)clean;

- (BOOL)setupSocketStreams;

-(void) readStreamHandleEvent:(CFStreamEventType)event;
-(void) writeStreamHandleEvent:(CFStreamEventType)event;

-(void) readFromStreamIntoIncomingBuffer;

-(void) writeOutgoingBufferToStream;

@end



@implementation Connection


- (void)clean {
    _readStream = nil;
    _readStreamOpen = NO;
    
    _writeStream = nil;
    _writeStreamOpen = NO;
    
    _incomingDataBuffer = nil;
    _outgoingDataBuffer = nil;
    
    self.netService = nil;
    self.host = nil;
    _connectedSocketHandle = -1;
    _packetBodySize = -1;
    
}


- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithHostAddress:(NSString *)host andPort:(NSInteger)port{
    [self clean];
    self.host = host;
    self.port = port;
    return self;
}

- (instancetype)initWithnativeSocketHandle:(CFSocketNativeHandle)nativeSocketHandle {
     [self clean];
    self.connectedSocketHandle = nativeSocketHandle;
    
    return self;
}

- (instancetype) initWithNetService:(NSNetService *)netService {
    [self clean];
    
    if(netService.name != nil) {
        return [self initWithHostAddress:netService.name andPort:netService.port];
    }
    self.netService = netService;
    return self;
}


#pragma mark -
#pragma mark Network

-(BOOL)connect {
    
    if (self.host != nil) {
         // Bind read/write streams to a new socket
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, (__bridge CFStringRef)self.host, (UInt32)self.port, &_readStream, &_writeStream);
        
        // Do the rest
        return [self setupSocketStreams];
    }
    else if (self.connectedSocketHandle != -1) {
        // Bind read/write streams to a socket represented by a native socket handle
        CFStreamCreatePairWithSocket(kCFAllocatorDefault, self.connectedSocketHandle, &_readStream, &_writeStream);
        
        // Do the rest
        return [self setupSocketStreams];
    }
    else if( self.netService != nil) {
        // Still need to resolve?
        if (self.netService.name != nil) {
            CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault,
                                               (__bridge CFStringRef)self.netService.hostName, (UInt32)self.netService.port, &_readStream, &_writeStream);
            return [self setupSocketStreams];
        }
        // Start resolving
        self.netService.delegate = self;
        [self.netService resolveWithTimeout:5.0];
        return YES;
    }
    
    // Nothing was passed, connection is not possible
    return NO;
}

// Further setup socket streams that were created by one of our 'init' methods
- (BOOL)setupSocketStreams {
    
    // Make sure streams were created correctly
    if (_readStream == nil || _writeStream == nil) {
        [self clean];
        return NO;
    }
    // Create buffers
    _incomingDataBuffer = [[NSMutableData alloc] init];
    _outgoingDataBuffer = [[NSMutableData alloc]init];
    
     // Indicate that we want socket to be closed whenever streams are closed
    CFReadStreamSetProperty(_readStream, kCFStreamPropertyShouldCloseNativeSocket, kCFBooleanTrue);
    CFWriteStreamSetProperty(_writeStream, kCFStreamPropertyShouldCloseNativeSocket, kCFBooleanTrue);
    
     // We will be handling the following stream events
    CFOptionFlags registeredEvents = kCFStreamEventOpenCompleted | kCFStreamEventHasBytesAvailable | kCFStreamEventCanAcceptBytes | kCFStreamEventEndEncountered | kCFStreamEventErrorOccurred;
    
     // Setup stream context - reference to 'self' will be passed to stream event handling callbacks
    CFStreamClientContext ctx = {0, (__bridge void *)(self), NULL, NULL,NULL};
    
    // Specify callbacks that will be handling stream events
    CFReadStreamSetClient(_readStream, registeredEvents, readStreamEventHandler, &ctx);
    CFWriteStreamSetClient(_writeStream, registeredEvents, writeStreamEventHandler, &ctx);
    
    // Schedule streams with current run loop
    CFReadStreamScheduleWithRunLoop(_readStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
    CFWriteStreamScheduleWithRunLoop(_writeStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
    // Open both streams
    if (!CFReadStreamOpen(_readStream) || !CFWriteStreamOpen(_writeStream)) {
        [self close];
        return NO;
    }
    
    return YES;
}

// Close connection
-(void)close {
     // Cleanup read stream
    if (_readStream != nil) {
        CFReadStreamUnscheduleFromRunLoop(_readStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
        CFReadStreamClose(_readStream);
        _readStream = NULL;
    }
    
    // Cleanup write stream
    if (_writeStream != nil) {
        CFWriteStreamUnscheduleFromRunLoop(_writeStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
        CFWriteStreamClose(_writeStream);
        _writeStream = NULL;
    }
    
    // Cleanup buffers
    
    _incomingDataBuffer  = nil;
    _outgoingDataBuffer = nil;
    
    // Stop net service?
    
    if (_netService != nil) {
        [_netService stop];
        self.netService = nil;
    }
    
    // Reset all other variables
    
    [self clean];
}


#pragma mark -
#pragma mark Send or Recv data
// Send network message
-(void)sendNetworkPacket:(NSDictionary *)packet {
    
    // Encode packet
    
    NSData *rawPacket = [NSKeyedArchiver archivedDataWithRootObject:packet];
    
    // Write header: lengh of raw packet
    
    NSInteger packetLength = [rawPacket length];
    [_outgoingDataBuffer appendBytes:&packetLength length:sizeof(int)];
    
    // Write body: encoded NSDictionary
    [_outgoingDataBuffer appendData:rawPacket];
    
    // Try to write to stream
    [self writeOutgoingBufferToStream];

}

#pragma mark Read stream methods
// Dispatch readStream events
void readStreamEventHandler(CFReadStreamRef stream, CFStreamEventType type, void *clientCallBackInfo) {
    Connection *connection = (__bridge Connection *)clientCallBackInfo;
    [connection readStreamHandleEvent:type];
}


// Handle events from the read stream

-(void) readStreamHandleEvent:(CFStreamEventType)event {
    // Stream successfully opened
    if (event == kCFStreamEventOpenCompleted) {
        _readStreamOpen = YES;
    }
    
    // New data has arrived
    else if (event == kCFStreamEventHasBytesAvailable) {
        [self readFromStreamIntoIncomingBuffer];
    }
    
    // Connection has been terminated or error encountered (we treat them the same way)
    else if(event == kCFStreamEventEndEncountered || event == kCFStreamEventErrorOccurred) {
        [self close];
        
        if (!_readStreamOpen || !_writeStreamOpen) {
            [_delegate connectionAttemptFailed:self];
        } else {
            [_delegate connectionTermainated:self];
        }
    }
}

// Read as many bytes from the stream as possible and try to extract meaningful packets
-(void) readFromStreamIntoIncomingBuffer {
    
}

#pragma mark Write stream methods
void writeStreamEventHandler(CFWriteStreamRef stream, CFStreamEventType type, void *clientCallBackInfo) {
    
}
-(void) writeStreamHandleEvent:(CFStreamEventType)event {
    
}


-(void) writeOutgoingBufferToStream {
    
}


#pragma mark -
#pragma mark NSNetService Delegate Method Implementations

@end
