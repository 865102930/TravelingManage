//
//  XFJThirdAttributeTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

/*
 *  多行输入
 *  多行输入
 *  多行输入
 */

#import "XFJThirdAttributeTableViewCell.h"

#define const_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define const_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define const_ScreenChinge(A) (A) * [UIScreen mainScreen].bounds.size.width/375

@interface XFJThirdAttributeTableViewCell()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIImageView *textView_imageView;
@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) UIImageView *star_imageView;

@end

@implementation XFJThirdAttributeTableViewCell

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        [self addSubview:self.textView];
//        [self.textView addSubview:self.textView_imageView];
//        [self.textView addSubview:self.title_label];
//        [self.textView addSubview:self.star_imageView];
//        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
//            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
//            make.height.mas_equalTo(90.0);
//            make.top.mas_equalTo(9.0);
//        }];
//        [self.textView_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
//            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
//            make.height.mas_equalTo(90.0);
//            make.top.mas_equalTo(0);
//        }];
//        [self.title_label mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.textView).mas_offset(15.0);
//            make.top.mas_equalTo(self.textView.mas_top).mas_offset(9.0);
//        }];
//        [self.star_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(self.title_label.mas_centerY);
//            make.height.with.mas_equalTo(4.0);
//            make.left.mas_equalTo(self.title_label.mas_right).mas_offset(2.0);
//        }];
//    }
//    return self;
//}
//- (UIPlaceHolderTextView *)textView
//{
//    if (_textView == nil) {
//        _textView = [[UIPlaceHolderTextView alloc] init];
//        _textView.placeholderColor = [UIColor lightGrayColor];
//        _textView.tintColor = [UIColor lightGrayColor];
//        if (_textView.contentSize.height >= _textView.frame.size.height) {
//            [_textView setUserInteractionEnabled:YES];
//        }
//        _textView.textContainerInset = UIEdgeInsetsMake(9.0, 100, 0, 0);
//    }
//    return _textView;
//}
//
//- (UIImageView *)textView_imageView
//{
//    if (_textView_imageView == nil) {
//        _textView_imageView = [[UIImageView alloc] init];
//        _textView_imageView.image = [UIImage originalWithImage:@"big-input"];
//    }
//    return _textView_imageView;
//}
//
//- (UILabel *)title_label
//{
//    if (_title_label == nil) {
//        _title_label = [[UILabel alloc] init];
//        _title_label.text = @"多行文本";
//        _title_label.font = [UIFont systemFontOfSize:13.0];
//        _title_label.textColor = kColor2f2f;
//    }
//    return _title_label;
//}
//
//- (UIImageView *)star_imageView
//{
//    if (_star_imageView == nil) {
//        _star_imageView = [[UIImageView alloc] init];
//        _star_imageView.image = [UIImage originalWithImage:@"xinghao"];
//    }
//    return _star_imageView;
//}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    self.textView_imageView = [[UIImageView alloc] init];
    self.textView_imageView.image = [UIImage imageNamed:@"big-input"];
    self.textView_imageView.userInteractionEnabled = YES;
    [self addSubview:self.textView_imageView];
    
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:const_ScreenChinge(13)];
    [self.textView_imageView addSubview:self.textView];
    
    self.title_label = [[UILabel alloc] init];
    self.title_label.text = @"多行文本";
    self.title_label.font = [UIFont systemFontOfSize:const_ScreenChinge(13)];
    [self.textView_imageView addSubview:self.title_label];
    
    self.star_imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xinghao"]];
    [self.textView_imageView addSubview:self.star_imageView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textView_imageView.frame = CGRectMake(const_ScreenChinge(18), const_ScreenChinge(9), const_ScreenWidth - const_ScreenChinge(36), const_ScreenChinge(90));
    self.title_label.frame = CGRectMake(const_ScreenChinge(15), const_ScreenChinge(9), const_ScreenChinge(60), const_ScreenChinge(20));
    self.star_imageView.frame = CGRectMake(CGRectGetMaxX(self.title_label.frame) + const_ScreenChinge(3), CGRectGetMidY(self.title_label.frame) - const_ScreenChinge(3), const_ScreenChinge(6), const_ScreenChinge(6));
    self.textView.frame = CGRectMake(CGRectGetMaxX(self.star_imageView.frame) + const_ScreenChinge(9), CGRectGetMinY(self.title_label.frame) - const_ScreenChinge(5), CGRectGetWidth(self.textView_imageView.frame) - CGRectGetMaxX(self.star_imageView.frame) - const_ScreenChinge(20), CGRectGetHeight(self.textView_imageView.frame) - const_ScreenChinge(18));
}

#pragma mark - UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.mulitBlock(textView.text, self.teamAttr);
}


@end










