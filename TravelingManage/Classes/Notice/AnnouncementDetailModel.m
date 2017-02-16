//
//  AnnouncementDetailModel.m
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/15.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "AnnouncementDetailModel.h"

@implementation AnnouncementDetailModel
- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

- (CGFloat)cellHeight
{
    // 如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;

    // 文字的Y值
    _cellHeight += 46;
    
    // 文字的高度
    CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH - 88, MAXFLOAT);
    // 计算内容label的高度
    CGFloat textH = [self.announcementDetail boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
    _cellHeight += textH + 50;
    return _cellHeight;
}

//模型属性:JSON key,MJExtension会自动将JSON的key替换为你模型中需要的属性\
description与系统的冲突.换成大写D
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"AnnouncementDetailModel_id":@"id",
             };
}
@end
