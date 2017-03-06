//
//  XFJTeamMessageTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/4.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#define KCellIdentifier_XFJTeamMessageTableViewCell @"XFJTeamMessageTableViewCell"

#import <UIKit/UIKit.h>
#import "XFJTaskRowsItem.h"
@interface XFJTeamMessageTableViewCell : UITableViewCell

@property (nonatomic, strong) XFJTaskRowsItem *taskRowsItem;

@end
