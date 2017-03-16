//
//  XFJLeftTableHeaderView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XFJLeftTableHeaderViewDelegate <NSObject>

@required
- (void)pushToNoticeOfController;

@end

@interface XFJLeftTableHeaderView : UIView

@property (nonatomic, copy) void(^changeUserInformationBlock)();
@property (nonatomic, weak) id <XFJLeftTableHeaderViewDelegate> delegate;

@end
