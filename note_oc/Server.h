//
//  Server.h
//  laboratory
//
//  Created by hryan on 16/3/7.
//  Copyright © 2016年 fe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerDelegate.h"

@interface Server : NSObject

@property (nonatomic, assign) uint16_t port;
@property (nonatomic, strong) NSNetService *netService;
@property (nonatomic, assign) CFSocketRef listeningSocket;
@property (nonatomic, assign) id<ServerDelegate> delegate;


- (BOOL)start;
-(void) stop;


@end
