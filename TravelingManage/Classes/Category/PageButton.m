//
//  PageButton.m
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/10.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "PageButton.h"

@implementation PageButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:RedColor forState:UIControlStateSelected];
        [self setTitleColor:kColor6565 forState:UIControlStateNormal];
    }
    return self;
}

// 不让按钮达到高亮状态
- (void)setHighlighted:(BOOL)highlighted {}




@end
