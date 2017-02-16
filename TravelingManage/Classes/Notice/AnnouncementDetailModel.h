//
//  AnnouncementDetailModel.h
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/15.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnnouncementDetailModel : NSObject

@property (nonatomic, strong) NSString *announcementTitle;//公告标题

@property (nonatomic, strong) NSString *announcementDetail;//公告详情

@property (nonatomic, strong) NSString *announcementImage;//公告图片

@property (nonatomic, strong) NSString *deleteflg;//删除状态 0:未删除 1:已删除

@property (nonatomic, assign) NSInteger AnnouncementDetailModel_id;//编号

@property (nonatomic, strong) NSString *createtime;//创建时间

@property (nonatomic, strong) NSString *updatetime;//更新时间

@property (nonatomic, assign) CGFloat cellHeight;

@end
