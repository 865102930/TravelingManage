//
//  XFJLeftTableFooterView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/9.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XFJLeftTableFooterViewDelegate  <NSObject>

//跳转到待完善界面
- (void)pushMineTeamController:(NSInteger)strNumber;
//跳转到待审核界面
//跳转到待评价界面
//跳转到全部任务界面


@end

@interface XFJLeftTableFooterView : UIView

@property (nonatomic, copy) void(^addFooterViewHeightBlock)();

@property (nonatomic, copy) void(^reduceFooterViewHeightBlock)();

@property (nonatomic, weak) id <XFJLeftTableFooterViewDelegate> delegate;

@end
