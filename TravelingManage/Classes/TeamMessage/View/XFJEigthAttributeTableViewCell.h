//
//  XFJEigthAttributeTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

//多选框
#define KCellIdentifier_XFJEigthAttributeTableViewCell @"XFJEigthAttributeTableViewCell"

#import <UIKit/UIKit.h>

@interface XFJEigthAttributeTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^presentMaskViewBlock)(NSString *);

@property (nonatomic, strong) NSString *teamAttr;

@end
