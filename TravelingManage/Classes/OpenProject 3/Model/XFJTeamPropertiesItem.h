//
//  XFJTeamPropertiesItem.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/21.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFJTeamPropertiesItem : NSObject

//团队属性
@property (nonatomic, strong) NSString *explainName;

//团队属性类型
@property (nonatomic, strong) NSString *paramName;

//团队性质id
@property (nonatomic, assign) NSInteger teamProperties_id;

@property (nonatomic, assign) NSInteger paramVal;

@end
