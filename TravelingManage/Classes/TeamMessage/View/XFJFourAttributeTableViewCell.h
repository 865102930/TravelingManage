//
//  XFJFourAttributeTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

//复选框
#define KCellIdentifier_XFJFourAttributeTableViewCell @"XFJFourAttributeTableViewCell"
#import <UIKit/UIKit.h>

@interface XFJFourAttributeTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^presentMaskViewBlock)();

@property (nonatomic, strong) NSString *teamAttr;

@end
