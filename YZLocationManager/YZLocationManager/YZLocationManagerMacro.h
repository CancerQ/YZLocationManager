//
//  YZLocationManagerMacro.h
//  YZLocationManager
//
//  Created by 叶志强 on 2017/2/20.
//  Copyright © 2017年 CancerQ. All rights reserved.
//


#ifndef YZLocationManagerMacro_h
#define YZLocationManagerMacro_h

#ifndef YZLMSystemVersion
#define YZLMSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#endif

#ifndef YZLMiOS8Later
#define YZLMiOS8Later (YZLMSystemVersion >= 8)
#endif

#ifndef YZLMiOS9Later
#define YZLMiOS9Later (YZLMSystemVersion >= 9)
#endif

#ifndef YZLMLOG
#define YZLMLOG(format, ...)                   \
NSLog(@"\n%s:%d\n%@",               \
__PRETTY_FUNCTION__, __LINE__,      \
[NSString stringWithFormat:format, ## __VA_ARGS__])

#define _po(o) YZLMLOG(@"%@", (o))
#define _pn(o) YZLMLOG(@"%d", (o))
#define _pf(o) YZLMLOG(@"%f", (o))
#define _plc(o) YZLMLOG(@"CLLocationCoordinate2D: {latitude:%.0f, longitude:%.0f}", (o).latitude, (o).longitude)

#define YZLMOBJ(obj)  YZLMLOG(@"%s: %@", #obj, [(obj) description])

#define MARK    NSLog(@"\nMARK: %s, %d", __PRETTY_FUNCTION__, __LINE__)
#endif

#ifndef YZLMAlertShowMsg
#define YZLMAlertShowMsg(msg) {UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];[alertView show];}
#endif

#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif


#endif /* YZLocationManagerMacro_h */
