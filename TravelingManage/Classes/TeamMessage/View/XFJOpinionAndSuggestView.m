//
//  XFJOpinionAndSuggestView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/6.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJOpinionAndSuggestView.h"
#import "UIPlaceHolderTextView.h"

@interface XFJOpinionAndSuggestView() <UITextViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIPlaceHolderTextView *textView;
@property (nonatomic, strong) UIView *line_view;
@property (nonatomic, strong) UIView *middle_view;

@end

@implementation XFJOpinionAndSuggestView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.textView];
        [self addSubview:self.line_view];
        [self addSubview:self.middle_view];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(1);
            make.right.equalTo(self.mas_right).offset(-17);
            make.left.equalTo(self.mas_left).offset(17);
            make.bottom.equalTo(self.mas_bottom).offset(-8);
        }];
        [self.line_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(3.0);
            make.top.mas_equalTo(self.mas_top);
        }];
        [self.middle_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-25.0);
        }];
    }
    return self;
}

- (UIPlaceHolderTextView *)textView
{
    if (_textView == nil) {
        _textView = [[UIPlaceHolderTextView alloc] initWithFrame:self.bounds];
        _textView.placeholder = @"请输入您的意见或者建议...";
        _textView.placeholderColor = [UIColor lightGrayColor];
        _textView.delegate = self;
        if (_textView.contentSize.height >= _textView.frame.size.height) {
            [_textView setUserInteractionEnabled:YES];
        }
    }
    return _textView;
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColoreeee;
    }
    return _line_view;
}

- (UIView *)middle_view
{
    if (_middle_view == nil) {
        _middle_view = [[UIView alloc] init];
        _middle_view.backgroundColor = kColorE0E0;
    }
    return _middle_view;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.textViewTextBlock) {
        self.textViewTextBlock(textView.text);
    }
}

@end
