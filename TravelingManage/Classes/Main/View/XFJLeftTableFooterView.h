//
//  XFJLeftTableFooterView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/9.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XFJLeftTableFooterViewDelegate  <NSObject>

- (void)pushMineTeamController;

@end

@interface XFJLeftTableFooterView : UIView

@property (nonatomic, copy) void(^addFooterViewHeightBlock)();

@property (nonatomic, copy) void(^reduceFooterViewHeightBlock)();

@property (nonatomic, weak) id <XFJLeftTableFooterViewDelegate> delegate;

@end
