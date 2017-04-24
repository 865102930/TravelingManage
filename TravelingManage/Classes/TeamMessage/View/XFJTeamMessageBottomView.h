//
//  XFJTeamMessageBottomView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/4.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFJTaskRowsItem.h"

@interface XFJTeamMessageBottomView : UIView


@property (nonatomic, assign) NSInteger findTeamInfoByState_Id;
//确认提交
@property (nonatomic, copy) void (^sureCommitBlock)(NSInteger);
@property (nonatomic, copy) void (^taskRowsItemArrayItemBlock)(XFJTaskRowsItem *);

@property (nonatomic, strong) UITableView *visitMessage_tableView;

@end
