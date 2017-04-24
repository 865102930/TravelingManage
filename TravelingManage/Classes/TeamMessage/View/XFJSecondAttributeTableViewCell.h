//
//  XFJSecondAttributeTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/7.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

//只可输入数字
#define KCellIdentifier_XFJSecondAttributeTableViewCell @"XFJSecondAttributeTableViewCell"

#import <UIKit/UIKit.h>

typedef void(^ReturnTextFieldBlock)(NSString *, NSString *);

@interface XFJSecondAttributeTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, copy) ReturnTextFieldBlock numberTextBlock;

@property (nonatomic, copy) NSString *teamAttr;
@property (nonatomic, copy) NSString *userId;

@end
