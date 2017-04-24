//
//  XFJSignMessageViewController.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/2.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFJTaskRowsItem.h"
#import "XFJFindTeamTasksItem.h"

@interface XFJSignMessageViewController : UIViewController

@property (nonatomic, strong) XFJTaskRowsItem *taskRowsItem;

@property (nonatomic, assign) NSInteger findNewTeamInfo_Id;


@end
