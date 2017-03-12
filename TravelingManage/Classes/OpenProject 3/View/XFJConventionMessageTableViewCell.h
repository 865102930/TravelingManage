//
//  XFJConventionMessageTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/10.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "XFJFindTeamInfoByStateItem.h"
@interface XFJConventionMessageTableViewCell : UIView

//团队编号
@property (nonatomic, strong) NSString *groupName_text;

//出团日期
@property (nonatomic, strong) NSString *groupTime_text;

//旅行社名称
@property (nonatomic, assign) NSInteger travelName;

@property (nonatomic, strong) XFJFindTeamInfoByStateItem *findTeamInfoByStateItem;


@end
