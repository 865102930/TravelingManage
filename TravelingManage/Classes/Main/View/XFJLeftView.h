//
//  XFJLeftView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFJLeftFindTeamInfoItem.h"

@protocol XFJLeftViewDelegate <NSObject>

@required
- (void)touchViewWithWidth:(NSInteger)width;
- (void)backLeftVeiw;
- (void)pushPersonalDataController;
@optional

@end

@interface XFJLeftView : UIView

@property (nonatomic, weak) id <XFJLeftViewDelegate>delegate;

@property (nonatomic, assign) CGFloat touchWidth;

@property (nonatomic, copy) void (^pushMineTeamBlock)(NSInteger);
//退出登录
@property (nonatomic, copy) void (^logoutUserBlock)();
//全部控制器
@property (nonatomic, copy) void (^pushAllTeamTaskBlock)();
//待审核
@property (nonatomic, copy) void (^pushCheckTeamBlock)();
//待评价
@property (nonatomic, copy) void (^pushPleaseAskingBlock)();
//点击侧滑栏跳转到主界面
@property (nonatomic, copy) void (^presentToHomeController)(XFJLeftFindTeamInfoItem *,BOOL);
//跳转到通知页面
@property (nonatomic, copy) void (^pushNoticeWithHeaderBlock)();

//提供一个BOOL值作为判断
@property (nonatomic, assign) BOOL isTeamId;

@end
