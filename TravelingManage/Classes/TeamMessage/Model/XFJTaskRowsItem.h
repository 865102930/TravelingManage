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
@property (nonatomic, strong) NSString *signTime;
//签退时间
@property (nonatomic, strong) NSString *signoutTime;




@end
