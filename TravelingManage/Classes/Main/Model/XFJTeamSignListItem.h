//
//  XFJTeamSignListItem.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/27.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFJTeamSignListItem : NSObject

//景区id
@property (nonatomic, assign) NSInteger teamSignList_id;
//团队id
@property (nonatomic, assign) NSInteger teamId;
//管理员id
@property (nonatomic, assign) NSInteger userId;
//签到状态 0:已签到 1:已签退
@property (nonatomic, assign) NSInteger taskState;
//是否异常
@property (nonatomic, assign) BOOL isUnusual;
//异常原因
@property (nonatomic, strong) NSString *unusualComment;
//签到人数
@property (nonatomic, assign) NSInteger checkinNumber;
//停留时间
@property (nonatomic, strong) NSString *attractionsTime;
//景区自定义属性（json格式）
@property (nonatomic, strong) NSString *taskBack;
//房间数
@property (nonatomic, assign) NSInteger rooms;

@end
