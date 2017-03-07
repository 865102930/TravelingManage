//
//  XFJSignAppraiseTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/6.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFJTaskRowsItem.h"

@interface XFJSignAppraiseTableViewCell : UITableViewCell

@property (nonatomic, strong) XFJTaskRowsItem *findTeamTasksItemArray;
//评分1
@property (nonatomic, copy) void (^teamScoreBlock1)(NSString *,NSInteger);
//评分2
@property (nonatomic, copy) void (^teamScoreBlock2)(NSString *,NSInteger);
//评分3
@property (nonatomic, copy) void (^teamScoreBlock3)(NSString *,NSInteger);
@end
