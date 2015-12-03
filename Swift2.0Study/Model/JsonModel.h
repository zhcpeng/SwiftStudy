//
//  JsonModel.h
//  Swift2Study
//
//  Created by zhcpeng on 15/11/13.
//  Copyright © 2015年 Beijing HuiMai Online Network Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/**< 商品类基本BaseModel */
@interface JsonModel : NSObject

@property (copy, nonatomic) NSString *product_id;           /**< 产品id */
@property (copy, nonatomic) NSString *goods_id;             /**< 商品id */
@property (copy, nonatomic) NSString *name;                 /**< 商品名称 */
@property (copy, nonatomic) NSString *brief;                /**< 商品描述 */
@property (assign, nonatomic) float price;                  /**< 现价 */
@property (assign, nonatomic) float mktprice;               /**< 原价 */
@property (copy, nonatomic) NSString *discount_rate;        /**< 折扣 */
@property (copy, nonatomic) NSString *biku_id;              /**< 比酷id */
@property (copy, nonatomic) NSString *ywhflag;              /**< 有无货（true，false） */
@property (copy, nonatomic) NSString *goods_main_pic;       /**< 介绍图 */

@end
