//
//  XFJCheckBoxTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#define KCellIdentifier_XFJCheckBoxTableViewCell @"XFJCheckBoxTableViewCell"

#import <UIKit/UIKit.h>

@interface XFJCheckBoxTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^choose_buttonClickBlock)(UIButton *);

+ (CGFloat)cellHeight;

@end
