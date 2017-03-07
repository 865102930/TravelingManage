//
//  XFJAssessmentTeamTopView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/6.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJAssessmentTeamTopView.h"
#import "SYStarRatingView.h"

@interface XFJAssessmentTeamTopView() <StarRatingViewDelegate>
@property (nonatomic, strong) UIView *line_view;
@property (nonatomic, strong) UIImageView *teamMessage_imageView;
@property (nonatomic, strong) UILabel *teamMessage_label;

@end

@implementation XFJAssessmentTeamTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.line_view];
        [self addSubview:self.teamMessage_imageView];
        [self addSubview:self.teamMessage_label];
        [self.line_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(3.0);
            
        }];
        [self.teamMessage_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.line_view.mas_bottom).mas_offset(15.0);
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.height.mas_equalTo(12.0);
            make.width.mas_equalTo(14.0);
        }];
        [self.teamMessage_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.teamMessage_imageView.mas_centerY);
            make.left.mas_equalTo(self.teamMessage_imageView.mas_right).mas_offset(9.0);
        }];
        SYStarRatingView *syStarRatingViewOne;
        if (iphone5) {
            syStarRatingViewOne = [[SYStarRatingView alloc] initWithFrame:CGRectMake(self.XFJ_centerX - 40, 15, 180, 20)];
        }else {
            syStarRatingViewOne = [[SYStarRatingView alloc] initWithFrame:CGRectMake(self.XFJ_centerX - 15, 15, 180, 20)];
        }
        syStarRatingViewOne.delegate = self;
        syStarRatingViewOne.foregroundViewColor = [UIColor redColor];
        [self addSubview:syStarRatingViewOne];
    }
    return self;
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColoreeee;
    }
    return _line_view;
}

- (UIImageView *)teamMessage_imageView
{
    if (_teamMessage_imageView == nil) {
        _teamMessage_imageView = [[UIImageView alloc] init];
        _teamMessage_imageView.image = [UIImage originalWithImage:@"team"];
    }
    return _teamMessage_imageView;
}

- (UILabel *)teamMessage_label
{
    if (_teamMessage_label == nil) {
        _teamMessage_label = [[UILabel alloc] init];
        _teamMessage_label.text = @"团队情况";
        _teamMessage_label.font = [UIFont fontWithName:PingFang size:14.0];
        _teamMessage_label.textColor = kColor2b2b;
    }
    return _teamMessage_label;
}

#pragma mark - 评星的代理方法
-(void)starRatingView:(SYStarRatingView *)view score:(float)score
{
    NSLog(@"+++++++++++++用户的评价分数是 :%@",[NSString stringWithFormat:@"%0.2f",score * 10 ]);
    if (self.commitStarBlock) {
        self.commitStarBlock([NSString stringWithFormat:@"%0.2f",score * 10 ]);
    }
    
}




@end
