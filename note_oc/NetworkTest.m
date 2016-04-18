//
//  ScoketCreate.m
//  laboratory
//
//  Created by hryan on 16/3/8.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "NetworkTest.h"


@implementation NetworkTest


#pragma mark---------------------- CFSocket包括以下编程接口，包括Socket的 创建、配置，以及根据创建和配置好的Socket 进行 远程通讯等接口。

#pragma mark -----------1 Socket的 创建
#pragma mark---

- (void)scoketCreate1 {
//    创建一个特定协议和类型的 CFSocket对象
//    CFSocketCreate(<#CFAllocatorRef allocator#>, <#SInt32 protocolFamily#>, <#SInt32 socketType#>, <#SInt32 protocol#>, <#CFOptionFlags callBackTypes#>, <#CFSocketCallBack callout#>, <#const CFSocketContext *context#>)
}
- (void)scoketCreate2 {
    //    该接口根据一个包含通讯协议和地址的CFSocketSignature结构来创建一个CFSocket对象
    //    CFSocketCreateWithSocketSignature(<#CFAllocatorRef allocator#>, <#const CFSocketSignature *signature#>, <#CFOptionFlags callBackTypes#>, <#CFSocketCallBack callout#>, <#const CFSocketContext *context#>)
}
- (void)scoketCreate3 {
    //    该接口在创建一个CFSocket对象的同时还与一个远端主机进行连接。
    
    //    CFSocketCreateConnectedToSocketSignature(<#CFAllocatorRef allocator#>, <#const CFSocketSignature *signature#>, <#CFOptionFlags callBackTypes#>, <#CFSocketCallBack callout#>, <#const CFSocketContext *context#>, <#CFTimeInterval timeout#>)
}

- (void)scoketCreate4{
//    该接口通过封装一个存在的 BSD socket来创建一个CFSocket对象。
//    CFSocketCreateWithNative(<#CFAllocatorRef allocator#>, <#CFSocketNativeHandle sock#>, <#CFOptionFlags callBackTypes#>, <#CFSocketCallBack callout#>, <#const CFSocketContext *context#>)
}

#pragma mark --------------------------------2 Socket的配置
#pragma mark--------

- (void)socketConfigurate{
//     返回一个 CFSocket对象的本地地址。
//    CFSocketCopyAddress(<#CFSocketRef s#>)
    
    
//    返回与一个 CFSocket对象连接的远端地址。
//    CFSocketCopyPeerAddress(<#CFSocketRef s#>)
    
//    临时取消一个CFSocket对象创建时指定的某种类型的事件回调。
//    CFSocketDisableCallBacks(<#CFSocketRef s#>, <#CFOptionFlags callBackTypes#>)
    
    
//    重新允许先前CFSocketDisableCallBacks函数取消的某种类型的事件回调。
//     CFSocketEnableCallBacks(<#CFSocketRef s#>, <#CFOptionFlags callBackTypes#>)
    
//    返回一个CFSocket对象的上下文信息
//     CFSocketGetContext(<#CFSocketRef s#>, <#CFSocketContext *context#>)
    
    
//    返回与一个CFSocket对象相关的本地 BSD socket。
//     CFSocketGetNative(<#CFSocketRef s#>)
    
    
//    返回控制一个CFSocket对象的确定行为的 标志。
//     CFSocketGetSocketFlags(<#CFSocketRef s#>)
    
    
    
//    设置控制一个CFSocket对象的确定行为的 标志。
//    CFSocketSetSocketFlags(<#CFSocketRef s#>, <#CFOptionFlags flags#>)
    
//    为一个CFSocket对象绑定一个本地地址并在本地socket支持的情况下对socket进行配置使其处于监听状态。该函数对应本地socket的 bind以及listen功能。一旦CFSocket对象绑定地址，依赖于socket的协议，其它进程和主机能连接到该CFSocket对象。
    
//    CFSocketSetAddress(<#CFSocketRef s#>, <#CFDataRef address#>)
    
}

#pragma mark --------------------------------3、Sockets的使用
#pragma mark--------


- (void)useSocket{
    
//    打开与一个远程socket的一个连接。
//    CFSocketConnectToAddress(<#CFSocketRef s#>, <#CFDataRef address#>, <#CFTimeInterval timeout#>)
    
    
//    ：为一个CFSocket对象创建一个CFRunLoopSource对象。该创建的 CFRunLoopSource对象不自动添加到一个run loop。为了增加该run loop source到某个run loop，需要调用CFRunLoop对象 的CFRunLoopAddSource函数来为该CFRunLoop对象添加run loop source。
//    CFSocketCreateRunLoopSource(<#CFAllocatorRef allocator#>, <#CFSocketRef s#>, <#CFIndex order#>)
    
    
//    返回CFSocket对象的 opaque类型对应的类型标示符。
//    CFSocketGetTypeID()
    
//    ：使一个CFSocket对象无效，使其停止接收和发送任何消息。
//    CFSocketInvalidate(<#CFSocketRef s#>)
    
//    返回一个指示一个CFSocket对象是否有效及是否能够发送和接收消息的布尔值。
//    CFSocketIsValid(<#CFSocketRef s#>)
    
    
//    该函数用来通过一个CFSocket对象发送数据。
//     CFSocketSendData(<#CFSocketRef s#>, <#CFDataRef address#>, <#CFDataRef data#>, <#CFTimeInterval timeout#>)
    
    
    
}






@end
