//
//  XFJLeftFindTeamInfoItem.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/2.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFJLeftFindTeamInfoItem : NSObject

//团队编号
@property (nonatomic, strong) NSString *teamNo;
//人数
@property (nonatomic, strong) NSString *teamNum;
//客源地
@property (nonatomic, strong) NSString *province;//省
@property (nonatomic, strong) NSString *city;//市
@property (nonatomic, strong) NSString *area;//区
//车牌号
@property (nonatomic, strong) NSString *vehicleNo;
//团队id
@property (nonatomic, assign) NSInteger findTeamInfoItem_id;
//开团时间
@property (nonatomic, strong) NSString *teamDate;
//状态值：0:任务中 1:待完善 2:待审核 3:已审核 4:审核不通过
@property (nonatomic, assign) NSInteger teamState;

@end
