//
//  XFJLeftTableFooterView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/9.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XFJLeftTableFooterView;
@protocol XFJLeftTableFooterViewDelegate  <NSObject>

//跳转到待完善界面
- (void)pushMineTeamController:(NSInteger)strNumber;
//跳转到待审核界面
- (void)pushToPleaseCheckTeamController:(NSInteger)strNumber;
//跳转到待评价界面
- (void)pushToPleaseAskingTeamController:(NSInteger)strNmuber;
//跳转到全部任务界面
- (void)pushToAllTaskingTeamController;
//退出按钮
- (void)exitButtonClick:(XFJLeftTableFooterView *)leftTableFooterView;
@end

@interface XFJLeftTableFooterView : UIView

@property (nonatomic, copy) void(^addFooterViewHeightBlock)();

@property (nonatomic, copy) void(^reduceFooterViewHeightBlock)();

@property (nonatomic, weak) id <XFJLeftTableFooterViewDelegate> delegate;

@end
