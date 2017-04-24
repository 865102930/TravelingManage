//
//  XFJTaskRowsItem.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/4.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFJTaskRowsItem : NSObject

//景点名称
@property (nonatomic, strong) NSString *attractionsName;
//签到人数
@property (nonatomic, assign) NSInteger checkinNumber;
//景区浏览时间
@property (nonatomic, strong) NSString *attractionsTime;
//景区id
@property (nonatomic, assign) NSInteger attractionsId;
//任务id
@property (nonatomic, assign) NSInteger taskId;
//签到时间
@property (nonatomic, strong) NSString *createtime;
//签退时间
@property (nonatomic, strong) NSString *signoutTime;

// teamID
@property (nonatomic, assign) NSInteger teamId;

// 凭证图片
@property (nonatomic, copy) NSString *taskImg;

@property (nonatomic, assign) NSInteger isRequire;

@property (nonatomic, assign) NSInteger finishState;

@end
