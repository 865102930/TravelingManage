//
//  XFJSignPhotosMessageTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/6.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSignPhotosMessageTableViewCell.h"
#import "XFJTeamMessagePerfectCollectionViewCell.h"
#import "PhotoModel.h"
@interface XFJSignPhotosMessageTableViewCell()
@property (nonatomic, strong) UIView *signRecrilTime_view;
@property (nonatomic, strong) UILabel *signPhotosTitle_label;
@property (nonatomic, strong) UILabel *signPhotosMessage_label;
@property (nonatomic, strong) UIImageView *star_imageView;

@end

@implementation XFJSignPhotosMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.signRecrilTime_view];
        [self addSubview:self.signPhotosTitle_label];
        [self addSubview:self.signPhotosMessage_label];
        [self addSubview:self.star_imageView];
        [self addSubview:self.addPicBtn];
        [self.signRecrilTime_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20.0);
            make.left.mas_equalTo(12.0);
            make.height.width.mas_equalTo(6.0);
        }];
        [self.signPhotosTitle_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.signRecrilTime_view.mas_centerY);
            make.left.mas_equalTo(self.signRecrilTime_view.mas_right).mas_offset(9.0);
        }];
        [self.signPhotosMessage_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-17.0);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-20.0);
        }];
        [self.star_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.signPhotosMessage_label.mas_centerY);
            make.right.mas_equalTo(self.signPhotosMessage_label.mas_left).mas_offset(-5);
            make.height.width.mas_equalTo(5.0);
        }];
        [self.addPicBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.signPhotosTitle_label.mas_bottom).offset(10);
            make.left.mas_equalTo(12.0);
            make.height.width.mas_equalTo(77.0);
        }];
    }
        return self;
}

- (UIView *)signRecrilTime_view
{
    if (_signRecrilTime_view == nil) {
        _signRecrilTime_view = [[UIView alloc] init];
        _signRecrilTime_view.backgroundColor = kColor5AD8;
        _signRecrilTime_view.layer.cornerRadius = 3.0;
    }
    return _signRecrilTime_view;
}

- (UILabel *)signPhotosTitle_label
{
    if (_signPhotosTitle_label == nil) {
        _signPhotosTitle_label = [[UILabel alloc] init];
        _signPhotosTitle_label.text = @"签到点一凭证照片";
        _signPhotosTitle_label.textColor = kColor2f2f;
        _signPhotosTitle_label.font = [UIFont fontWithName:PingFang size:14.0];
    }
    return _signPhotosTitle_label;
}

- (UILabel *)signPhotosMessage_label
{
    if (_signPhotosMessage_label == nil) {
        _signPhotosMessage_label = [[UILabel alloc] init];
        _signPhotosMessage_label.text = @"此照片为您在消费点填写的团队确认凭证";
        _signPhotosMessage_label.font = [UIFont fontWithName:PingFang size:12.0];
        _signPhotosMessage_label.textColor = kColorB1B1;
    }
    return _signPhotosMessage_label;
}

- (UIImageView *)star_imageView
{
    if (_star_imageView == nil) {
        _star_imageView = [[UIImageView alloc] init];
        _star_imageView.image = [UIImage originalWithImage:@"xinghao"];
    }
    return _star_imageView;
}

- (UIButton *)addPicBtn {
    if (!_addPicBtn) {
        _addPicBtn = [[UIButton alloc] init];
        [_addPicBtn setImage:[UIImage imageNamed:@"add-img-"] forState:UIControlStateNormal];
        [_addPicBtn addTarget: self action:@selector(addPicBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addPicBtn;
}

- (void)addPicBtnClick:(UIButton *)addPicBtn {
    if(self.delegate && [self.delegate respondsToSelector:@selector(chooseVoucherPhotosImage:)]) {
        [self.delegate chooseVoucherPhotosImage:self];
    }
}

- (void)setPhotoImage:(UIImage *)photoImage{
    _photoImage = photoImage;
    if (photoImage == nil) {
        [self.addPicBtn setImage:[UIImage imageNamed:@"add-img-"] forState:UIControlStateNormal];
    }else{
        [self.addPicBtn setImage:photoImage forState:UIControlStateNormal];
    }
}

- (void)setPhotoM:(PhotoModel *)photoM {
    _photoM = photoM;
    if (photoM.documentImage == nil) {
        [self.addPicBtn setImage:[UIImage imageNamed:@"add-img-"] forState:UIControlStateNormal];
    }else{
        [self.addPicBtn setImage:photoM.documentImage forState:UIControlStateNormal];
    }
    _signPhotosTitle_label = photoM.signPhotosTitle_label;
    _signPhotosMessage_label = photoM.signPhotosMessage_label;
    
}

@end
