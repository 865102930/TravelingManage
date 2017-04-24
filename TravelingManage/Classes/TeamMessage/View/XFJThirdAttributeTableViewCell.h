//
//  XFJThirdAttributeTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

//多行
#define KCellIdentifier_XFJThirdAttributeTableViewCell @"XFJThirdAttributeTableViewCell"

#import <UIKit/UIKit.h>

typedef void(^ReturnTextFieldBlock)(NSString *, NSString *);

@interface XFJThirdAttributeTableViewCell : UITableViewCell

@property (nonatomic, copy) ReturnTextFieldBlock mulitBlock;

@property (nonatomic, copy) NSString *teamAttr;

@property (nonatomic, assign) NSInteger finishState;
@property (nonatomic, copy) NSString *userId;

@end
