//
//  XFJLaterTeamControlItem.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/3.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFJLaterTeamControlItem : NSObject

//团队编号
@property (nonatomic, strong) NSString *teamNo;
//省
@property (nonatomic, strong) NSString *province;
//市
@property (nonatomic, strong) NSString *city;
//区
@property (nonatomic, strong) NSString *area;
//开团时间
@property (nonatomic, strong) NSString *teamDate;
//0:签到 1:签退  (根据这个来判断下面显示的是什么信息)
@property (nonatomic, strong) NSString *taskState;

@end
