//
//  XFJFiveAttributeTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

//下拉框
#define KCellIdentifier_XFJFiveAttributeTableViewCell @"XFJFiveAttributeTableViewCell"

typedef void(^ReturnBlock)(NSString *teamArr);

#import <UIKit/UIKit.h>

@interface XFJFiveAttributeTableViewCell : UITableViewCell
@property (nonatomic, copy) ReturnBlock myBlock;
@property (nonatomic, strong) NSString *teamAttr;
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, strong) UILabel *teamPropertiesContent_label;

@end
