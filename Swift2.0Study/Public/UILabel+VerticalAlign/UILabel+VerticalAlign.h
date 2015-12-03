//
//  UILabel+VerticalAlign.h
//  HuiMaiHealth
//
//  Created by zhcpeng on 14-11-19.
//  Copyright (c) 2014年 Huimai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface UILabel (VerticalAlign)

//@property (assign, nonatomic ,readwrite) id isTop;
@property (assign, nonatomic) id alignmentENUM;

//垂直方向顶端对齐
-(void)alignTop;

//垂直方向底部对齐
-(void)alignBottom;

@end
