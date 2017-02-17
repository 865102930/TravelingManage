//
//  XFJCarNameTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/13.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//
#define KCellIdentifier_XFJCarNameTableViewCell @"XFJCarNameTableViewCell"


#import <UIKit/UIKit.h>

@interface XFJCarNameTableViewCell : UIView

@property (nonatomic, copy) void (^addCellBlock)(NSInteger);

+ (CGFloat)cellHeight;

@end
