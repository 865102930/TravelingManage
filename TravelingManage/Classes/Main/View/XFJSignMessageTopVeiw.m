//
//  XFJSignMessageTopVeiw.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/2.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSignMessageTopVeiw.h"

@interface XFJSignMessageTopVeiw()

@property (nonatomic, strong) UILabel *scenery_laebl;
@property (nonatomic, strong) UIImageView *peopleTotal_imageView;
@property (nonatomic, strong) UILabel *peopleContent_label;

@end

@implementation XFJSignMessageTopVeiw

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kColor8F8F;
    }
    return self;
}

- (UILabel *)scenery_laebl
{
    if (_scenery_laebl == nil) {
        _scenery_laebl = [[UILabel alloc] init];
        _scenery_laebl.text = @"景点名称景点名称";
        _scenery_laebl.textColor = kColorFFFF;
        _scenery_laebl.font = [UIFont fontWithName:PingFang size:14.0];
    }
    return _scenery_laebl;
}

- (UIImageView *)peopleTotal_imageView
{
    if (_peopleTotal_imageView == nil) {
        _peopleTotal_imageView = [[UIImageView alloc] init];
        _peopleTotal_imageView.image = [UIImage originalWithImage:@"team"];
    }
    return _peopleTotal_imageView;
}

- (UILabel *)peopleContent_label
{
    if (_peopleContent_label == nil) {
        _peopleContent_label = [[UILabel alloc] init];
        _peopleContent_label.text = [NSString stringWithFormat:@"%@人",@"40"];
        _peopleContent_label.textColor = kColorFFFF;
        _peopleContent_label.font = [UIFont fontWithName:PingFang size:14.0];
    }
    return _peopleContent_label;
}



@end
