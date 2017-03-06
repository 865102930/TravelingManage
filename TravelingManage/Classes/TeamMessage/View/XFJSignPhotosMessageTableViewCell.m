//
//  XFJSignPhotosMessageTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/6.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSignPhotosMessageTableViewCell.h"
#import "XFJTeamMessagePerfectCollectionViewCell.h"

@interface XFJSignPhotosMessageTableViewCell() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *signRecrilTime_view;
@property (nonatomic, strong) UILabel *signPhotosTitle_label;
@property (nonatomic, strong) UILabel *signPhotosMessage_label;
@property (nonatomic, strong) UIImageView *star_imageView;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

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
        [self addSubview:self.collectionView];
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
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.signRecrilTime_view.mas_bottom).mas_offset(15.0);
            make.left.mas_equalTo(self.signRecrilTime_view.mas_left);
            make.right.mas_equalTo(-18.0);
            make.bottom.mas_equalTo(self.signPhotosMessage_label.mas_bottom);
        }];
        [self.collectionView registerClass:[XFJTeamMessagePerfectCollectionViewCell class] forCellWithReuseIdentifier:KCellIdentifier_XFJTeamMessagePerfectCollectionViewCell];
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

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

#pragma mark - cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataArr.count < 1) {
        return self.dataArr.count + 1;
    }else {
        if (self.dataArr.count >= self.maxImageCount) {
            return self.maxImageCount;
        }
    }
    return self.dataArr.count + 1 ;
}

#pragma mark - cell的内容(自定义cell)
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XFJTeamMessagePerfectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KCellIdentifier_XFJTeamMessagePerfectCollectionViewCell forIndexPath:indexPath];
    if(self.dataArr.count == 0){
        cell.photoImg = nil;
    }else{
        cell.photoImg = indexPath.item <= self.dataArr.count - 1 ? self.dataArr[indexPath.item] : nil;
    }
    return cell;
}

#pragma mark - cell的点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger index = 0;
    if (self.dataArr.count == 0) {
        index = 0;
    }else if (self.dataArr.count < 2 && self.dataArr.count > 0) {
        index = self.dataArr.count + 1;
    }else {
        index = 2;
    }
    if (index == 0) {
        if (indexPath.row < index ) {
            if([self.delegate respondsToSelector:@selector(jumpToCell:indexPath:)]) {
                [self.delegate jumpToCell:self indexPath:indexPath];
            }
            return;
        }
        self.selectIndexPath = indexPath;
        if(self.dataArr.count < 2 && [self.delegate respondsToSelector:@selector(chooseVoucherPhotosImage:)]) {
            [self.delegate chooseVoucherPhotosImage:self];
        }
    }else if (index == 2){
        if(self.dataArr.count < 2 && [self.delegate respondsToSelector:@selector(chooseVoucherPhotosImage:)]) {
            [self.delegate chooseVoucherPhotosImage:self];
        }else
        {
            if([self.delegate respondsToSelector:@selector(jumpToCell:indexPath:)]) {
                [self.delegate jumpToCell:self indexPath:indexPath];
            }
            return;
        }
    }else {
        if (indexPath.row + 1 < index ) {
            if([self.delegate respondsToSelector:@selector(jumpToCell:indexPath:)]) {
                [self.delegate jumpToCell:self indexPath:indexPath];
            }
            return;
        }
        self.selectIndexPath = indexPath;
        if(self.dataArr.count < 2 && [self.delegate respondsToSelector:@selector(chooseVoucherPhotosImage:)]) {
            [self.delegate chooseVoucherPhotosImage:self];
        }}
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (iphone5) {
        return CGSizeMake(60, 60);
    }else if (iphone6) {
        return CGSizeMake(74, 74);
    }else
    {
        return CGSizeMake(82, 82);
    }
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    _dataArr = dataArr;
    [self.collectionView reloadData];
}


- (void)setMaxImageCount:(NSInteger)maxImageCount
{
    _maxImageCount = maxImageCount;
}




@end
