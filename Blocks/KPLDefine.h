//
//  KPLDefine.h
//  开发中用到的文件
//
//  Created by apple on 17/1/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/NSObjCRuntime.h>

#if !defined(KPL_INITIALIZER)
#  if __has_attribute(objc_method_family)
#   define KPL_INITIALIZER __attribute__((objc_method_family(init)))

# else

#define KPL_INITIALIZER

#endif

#endif















