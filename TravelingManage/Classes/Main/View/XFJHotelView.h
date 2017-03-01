//
//  XFJHotelView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/26.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFJHotelView : UIView

@property (nonatomic, copy) void (^hotelSignButtonClickBlock)();
@property (nonatomic, copy) void (^hotelPopelSignBlock)(NSString *, BOOL);
//将用户输入的房间数量传出去
@property (nonatomic, copy) void (^HotelSignRoomCountBlock)(NSString *);
//是否改动了人数
@property (nonatomic, assign) BOOL isHotelCount;

@end
