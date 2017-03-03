//
//  XFJLeftViewTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#define KCellIdentifier_XFJLeftViewTableViewCell @"XFJLeftViewTableViewCell"


#import <UIKit/UIKit.h>
#import "XFJLeftFindTeamInfoItem.h"

@interface XFJLeftViewTableViewCell : UITableViewCell

@property (nonatomic, strong) XFJLeftFindTeamInfoItem *leftFindTeamInfoItem;

+ (CGFloat)cellHeight;

@end
