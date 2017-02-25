//
//  XFJSceneryAnnotation.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/23.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

//显示景点的大头针视图
#import <MAMapKit/MAMapKit.h>
#import "XFJFindAttractionsListItem.h"

@interface XFJSceneryAnnotation : MAPointAnnotation

//景点名字
@property (nonatomic, strong) NSString *attractionsName;

//景点类型分类
@property (nonatomic, assign) NSInteger typeState;

@end
