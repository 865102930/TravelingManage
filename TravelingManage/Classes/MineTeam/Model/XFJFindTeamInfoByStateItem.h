//
//  XFJFindTeamInfoByStateItem.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/1.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XFJStateType) {
    /** 任务中 */
    XFJStateTypeAll = 0,
    /** 待完善 */
    XFJStateTypePleasePerfect = 1,
    /** 待审核 */
    XFJStateTypePleaseCheck = 2,
    /** 已审核 */
    XFJStateTypeAlreadyCheck = 3,
    /** 审核不通过 */
    XFJStateTypeNOPassCheck = 4,
    //评价
    XFJStateTypePleaseAsking = 5,
};


@interface XFJFindTeamInfoByStateItem : NSObject

//团队编号
@property (nonatomic, strong) NSString *teamNo;
//团队人数
@property (nonatomic, assign) NSInteger teamNum;
//出团日期
@property (nonatomic, strong) NSString *teamDate;
//团队id
@property (nonatomic, assign) NSInteger findTeamInfoByState_Id;
//旅行社名称
@property (nonatomic, strong) NSString *travelAgencyName;
//状态：0:任务中 1:待完善 2:待审核 3:已审核 4:审核不通过
@property (nonatomic, assign) NSInteger teamState;
//管理员名称
@property (nonatomic, strong) NSString *userName;

//创建团队的省份
@property (nonatomic, strong) NSString *province;
//创建团队的市
@property (nonatomic, strong) NSString *city;
//创建团队的区
@property (nonatomic, strong) NSString *area;
//创建团队选择的目的属性
@property (nonatomic, strong) NSString *teamAttr;
//创建团队选择的团队性质
@property (nonatomic, strong) NSString *teamNature;
//创建团队填写的行程天数
@property (nonatomic, strong) NSString *teamDay;

//旅行社id
@property (nonatomic, assign) NSInteger travelAgencyId;



@end
