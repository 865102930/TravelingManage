//
//  XFJTasksItemModel.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/15.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface XFJTasksItemModel : JSONModel

//景点id
@property (nonatomic, assign) NSInteger attractionsId;
//景点名称
@property (nonatomic, strong) NSString *attractionsName;
//任务id
@property (nonatomic, assign) NSInteger taskId;

@end
