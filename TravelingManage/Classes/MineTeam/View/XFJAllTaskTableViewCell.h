//
//  XFJAllTaskTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/15.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#define KCellIdentifier_XFJAllTaskTableViewCell @"XFJAllTaskTableViewCell"


#import <UIKit/UIKit.h>
#import "XFJFindTeamInfoByStateItem.h"


@interface XFJAllTaskTableViewCell : UITableViewCell

@property (nonatomic, strong) XFJFindTeamInfoByStateItem *findTeamInfoByStateItem;

+ (CGFloat)cellHeight;

@end
