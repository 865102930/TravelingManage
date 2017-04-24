//
//  XFJVoucherPhotosView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/17.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJVoucherPhotosView.h"
#import "XFJVoucherPhotosCollectionViewCell.h"

@interface XFJVoucherPhotosView()

@property (nonatomic, strong) UIImageView *star_imageView;

@property (nonatomic, strong) UILabel *showPhotos_label;


@property (nonatomic, strong) UIImageView *addPhotos_imageView;

@end

@implementation XFJVoucherPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.showPhotos_label];
        self.dataArr = [NSMutableArray array];
        [self addSubview:self.addPhotos_imageView];
        [self.showPhotos_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.bottom.mas_equalTo(self.mas_bottom).mas_equalTo(-25.0);
        }];
        [self.addPhotos_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.height.mas_equalTo((SCREEN_WIDTH - 2 * 18) / 4 - 10);
            make.width.mas_equalTo((SCREEN_WIDTH - 2 * 18) / 4 - 10);
            make.top.mas_equalTo(self.mas_top).mas_offset(15.0);
        }];
        UITapGestureRecognizer *front_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhotos_choosePhotoImage:)];
        [self.addPhotos_imageView addGestureRecognizer:front_tap];
    }
    return self;
}

- (void)addPhotos_choosePhotoImage:(UITapGestureRecognizer *)tap
{
    NSInteger addPhotosStr = 1;
    if (self.addPhotos_photosImageViewBlock) {
        self.addPhotos_photosImageViewBlock(addPhotosStr);
    }
}

- (UILabel *)showPhotos_label
{
    if (_showPhotos_label == nil) {
        _showPhotos_label = [[UILabel alloc] init];
        _showPhotos_label.text = @"此照片为您在消费点填写的团队确认凭证";
        _showPhotos_label.textColor = kColorBCBC;
        [_showPhotos_label setFont:[UIFont systemFontOfSize:12.0]];
        _showPhotos_label.textAlignment = NSTextAlignmentLeft;
    }
    return _showPhotos_label;
}

- (UIImageView *)addPhotos_imageView
{
    if (_addPhotos_imageView == nil) {
        _addPhotos_imageView = [[UIImageView alloc] init];
        _addPhotos_imageView.image = [UIImage originalWithImage:@"add-img-"];
        _addPhotos_imageView.userInteractionEnabled = YES;
    }
    return _addPhotos_imageView;
}

- (void)setAddPhotos_imageView1:(UIImage *)addPhotos_imageView1
{
    _addPhotos_imageView1 = addPhotos_imageView1;
    self.addPhotos_imageView.image = addPhotos_imageView1;
}




@end
