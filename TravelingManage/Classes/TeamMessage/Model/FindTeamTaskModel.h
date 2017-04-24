//
//  FindTeamTaskModel.h
//  TravelingManage
//
//  Created by gz on 17/4/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindTeamTaskModel : NSObject

@property (nonatomic, copy) NSString *attrName; // 字段类型
@property (nonatomic, copy) NSString *attrType; //文本的类型
@property (nonatomic, copy) NSString *teamAttr; //back
@property (nonatomic, copy) NSString *Uid; // id
@property (nonatomic, copy) NSString *userId; // 用户id
@property (nonatomic, copy) NSString *userName; // 用户名称
@property (nonatomic, assign) NSInteger isRequire; //是否必传参数

@end
