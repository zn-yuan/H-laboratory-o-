//
//  Connection.h
//  laboratory
//
//  Created by hryan on 16/3/7.
//  Copyright © 2016年 fe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CFNetwork/CFSocketStream.h>
#import "ConnectionDelegate.h"

@interface Connection : NSObject<NSNetServiceDelegate>

// Connection info: host address and port
@property (nonatomic) NSString *host;
@property (nonatomic) NSInteger port;

// Connection info: native socket handle
@property (nonatomic, assign) CFSocketNativeHandle connectedSocketHandle;

// Connection info: NSNetService
@property (nonatomic)NSNetService *netService;

//Read stream
@property (nonatomic,assign)CFReadStreamRef readStream;
@property (nonatomic,assign) BOOL readStreamOpen;
@property (nonatomic) NSMutableData *incomingDataBuffer;
@property (nonatomic, assign) int packetBodySize;

//Write stream
@property (nonatomic, assign) CFWriteStreamRef writeStream;
@property (nonatomic, assign) BOOL  writeStreamOpen;
@property (nonatomic) NSMutableData *outgoingDataBuffer;

@property (nonatomic, assign) id<ConnectionDelegate> delegate;


- (instancetype)initWithHostAddress:(NSString *)host andPort:(NSInteger)port;

- (instancetype)initWithnativeSocketHandle:(CFSocketNativeHandle)nativeSocketHandle;

- (instancetype) initWithNetService:(NSNetService *)netService;

-(BOOL)connect;
-(void)close;

-(void)sendNetworkPacket:(NSDictionary *)packet;





@end
