//
//  XFJMaskView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/7.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFJMaskView : UIView

@property (nonatomic, copy) void(^maskBlock)();

- (instancetype)initWithFrame:(CGRect)frame;


@end
