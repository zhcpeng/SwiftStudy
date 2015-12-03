//
//  UILabel+VerticalAlign.m
//  HuiMaiHealth
//
//  Created by zhcpeng on 14-11-19.
//  Copyright (c) 2014年 Huimai. All rights reserved.
//

#import "UILabel+VerticalAlign.h"

//#import <objc/runtime.h>
//
//static void * alignmentENUMM = (void *)@"alignmentENUM";

@implementation UILabel (VerticalAlign)

@dynamic alignmentENUM;

-(void)alignTop{
    CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    double finalHeight = fontSize.height *self.numberOfLines;
    double finalWidth =self.frame.size.width;//expected width of label
    CGRect labelRect = [self.text boundingRectWithSize:CGSizeMake(finalWidth, finalHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
    int newLinesToPad =(finalHeight - labelRect.size.height)/ labelRect.size.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text =[self.text stringByAppendingString:@"\n"];
}
-(void)alignBottom{
    CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    double finalHeight = fontSize.height *self.numberOfLines;
    double finalWidth =self.frame.size.width;//expected width of label
    CGRect labelRect = [self.text boundingRectWithSize:CGSizeMake(finalWidth, finalHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
    int newLinesToPad =(finalHeight - labelRect.size.height)/ labelRect.size.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text =[NSString stringWithFormat:@"\n%@",self.text];
}

//-(id)alignmentENUM{
//    return objc_getAssociatedObject(self,alignmentENUMM);
//}
//-(void)setAlignmentENUM:(id)alignmentENUM{
//    objc_setAssociatedObject(self, (__bridge const void *)(alignmentENUM), (__bridge id)(alignmentENUMM), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    
////    [self setNeedsDisplay];
//}

//- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
//    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
//    switch (self.verticalAlignment) {
//        case VerticalAlignmentTop:
//            textRect.origin.y = bounds.origin.y;
//            break;
//        case VerticalAlignmentBottom:
//            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
//            break;
//        case VerticalAlignmentMiddle:
//            // Fall through.
//        default:
//            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
//    }
//    return textRect;
//}
//
//-(void)drawTextInRect:(CGRect)requestedRect {
//    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
//    [super drawTextInRect:actualRect];
//}


@end
