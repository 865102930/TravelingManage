//
//  XFJFindTravelAgencyListItem.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/22.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFJFindTravelAgencyListItem : NSObject

//旅行社id
@property (nonatomic, assign) NSInteger findTravelAgencyList_id;

//旅行社名字
@property (nonatomic, strong) NSString *taName;

//旅行社地址
@property (nonatomic, strong) NSString *taAddress;

@end
