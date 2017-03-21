//
//  XFJFindAttracUserListItem.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/21.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFJFindAttracUserListItem : NSObject

//景区id
@property (nonatomic, strong) NSString *attractionsId;
//管理员id
@property (nonatomic, strong) NSString *userId;
//停留时间（h）
@property (nonatomic, strong) NSString *attractionsTime;
//管理员名称
@property (nonatomic, strong) NSString *userName;
//id
@property (nonatomic, assign) NSInteger findAttracUserList_id;

@end
