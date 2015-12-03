//
//  NSObject+SetValues.h
//  HuiMaiHealth
//
//  Created by yanglijun on 14-9-17.
//  Copyright (c) 2014年 Huimai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SetValues)

- (void)setValuesWithDic:(NSDictionary *)dict;

/*!
 * @brief 把对象（Model）转换成字典
 * @param model 模型对象
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithModel:(id)model;

- (NSString *)getNotNull:(NSString *)str;
@end
