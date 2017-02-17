//
//  AnnouncementdetailImageCell.m
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/16.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "AnnouncementdetailImageCell.h"
#import <UIImageView+WebCache.h>

static NSString * const AnnouncementdetailImageCellID = @"AnnouncementdetailImageCellID";

@implementation AnnouncementdetailImageCell

+ (instancetype)initWithTableView:(UITableView *)tableView {
    AnnouncementdetailImageCell *cell = [tableView dequeueReusableCellWithIdentifier:AnnouncementdetailImageCellID];
    if (cell == nil) {
        cell = [[AnnouncementdetailImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AnnouncementdetailImageCellID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.detailImage];
        [self.contentView addSubview:self.lineV1];
        [self.contentView addSubview:self.lineV2];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.detailImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(-27);
    }];
    
    [self.lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(-1);
        make.height.mas_equalTo(1);
    }];
    
    [self.lineV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(1);
    }];
}

- (UIImageView *)detailImage{
    if (!_detailImage) {
        _detailImage = [[UIImageView alloc] init];
        _detailImage.layer.cornerRadius = 4;
        _detailImage.layer.masksToBounds = YES;
        //        NSString *strUrl = [topicItem.liftSrc stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
        //        NSString *urlStr = [BASEURL stringByAppendingString:@"/"];
        //        NSString *urlStr1 = [urlStr stringByAppendingPathComponent:strUrl];
        //        NSURL *imageUrl = [NSURL URLWithString: urlStr1];
        //预留的占位位图片接口
        [_detailImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"TeamTitle"] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }
    return _detailImage;
}

- (UIView *)lineV1{
    if (!_lineV1) {
        _lineV1 = [[UIView alloc] init];
        _lineV1.backgroundColor = [UIColor colorWithHexString:@"B1B1B1"];
    }
    return _lineV1;
}

- (UIView *)lineV2{
    if (!_lineV2) {
        _lineV2 = [[UIView alloc] init];
        _lineV2.backgroundColor = [UIColor colorWithHexString:@"C4C4C4"];
    }
    return _lineV2;
}
@end
