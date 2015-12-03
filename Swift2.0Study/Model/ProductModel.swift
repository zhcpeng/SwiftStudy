//
//  ProductModel.swift
//  Swift2Study
//
//  Created by zhcpeng on 15/11/17.
//  Copyright © 2015年 Beijing HuiMai Online Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class ProductModel: NSObject {
    var product_id = String()           /**< 产品id */
    var goods_id = String()             /**< 商品id */
    var goods_name = String()           /**< 商品名称 */
    var brief = String()                /**< 商品描述 */
    var price = String()                /**< 现价 */
    var mktprice = String()             /**< 原价 */
    var discount_rate = String()        /**< 折扣 */
    var biku_id = String()              /**< 比酷id */
    var ywhflag = String()              /**< 有无货（true，false） */
    var app_special_pic = String()      /**< 介绍图 */
}

//@property (copy, nonatomic) NSString *product_id;           /**< 产品id */
//@property (copy, nonatomic) NSString *goods_id;             /**< 商品id */
//@property (copy, nonatomic) NSString *name;                 /**< 商品名称 */
//@property (copy, nonatomic) NSString *brief;                /**< 商品描述 */
//@property (assign, nonatomic) float price;                  /**< 现价 */
//@property (assign, nonatomic) float mktprice;               /**< 原价 */
//@property (copy, nonatomic) NSString *discount_rate;        /**< 折扣 */
//@property (copy, nonatomic) NSString *biku_id;              /**< 比酷id */
//@property (copy, nonatomic) NSString *ywhflag;              /**< 有无货（true，false） */
//@property (copy, nonatomic) NSString *goods_main_pic;       /**< 介绍图 */

//"goods_name" : "【中国﹒天然无刺激】悦丝2号受损洗发水750ml",
//"app_special_pic" : "http:\/\/img.hml365.com\/images\/3b\/a7\/be\/ef1311cf826df309d45af95d7a889053.jpg",
//"area_name" : null,
//"discount_rate" : "7.6",
//"statrus" : null,
//"area_type" : null,
//"ywhflag" : null,
//"mktprice" : "78.00",
//"price" : "59.00",
//"view_count" : null,
//"product_id" : "103",
//"to_time" : null,
//"goodsflag" : null,
//"goods_id" : "88"
