//
//  XFJTeamMessagePerfectCollectionViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/4.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJTeamMessagePerfectCollectionViewCell.h"

@interface XFJTeamMessagePerfectCollectionViewCell()

@property (nonatomic, strong) UIImageView *addPhotos_imageView;


@end

@implementation XFJTeamMessagePerfectCollectionViewCell

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


- (void)setPhotoImg:(UIImage *)photoImg{
    _photoImg = photoImg;
    if (photoImg == nil) {
        self.addPhotos_imageView.image = [UIImage originalWithImage:@"add-img-"];
    }else{
        self.addPhotos_imageView.image = photoImg;
    }
}


@end
