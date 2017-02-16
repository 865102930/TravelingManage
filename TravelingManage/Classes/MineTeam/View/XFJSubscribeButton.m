//
//  XFJSubscribeButton.m
//  WeiLook
//
//  Created by 肖锋 on 16/11/27.
//  Copyright © 2016年 XFJ. All rights reserved.
//

#import "XFJSubscribeButton.h"

@interface XFJSubscribeButton()


@end

@implementation XFJSubscribeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self setTitleColor:kColor6565 forState:UIControlStateNormal];
        [self setTitleColor:kColorff47 forState:UIControlStateSelected];
    }
    return self;
}


//取消高亮状态
- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
