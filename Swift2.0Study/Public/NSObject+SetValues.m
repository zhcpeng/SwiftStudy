//
//  NSObject+SetValues.m
//  HuiMaiHealth
//
//  Created by yanglijun on 14-9-17.
//  Copyright (c) 2014年 Huimai. All rights reserved.
//

#import "NSObject+SetValues.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (SetValues)

-(void)setValuesWithDic:(NSDictionary *)dict
{
    Class c = [self class];
    while (c) {
        //1.获得所有的成员变量
        unsigned int count ;
        Ivar *ivars = class_copyIvarList(c, &count);
        for (int i = 0 ; i < count; i++) {
            Ivar var = ivars[i];
            
            //属性名
            NSMutableString *name = [NSMutableString stringWithUTF8String:ivar_getName(var)];
            if ([[name substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"_"]) {
                name = (NSMutableString *)[name stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
            }
            
            //取出属性值
            NSString *key = name;
            id value = dict[key];
            if(!value) continue;
            
            //通过属性名名拿到SEL
            //首字母变大写
            NSString *cap = [name substringToIndex:1];
            cap = cap.uppercaseString; //字符串变大写
            [name replaceCharactersInRange:NSMakeRange(0, 1) withString:cap];
            //拼接set
            [name insertString:@"set" atIndex:0];
            //拼接冒号到最后
            [name appendString:@":"];
            SEL selector = NSSelectorFromString(name);
            
//            objc_msgSend(self, selector , value);
            ((void(*)(id, SEL,id))objc_msgSend)(self, selector, value);
        }
        c = class_getSuperclass(c);
        free(ivars);
    }
    
}

+ (NSDictionary *)dictionaryWithModel:(id)model {
    if (model == nil) {
        return nil;
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    // 获取类名/根据类名获取类对象
    NSString *className = NSStringFromClass([model class]);
    id classObject = objc_getClass([className UTF8String]);
    
    // 获取所有属性
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(classObject, &count);
    
    // 遍历所有属性
    for (int i = 0; i < count; i++) {
        // 取得属性
        objc_property_t property = properties[i];
        // 取得属性名
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property)
                                                          encoding:NSUTF8StringEncoding];
        // 取得属性值
        id propertyValue = nil;
        id valueObject = [model valueForKey:propertyName];
        
        if ([valueObject isKindOfClass:[NSDictionary class]]) {
            propertyValue = [NSDictionary dictionaryWithDictionary:valueObject];
        } else if ([valueObject isKindOfClass:[NSArray class]]) {
            propertyValue = [NSArray arrayWithArray:valueObject];
        } else {
            propertyValue = [NSString stringWithFormat:@"%@", [model valueForKey:propertyName]];
        }
        
        [dict setObject:propertyValue forKey:propertyName];
    }
    return [dict copy];
}

- (NSString *)getNotNull:(NSString *)str {
    return (NSNull *)str == [NSNull null]?@"":str;
}
@end
