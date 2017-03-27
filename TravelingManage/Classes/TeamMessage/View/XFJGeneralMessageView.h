//
//  XFJGeneralMessageView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/4.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFJFindTeamTasksItem.h"
#import "XFJFindTeamCarItem.h"

@interface XFJGeneralMessageView : UIView

@property (nonatomic, strong) NSMutableArray <XFJFindTeamTasksItem *> *findTeamTasksItem;

//提供一个属性接收团队id
@property (nonatomic, strong) NSMutableArray <XFJFindTeamCarItem *> *findTeamCarItem;

@end
