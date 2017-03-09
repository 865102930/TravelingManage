//
//  XFJCheckBoxTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#define KCellIdentifier_XFJCheckBoxTableViewCell @"XFJCheckBoxTableViewCell"

#import <UIKit/UIKit.h>
#import "XFJFindParamsSystemListDoubleItem.h"
@interface XFJCheckBoxTableViewCell : UITableViewCell
@property (nonatomic, strong) UIButton *check_button;
@property (nonatomic, copy) void (^choose_buttonClickBlock)(UIButton *);
@property (nonatomic, copy) void (^remove_buttonClickBlock)(UIButton *);
@property (nonatomic, strong) XFJFindParamsSystemListDoubleItem *findParamsSystemListDoubleItem;

+ (CGFloat)cellHeight;

@end
