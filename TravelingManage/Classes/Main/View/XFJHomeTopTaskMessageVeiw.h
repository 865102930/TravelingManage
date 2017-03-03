//
//  XFJHomeTopTaskMessageVeiw.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/20.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFJLaterTeamControlItem.h"

@interface XFJHomeTopTaskMessageVeiw : UIView

@property (nonatomic, copy) void (^jumpWithTeamMessageBlock)();
//任务状态的改变
@property (nonatomic, copy) void (^ExitStatusButtonClickBlock)();

@property (nonatomic, strong) XFJLaterTeamControlItem *laterTeamControlItem;

@end
