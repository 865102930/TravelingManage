//
//  MessageModel.h
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/13.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic, strong) NSString *messageTitle;//消息标题

@property (nonatomic, strong) NSString *messageDetail;//消息

@property (nonatomic, strong) NSString *isread;//是否读取 0:未读 1:已读

@property (nonatomic, strong) NSString *userId;//导游id]

@property (nonatomic, strong) NSString *createtime;//创建时间

@property (nonatomic, assign) int message_id;//消息id

@end
