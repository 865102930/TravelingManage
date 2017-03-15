//
//  XFJFindTeamTaskItem.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/13.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFJFindTeamTaskItem : NSObject

//任务id
@property (nonatomic, assign) NSInteger findTeamTaskItem_id;
//团队id
@property (nonatomic, assign) NSInteger teamId;
//用户id
@property (nonatomic, assign) NSInteger userId;
//景点id
@property (nonatomic, assign) NSInteger attractionsId;
//签到状态：0：签到 1：签退
@property (nonatomic, assign) NSInteger taskState;
//签到人数
@property (nonatomic, assign) NSInteger checkinNumber;
//签到时间
@property (nonatomic, strong) NSString *CreateTime;
//类型区分 0:景点 1:酒店
@property (nonatomic, assign) NSInteger typeState;


@end
