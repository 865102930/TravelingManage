//
//  XFJSignAppraiseTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/6.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSignAppraiseTableViewCell.h"
#import "SYStarRatingView.h"

@interface XFJSignAppraiseTableViewCell() <StarRatingViewDelegate>

@property (nonatomic, strong) UIView *line_view;
@property (nonatomic, strong) UIImageView *signTitle_imageView;
@property (nonatomic, strong) UILabel *signTitle_label;
@property (nonatomic, strong) UILabel *scenicService_label;
@property (nonatomic, strong) UILabel *environmentHygienism_label;
@property (nonatomic, strong) UILabel *installationEquipment_label;
@property (nonatomic, strong) SYStarRatingView *syStarRatingViewOne;

@end

@implementation XFJSignAppraiseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.line_view];
        [self addSubview:self.signTitle_imageView];
        [self addSubview:self.signTitle_label];
        [self addSubview:self.scenicService_label];
        [self addSubview:self.environmentHygienism_label];
        [self addSubview:self.installationEquipment_label];
        [self.line_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(3.0);
            make.top.mas_equalTo(self.mas_top);
        }];
        [self.signTitle_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.line_view.mas_bottom).mas_offset(12.0);
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.height.mas_equalTo(12.0);
            make.width.mas_equalTo(14.0);
        }];
        [self.signTitle_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.signTitle_imageView.mas_centerY);
            make.left.mas_equalTo(self.signTitle_imageView.mas_right).mas_offset(9.0);
        }];
        [self.scenicService_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.signTitle_imageView.mas_left);
            make.top.mas_equalTo(self.signTitle_label.mas_bottom).mas_offset(19.0);
        }];
        [self.environmentHygienism_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.signTitle_imageView.mas_left);
            make.top.mas_equalTo(self.scenicService_label.mas_bottom).mas_offset(28.0);
        }];
        [self.installationEquipment_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.signTitle_imageView.mas_left);
            make.top.mas_equalTo(self.environmentHygienism_label.mas_bottom).mas_offset(28.0);
        }];
//        for (NSInteger i = 1; i <= 3; i++) {
//            SYStarRatingView *syStarRatingViewOne;
//            if (iphone5) {
//                syStarRatingViewOne = [[SYStarRatingView alloc] initWithFrame:CGRectMake(self.XFJ_centerX - 40, 48, 180, 20)];
//            }else {
//                syStarRatingViewOne = [[SYStarRatingView alloc] initWithFrame:CGRectMake(self.XFJ_centerX - 15, 48, 180, 20)];
//            }
//            syStarRatingViewOne.delegate = self;
//            syStarRatingViewOne.foregroundViewColor = [UIColor redColor];
//            [self addSubview:_syStarRatingViewOne];
//        }
    }
    return self;
}

- (SYStarRatingView *)syStarRatingViewOne
{
    if (_syStarRatingViewOne == nil) {
        _syStarRatingViewOne = [[SYStarRatingView alloc] initWithFrame:CGRectMake(self.XFJ_centerX - 15, 48, 180, 20)];
        _syStarRatingViewOne.delegate = self;
        _syStarRatingViewOne.foregroundViewColor = [UIColor redColor];
    }
    return _syStarRatingViewOne;
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColoreeee;
    }
    return _line_view;
}

- (UIImageView *)signTitle_imageView
{
    if (_signTitle_imageView == nil) {
        _signTitle_imageView = [[UIImageView alloc] init];
        _signTitle_imageView.image = [UIImage originalWithImage:@"scenic-spots"];
    }
    return _signTitle_imageView;
}

- (UILabel *)signTitle_label
{
    if (_signTitle_label == nil) {
        _signTitle_label = [[UILabel alloc] init];
        _signTitle_label.text = @"签到点评价";
        _signTitle_label.font = [UIFont fontWithName:PingFang size:14.0];
        _signTitle_label.textColor = kColor2b2b;
    }
    return _signTitle_label;
}

- (UILabel *)scenicService_label
{
    if (_scenicService_label == nil) {
        _scenicService_label = [[UILabel alloc] init];
        _scenicService_label.textColor = kColor2f2f;
        _scenicService_label.text = @"景点服务";
        _scenicService_label.font = [UIFont fontWithName:PingFang size:14.0];
    }
    return _scenicService_label;
}
- (UILabel *)environmentHygienism_label
{
    if (_environmentHygienism_label == nil) {
        _environmentHygienism_label = [[UILabel alloc] init];
        _environmentHygienism_label.text = @"环境卫生";
        _environmentHygienism_label.textColor = kColor2f2f;
        _environmentHygienism_label.font = [UIFont fontWithName:PingFang size:14.0];
    }
    return _environmentHygienism_label;
}

- (UILabel *)installationEquipment_label
{
    if (_installationEquipment_label == nil) {
        _installationEquipment_label = [[UILabel alloc] init];
        _installationEquipment_label.text = @"设施设备";
        _installationEquipment_label.textColor = kColor2f2f;
        _installationEquipment_label.font = [UIFont fontWithName:PingFang size:14.0];
    }
    return _installationEquipment_label;
}

#pragma mark - 评星的代理方法
-(void)starRatingView:(SYStarRatingView *)view score:(float)score
{
    NSLog(@"+++++++++++++用户的评价分数是2 :%@",[NSString stringWithFormat:@"%0.2f",score * 10]);
    
}

@end
