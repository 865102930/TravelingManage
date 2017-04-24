//
//  XFJFourAttributeTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

//单选框
#define KCellIdentifier_XFJFourAttributeTableViewCell @"XFJFourAttributeTableViewCell"
#import <UIKit/UIKit.h>

@interface XFJFourAttributeTableViewCell : UITableViewCell
@property (nonatomic, strong) UITextField *quality_field;
@property (nonatomic, copy) void (^presentMaskViewBlock)(NSString *);

@property (nonatomic, strong) NSString *teamAttr;
@property (nonatomic, copy) NSString *userId;

@end
