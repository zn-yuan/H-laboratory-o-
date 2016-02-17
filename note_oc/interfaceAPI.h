//
//  interfaceAPI.h
//  note_oc
//
//  Created by hryan on 16/1/5.
//  Copyright © 2016年 fe. All rights reserved.
//

#ifndef interfaceAPI_h
#define interfaceAPI_h

#ifdef DEBUG // 测试服务器

#define baseURL @"http://219.233.175.88" //内网

#else

#define baseURL @"http://219.233.175.88"//外网

#endif

#define kLoginURL [NSString stringWithFormat:@"%@/login", baseURL]


#endif /* interfaceAPI_h */
