//
//  NSArray+LG.m
//  005---Runtime应用
//
//  Created by cooci on 2019/2/16.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "NSArray+LG.h"
#import "LGRuntimeTool.h"
#import <objc/runtime.h>

@implementation NSArray (LG)

// load 里使用单例，以防止有人手贱主动调用load，导致又把方法交换回来
+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [LGRuntimeTool lg_methodSwizzlingWithClass:objc_getClass("__NSArrayI") oriSEL:@selector(objectAtIndex:) swizzledSEL:@selector(lg_objectAtIndex:)];
        
        [LGRuntimeTool lg_methodSwizzlingWithClass:objc_getClass("__NSArrayI") oriSEL:@selector(objectAtIndexedSubscript:) swizzledSEL:@selector(lg_objectAtIndexedSubscript:)];
    });
}

// 业务逻辑 array --- NSArray --- 类族 __NSArrayI
// 自己的imp -- lg_objectAtIndex (SEL) -- 系统imp

- (id)lg_objectAtIndex:(NSUInteger)index{
    if (index > self.count-1) {
        NSLog(@"取值越界了,请记录 : %lu > %lu",(unsigned long)index,self.count-1);
        return nil;
    }
    return [self lg_objectAtIndex:index];
}


- (id)lg_objectAtIndexedSubscript:(NSUInteger)index{
    if (index > self.count-1) {
        NSLog(@"取值越界了,请记录 : %lu > %lu",(unsigned long)index,self.count-1);
        return nil;
    }
    return [self lg_objectAtIndexedSubscript:index];
}


@end
