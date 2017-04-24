//
//  XFJFirestAttributeTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/7.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//


//输入单行
#define KCellIdentifier_XFJFirestAttributeTableViewCell @"XFJFirestAttributeTableViewCell"

#import <UIKit/UIKit.h>

typedef void(^ReturnTextFieldBlock)(NSString *, NSString *);

typedef void(^ReturnSecondTextBlock)(NSString *, NSString *, NSString *);

@interface XFJFirestAttributeTableViewCell : UITableViewCell

@property (nonatomic, strong) UITextField *quality_field;

@property (nonatomic, assign) NSInteger isRequire;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) ReturnTextFieldBlock textFieldBlock;

@property (nonatomic, copy) NSString *teamAttr;

@property (nonatomic, copy) ReturnSecondTextBlock secondTextBlock;

@end
