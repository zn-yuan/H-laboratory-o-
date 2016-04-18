//
//  ServerDelegate.h
//  laboratory
//
//  Created by hryan on 16/3/7.
//  Copyright © 2016年 fe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Server, Connection;
@protocol ServerDelegate <NSObject>


// Server has been terminated because of an error
- (void) serverFailed:(Server *)server reason:(NSString *)reason;

// Server has accepted a new connection and it needs to be processed
- (void) handleNewConnection:(Connection *)connection;

@end
