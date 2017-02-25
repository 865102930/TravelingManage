//
//  XFJHeaderView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/25.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJHeaderView.h"

@implementation XFJHeaderView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    UITableView *firTableView = [self viewWithTag:10001];
    if (view == nil) {
        CGPoint tempoint = [firTableView convertPoint:point fromView:self];
        if (CGRectContainsPoint(firTableView.bounds, tempoint))
        {
            view = firTableView;
        }
    }
    return view;
}

@end
