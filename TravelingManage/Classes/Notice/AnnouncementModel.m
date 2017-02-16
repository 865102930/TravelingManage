//
//  AnnouncementModel.m
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/13.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "AnnouncementModel.h"

@implementation AnnouncementModel
- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}
//模型属性:JSON key,MJExtension会自动将JSON的key替换为你模型中需要的属性\
description与系统的冲突.换成大写D
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"AnnouncementModel_id":@"id",
             };
}
@end
