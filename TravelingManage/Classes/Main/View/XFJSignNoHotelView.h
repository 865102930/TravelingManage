//
//  XFJSignNoHotelView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/26.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFJFindTeamTaskItem.h"
#import "XFJLaterTeamControlItem.h"

@interface XFJSignNoHotelView : UIView

@property (nonatomic, strong) NSString *hotelSignPeopleCount;
@property (nonatomic, strong) NSString *hotelSignRoomCount;
//天数
@property (nonatomic, assign) NSInteger hotelStayDay;

//小时
@property (nonatomic, assign) NSInteger hotelStayHour;

@property (nonatomic, copy) void (^hotelSignNoButtonClickBlock)();

@property (nonatomic, strong) XFJFindTeamTaskItem *findTeamTaskItem;

@property (nonatomic, strong) XFJLaterTeamControlItem *laterTeamControlItem;

@end
