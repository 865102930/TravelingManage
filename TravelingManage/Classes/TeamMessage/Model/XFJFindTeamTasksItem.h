//
//  XFJFindTeamTasksItem.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/4.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TasksItem : NSObject
//景点id
@property (nonatomic, assign) NSInteger attractionsId;
//景点名称
@property (nonatomic, strong) NSString *attractionsName;
//任务id
@property (nonatomic, assign) NSInteger taskId;

@end

@interface XFJFindTeamTasksItem : NSObject

//团队编号
@property (nonatomic, assign) NSInteger teamNo;
//出团时间
@property (nonatomic, strong) NSString *teamDate;
//省
@property (nonatomic, strong) NSString *province;
//市
@property (nonatomic, strong) NSString *city;
//区
@property (nonatomic, strong) NSString *area;
//团队人数
@property (nonatomic, assign) NSInteger teamNum;
//行程天数
@property (nonatomic, assign) NSInteger teamDay;
//旅行社名称
@property (nonatomic, strong) NSString *travelAgencyName;
//团队目的属性
@property (nonatomic, strong) NSString *teamAttrVal;
//团队性质
@property (nonatomic, strong) NSString *teamNatureVal;
//车辆
@property (nonatomic, strong) NSString *vehicleNo;
//景区名称
@property (nonatomic, strong) NSString *attractionsName;

//添加的图片
@property (nonatomic, strong) UIImage *image_view;
//任务数组
@property (nonatomic, strong) NSArray <TasksItem * >*tasks;

@end
