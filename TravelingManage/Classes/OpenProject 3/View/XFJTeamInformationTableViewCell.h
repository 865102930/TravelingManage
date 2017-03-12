//
//  XFJTeamInformationTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/14.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "XFJFindTeamInfoByStateItem.h"
@interface XFJTeamInformationTableViewCell : UIView

//团队人数
@property (nonatomic, strong) NSString *teamPeople_number;

//团队性质
@property (nonatomic, assign) NSInteger teamNature;

//行程天数
@property (nonatomic, strong) NSString *teamDay;

@property (nonatomic, strong) XFJFindTeamInfoByStateItem *findTeamInfoByStateItem;


@end
