//
//  XFJSignNoPeopleView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/24.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFJTeamSignListItem.h"
#import "XFJFindTeamTaskItem.h"
#import "XFJLaterTeamControlItem.h"
@interface XFJSignNoPeopleView : UIView

//签退时候调用的block
@property (nonatomic, copy) void (^signNoButtonClickBlock)();
//签退页面的人数
@property (nonatomic, strong) NSMutableArray<XFJTeamSignListItem *> *signNoPeopleArray;
//获取到的小时
@property (nonatomic, strong) NSString *hourTeamTime;
//获取到的分钟
@property (nonatomic, strong) NSString *minteTeamTime;

@property (nonatomic, strong) XFJFindTeamTaskItem *findTeamTaskItem;

//用一个属性用来接收人数
@property (nonatomic, assign) NSInteger teamNum;

@property (nonatomic, strong) XFJLaterTeamControlItem *laterTeamControlItem;


@end
