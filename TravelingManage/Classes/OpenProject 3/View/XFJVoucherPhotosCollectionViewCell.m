//
//  XFJVoucherPhotosCollectionViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/17.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJVoucherPhotosCollectionViewCell.h"

@interface XFJVoucherPhotosCollectionViewCell()

@property (nonatomic, strong) UIImageView *addPhotos_imageView;

@end

@implementation XFJVoucherPhotosCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.addPhotos_imageView];
        [self.addPhotos_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(self.mas_height);
        }];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.addPhotos_imageView.userInteractionEnabled = YES;
}

- (UIImageView *)addPhotos_imageView
{
    if (_addPhotos_imageView == nil) {
        _addPhotos_imageView = [[UIImageView alloc] init];
        _addPhotos_imageView.image = [UIImage originalWithImage:@"add-img-"];
    }
    return _addPhotos_imageView;
}


@end
