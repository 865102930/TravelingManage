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

@end
