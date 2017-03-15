//
//  XFJFindTeamTasksItem.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/4.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJFindTeamTasksItem.h"
//#import <MJExtension.h>

@implementation XFJFindTeamTasksItem

//告诉MJE框架,里面是个数组模型
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"tasks":@"TasksItem"
             };
}

@end

