//
//  XFJLeftView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XFJLeftViewDelegate <NSObject>

@required
- (void)touchViewWithWidth:(NSInteger)width;
- (void)backLeftVeiw;
@optional

@end

@interface XFJLeftView : UIView

@property (nonatomic, weak) id <XFJLeftViewDelegate>delegate;

@property (nonatomic, assign) CGFloat touchWidth;

@property (nonatomic, copy) void (^pushMineTeamBlock)();

@end
