//
//  streamTest.m
//  laboratory
//
//  Created by hryan on 16/3/8.
//  Copyright © 2016年 fe. All rights reserved.
//
//stream编程模式提供了与 unix 的文件操作类似的模式。首先创建和设置流，接着打开流，然后读写流，在流存在时还可以通过查询流的相关属性来读取流的相关信息，在流使用完毕后关闭流。

//iOS 为stream编程模式提供的api编程接口包括两大类，一类是Core Foundation框架层用C语言实现的CFStream API（包括CFStream、 CFReadStream 、CFWriteStream等）,一类是基于其上的在Foundation框架层用Objective-C语言实现的NSStream API（包括NSStream、NSInputStream NSOutputStream等）,两者提供相似的接口和行为，其中某些对象是toll-free bridged类型的，如CFStream 与NSStream，CFReadStream与NSInputStream，CFWriteStream与NSOutputStream之间，因此可以混合使用。

//开发人员可以根据自己的语言偏好选择使用。


/*
 
 CFStream API的使用步骤：
 
 1） 利用流创建接口创建相关流；
 
 2）、调用CFReadStreamSetClient （可读流）或CFWriteStreamSetClient （可写流）来登记要接收的流相关的事件；
 
 3）、调用CFReadStreamScheduleWithRunLoop（可读流）或CFWriteStreamScheduleWithRunLoop（可写流）来使在流在一个run loop上进行调度以便接收相关事件；
 
 4）、调用CFReadStreamOpen 或CFWriteStreamOpen 来打开已创建的流；
 
 5）、在读取流的创建时登记的回调中，在接收到kCFStreamEventHasBytesAvailable事件时来读取数据， 在可写流已登记的回调中，在接收到kCFStreamEventCanAcceptBytes 事件时开始发送数据或请求；
 
 6） 数据传输完成，关闭和释放打开和创建的相关流；
 

 */
#import "streamTest.h"

@implementation streamTest


#pragma mark----------------------------------------CFStream API的主要接口：
#pragma CFStream 创建：

- (void)create{
    
//   1.1  创建一对到一个socket的可读和可写流。
//    CFStreamCreatePairWithPeerSocketSignature(<#CFAllocatorRef alloc#>, <#const CFSocketSignature *signature#>, <#CFReadStreamRef *readStream#>, <#CFWriteStreamRef *writeStream#>)
    
    
    
    
//  1.2  创建连接到一个特定主机的特定端口的一对可读写流。
//     CFStreamCreatePairWithSocketToHost(<#CFAllocatorRef alloc#>, <#CFStringRef host#>, <#UInt32 port#>, <#CFReadStreamRef *readStream#>, <#CFWriteStreamRef *writeStream#>)
    
//   1.3 创建一对连接到一个socket的可读写流
//    CFStreamCreatePairWithSocket(<#CFAllocatorRef alloc#>, <#CFSocketNativeHandle sock#>, <#CFReadStreamRef *readStream#>, <#CFWriteStreamRef *writeStream#>)
    
//   1.4 创建一对读写流。
//    CFStreamCreateBoundPair(<#CFAllocatorRef alloc#>, <#CFReadStreamRef *readStream#>, <#CFWriteStreamRef *writeStream#>, <#CFIndex transferBufferSize#>)
    
//   1.5 为一个CFHTTP请求创建一个可读流。已废弃
//    CFReadStreamCreateForHTTPRequest(<#CFAllocatorRef  _Nullable alloc#>, <#CFHTTPMessageRef  _Nonnull request#>)
    
//  1.6  为一个HTTP请求的body保持在内存的CFHTTP请求创建一个可读流。已废弃
//     CFReadStreamCreateForStreamedHTTPRequest(<#CFAllocatorRef  _Nullable alloc#>, <#CFHTTPMessageRef  _Nonnull requestHeaders#>, <#CFReadStreamRef  _Nonnull requestBody#>)
    
    
//    1.7 创建一个FTP可读流 已废弃
//    CFReadStreamCreateWithFTPURL(<#CFAllocatorRef  _Nullable alloc#>, <#CFURLRef  _Nonnull ftpURL#>)
//   1.8 创建一个FTP可读流 已废弃
//    CFWriteStreamCreateWithFTPURL(<#CFAllocatorRef  _Nullable alloc#>, <#CFURLRef  _Nonnull ftpURL#>)
}


/*
 
 *2. CFReadStream接口
 
 2.1 流的打开和关闭
 
 CFReadStreamOpen
 
 CFReadStreamClose
 
 2.2 读取数据
 
 CFReadStreamRead
 
 2.3. 调度一个可读流
 
 CFReadStreamScheduleWithRunLoop(_:_:_:)
 
 CFReadStreamUnscheduleFromRunLoop(_:_:_:)
 
 2.4 检查可读流的属性
 
 CFReadStreamCopyProperty(_:_:)
 
 CFReadStreamGetBuffer(_:_:_:)
 
 CFReadStreamCopyError(_:)
 
 CFReadStreamGetError(_:)
 
 CFReadStreamGetStatus(_:)
 
 CFReadStreamHasBytesAvailable(_:)
 
 2.5 设置可读流的属性
 
 CFReadStreamSetClient(_:_:_:_:)
 
 CFReadStreamSetProperty(_:_:_:)
 
 2.6 得到 CFReadStream的 Type ID
 
 CFReadStreamGetTypeID()
 
 3.CFWriteStream 相关接口
 
 
 3.1 CFWriteStreamClose(_:)
 
 3.2 CFWriteStreamOpen(_:)
 
 3.3 CFWriteStreamWrite(_:_:_:)
 
 3.4 CFWriteStreamScheduleWithRunLoop(_:_:_:)
 
 3.5 CFWriteStreamUnscheduleFromRunLoop(_:_:_:)
 
 3.6 CFWriteStreamCanAcceptBytes(_:)
 
 3.7 CFWriteStreamCopyProperty(_:_:)
 
 3.8 CFWriteStreamCopyError(_:)
 
 3.9 CFWriteStreamGetError(_:)
 
 3.10 CFWriteStreamGetStatus(_:)
 
 3.11 CFWriteStreamSetClient(_:_:_:_:)
 
 3.12 CFWriteStreamSetProperty(_:_:_:)
 
 3.13 CFWriteStreamGetTypeID()
 
 
 */

@end
