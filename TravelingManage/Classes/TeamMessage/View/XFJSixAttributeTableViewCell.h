//
//  XFJSixAttributeTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

//时间选择
#define KCellIdentifier_XFJSixAttributeTableViewCell @"XFJSixAttributeTableViewCell"

typedef void(^ReturnDateBlock)(NSString *, NSString *);

#import <UIKit/UIKit.h>

@interface XFJSixAttributeTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *teamAtt;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) ReturnDateBlock dateBlock;

@end
