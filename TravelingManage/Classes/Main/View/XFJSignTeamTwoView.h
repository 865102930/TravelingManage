//
//  XFJSignTeamTwoView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/10.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFJSignTeamTwoView : UIView

//景点
@property (nonatomic, strong) NSMutableArray *scenery_array;
//酒店
@property (nonatomic, strong) NSMutableArray *hotel_array;

@property (nonatomic, strong) NSMutableArray *scenery_array2;

@property (nonatomic, strong) NSMutableArray *hotel_array2;

@property (nonatomic, copy) void (^scenerySign_Block)();

@property (nonatomic, copy) void (^hotelSign_block)();

@end
