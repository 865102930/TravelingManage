//
//  XFJCarNumberItem.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/21.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFJCarNumberItem : NSObject

//省份
@property (nonatomic, strong) NSString *province;

//城市
@property (nonatomic, strong) NSString *city;

//车牌前两个数字
@property (nonatomic, strong) NSString *plateHead;

@end
