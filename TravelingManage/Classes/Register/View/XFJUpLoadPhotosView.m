//
//  XFJUpLoadPhotosView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/4/17.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJUpLoadPhotosView.h"

@interface XFJUpLoadPhotosView()

@property (nonatomic, strong) UILabel *upLoadPhotos_label;
@property (nonatomic, strong) UIImageView *front_imageView;
@property (nonatomic, strong) UIImageView *firestStar_imageView;
@property (nonatomic, strong) UILabel *firestFront_label;

@property (nonatomic, strong) UIImageView *back_imageView;
@property (nonatomic, strong) UIImageView *secondStar_imageView;
@property (nonatomic, strong) UILabel *secondBack_label;

@property (nonatomic, strong) UIImageView *guide_imageView;
@property (nonatomic, strong) UIImageView *guideStar_imageView;
@property (nonatomic, strong) UILabel *guide_label;

@end

@implementation XFJUpLoadPhotosView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
        [self masUI];
    }
    return self;
}

#pragma mark - 添加控件
- (void)creatUI
{
    [self addSubview:self.upLoadPhotos_label];
    [self addSubview:self.front_imageView];
    [self addSubview:self.firestFront_label];
    [self addSubview:self.firestStar_imageView];
    
    [self addSubview:self.back_imageView];
    [self addSubview:self.secondBack_label];
    [self addSubview:self.secondStar_imageView];
    
    [self addSubview:self.guide_imageView];
    [self addSubview:self.guide_label];
    [self addSubview:self.guideStar_imageView];
}
#pragma mark - 布局控件
- (void)masUI
{
    [self.upLoadPhotos_label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
    }];
    [self.front_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.upLoadPhotos_label.mas_left);
        make.top.mas_equalTo(self.upLoadPhotos_label.mas_bottom).mas_offset(22.0);
        make.height.width.mas_equalTo(62.0);
    }];
    [self.firestFront_label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.front_imageView.mas_centerX);
        make.top.mas_equalTo(self.front_imageView.mas_bottom).mas_offset(9.0);
    }];
    [self.firestStar_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.firestFront_label.mas_left).mas_offset(-5.0);
        make.centerY.mas_equalTo(self.firestFront_label.mas_centerY);
        make.height.width.mas_equalTo(5.0);
    }];
    [self.back_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.front_imageView.mas_right).mas_offset(18.0);
        make.centerY.mas_equalTo(self.front_imageView.mas_centerY);
        make.height.width.mas_equalTo(62.0);
    }];
    [self.secondBack_label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.back_imageView.mas_centerX);
        make.top.mas_equalTo(self.back_imageView.mas_bottom).mas_offset(9.0);
    }];
    [self.secondStar_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.secondBack_label.mas_left).mas_offset(-5.0);
        make.centerY.mas_equalTo(self.secondBack_label.mas_centerY);
        make.height.width.mas_equalTo(5.0);
    }];
    [self.guide_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.back_imageView.mas_right).mas_offset(18.0);
        make.centerY.mas_equalTo(self.back_imageView.mas_centerY);
        make.height.width.mas_equalTo(62.0);
    }];
    [self.guide_label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.guide_imageView.mas_centerX);
        make.top.mas_equalTo(self.guide_imageView.mas_bottom).mas_offset(9.0);
    }];
    [self.guideStar_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.guide_label.mas_left).mas_offset(-5.0);
        make.centerY.mas_equalTo(self.guide_label.mas_centerY);
        make.height.width.mas_equalTo(5.0);
    }];
    UITapGestureRecognizer *front_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(front_choosePhotoImage:)];
    UITapGestureRecognizer *back_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back_choosePhotoImage:)];
    UITapGestureRecognizer *guide_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(guide_choosePhotoImage:)];
    [self.front_imageView addGestureRecognizer:front_tap];
    [self.back_imageView addGestureRecognizer:back_tap];
    [self.guide_imageView addGestureRecognizer:guide_tap];
}

- (void)front_choosePhotoImage:(UITapGestureRecognizer *)tap
{
    NSLog(@">>>>>>>>>>>----------tap的值是 :%@",tap);
    NSInteger frontStr = 1;
    if (self.choosePhotosBlock) {
        self.choosePhotosBlock(frontStr);
    }
}

- (void)back_choosePhotoImage:(UITapGestureRecognizer *)tap
{
    NSLog(@">>>>>>>>>>>----------tap的值是 :%@",tap);
    NSInteger frontStr = 2;
    if (self.choosePhotosBlock) {
        self.choosePhotosBlock(frontStr);
    }
}

- (void)guide_choosePhotoImage:(UITapGestureRecognizer *)tap
{
    NSLog(@">>>>>>>>>>>----------tap的值是 :%@",tap);
    NSInteger frontStr = 3;
    if (self.choosePhotosBlock) {
        self.choosePhotosBlock(frontStr);
    }
}

- (UILabel *)upLoadPhotos_label
{
    if (_upLoadPhotos_label == nil) {
        _upLoadPhotos_label = [[UILabel alloc] init];
        _upLoadPhotos_label.text = @"请上传身份证正反面照片和导游证照片";
        _upLoadPhotos_label.textColor = kColor5959;
        _upLoadPhotos_label.font = [UIFont fontWithName:PingFang size:12.0];
        _upLoadPhotos_label.textAlignment = NSTextAlignmentLeft;
    }
    return _upLoadPhotos_label;
}

- (UILabel *)firestFront_label
{
    if (_firestFront_label == nil) {
        _firestFront_label = [[UILabel alloc] init];
        _firestFront_label.text = @"正面照";
        _firestFront_label.textColor = kColor5959;
        _firestFront_label.font = [UIFont fontWithName:PingFang size:12.0];
        _firestFront_label.textAlignment = NSTextAlignmentCenter;
    }
    return _firestFront_label;
}
- (UILabel *)secondBack_label
{
    if (_secondBack_label == nil) {
        _secondBack_label = [[UILabel alloc] init];
        _secondBack_label.text = @"反面照";
        _secondBack_label.textColor = kColor5959;
        _secondBack_label.font = [UIFont fontWithName:PingFang size:12.0];
        _secondBack_label.textAlignment = NSTextAlignmentCenter;
    }
    return _secondBack_label;
}
- (UILabel *)guide_label
{
    if (_guide_label == nil) {
        _guide_label = [[UILabel alloc] init];
        _guide_label.text = @"导游证";
        _guide_label.textColor = kColor5959;
        _guide_label.font = [UIFont fontWithName:PingFang size:12.0];
        _guide_label.textAlignment = NSTextAlignmentCenter;
    }
    return _guide_label;
}

- (UIImageView *)front_imageView
{
    if (_front_imageView == nil) {
        _front_imageView = [[UIImageView alloc] init];
        _front_imageView.image = [UIImage imageNamed:@"add"];
        _front_imageView.userInteractionEnabled = YES;
        _front_imageView.tag = 10000;
    }
    return _front_imageView;
}

- (UIImageView *)back_imageView
{
    if (_back_imageView == nil) {
        _back_imageView = [[UIImageView alloc] init];
        _back_imageView.image = [UIImage imageNamed:@"add"];
        _back_imageView.userInteractionEnabled = YES;
        _back_imageView.tag = 10001;
    }
    return _back_imageView;
}

- (UIImageView *)guide_imageView
{
    if (_guide_imageView == nil) {
        _guide_imageView = [[UIImageView alloc] init];
        _guide_imageView.image = [UIImage imageNamed:@"add"];
        _guide_imageView.userInteractionEnabled = YES;
        _guide_imageView.tag = 10002;
    }
    return _guide_imageView;
}

- (UIImageView *)firestStar_imageView
{
    if (_firestStar_imageView == nil) {
        _firestStar_imageView = [[UIImageView alloc] init];
        _firestStar_imageView.image = [UIImage originalWithImage:@"xinghao"];
    }
    return _firestStar_imageView;
}

- (UIImageView *)secondStar_imageView
{
    if (_secondStar_imageView == nil) {
        _secondStar_imageView = [[UIImageView alloc] init];
        _secondStar_imageView.image = [UIImage originalWithImage:@"xinghao"];
    }
    return _secondStar_imageView;
}

- (UIImageView *)guideStar_imageView
{
    if (_guideStar_imageView == nil) {
        _guideStar_imageView = [[UIImageView alloc] init];
        _guideStar_imageView.image = [UIImage originalWithImage:@"xinghao"];
    }
    return _guideStar_imageView;
}

- (void)setFont_imageView2:(UIImage *)font_imageView2
{
    _font_imageView2 = font_imageView2;
    self.front_imageView.image = font_imageView2;
}

- (void)setBack_imageView2:(UIImage *)back_imageView2
{
    _back_imageView2 = back_imageView2;
    self.back_imageView.image = back_imageView2;
}

- (void)setGuide_imageView2:(UIImage *)guide_imageView2
{
    _guide_imageView2 = guide_imageView2;
    self.guide_imageView.image = guide_imageView2;
}


@end
