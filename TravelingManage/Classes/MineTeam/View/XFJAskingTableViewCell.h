//
//  XFJAskingTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/3.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFJFindTeamInfoByStateItem.h"

@interface XFJAskingTableViewCell : UITableViewCell

@property (nonatomic, strong) XFJFindTeamInfoByStateItem *findTeamInfoByStateItem;
@property (nonatomic, copy) void (^againStartButtonClickBlock)(UIButton *);

+ (CGFloat)cellHeight;

@end
