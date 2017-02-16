//
//  XFJStarTaskTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/14.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#define KCellIdentifier_XFJStarTaskTableViewCell @"XFJStarTaskTableViewCell"

#import <UIKit/UIKit.h>

@interface XFJStarTaskTableViewCell : UIView

@property (nonatomic, copy) void (^startTaskButtonBlock)();

+ (CGFloat)cellHeight;

@end
