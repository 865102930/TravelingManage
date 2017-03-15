//
//  XFJTaskItemSecondModel.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/15.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "XFJTasksItemModel.h"

@protocol XFJTasksItemModel


@end

@interface XFJTaskItemSecondModel : JSONModel

@property (nonatomic, strong) NSMutableArray <XFJTasksItemModel> *taskItemModels;

@end
