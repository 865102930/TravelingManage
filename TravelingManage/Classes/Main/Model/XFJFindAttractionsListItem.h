//
//  XFJFindAttractionsListItem.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/23.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFJFindAttractionsListItem : NSObject

//景区id
@property (nonatomic, assign) NSInteger findAttractions_id;

//景点名称
@property (nonatomic, strong) NSString *attractionsName;

//景点类型
@property (nonatomic, assign) NSInteger attractionsSort;

//省
@property (nonatomic, strong) NSString *province;

//市
@property (nonatomic, strong) NSString *city;

//区
@property (nonatomic, strong) NSString *area;

//类型区分 0:景区 1:酒店
@property (nonatomic, assign) NSInteger typeState;

//景点的坐标
@property (nonatomic, strong) NSString *locationPoints;



@end
