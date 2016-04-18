//
//  ConnectionDelegate.h
//  laboratory
//
//  Created by hryan on 16/3/9.
//  Copyright © 2016年 fe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Connection;

@protocol ConnectionDelegate <NSObject>

-(void)connectionAttemptFailed:(Connection*)connection;

- (void)connectionTermainated:(Connection*)connection;

-(void) receivedNetworkPacker:(NSDictionary*)message viaConnection:(Connection*)connection;

@end
