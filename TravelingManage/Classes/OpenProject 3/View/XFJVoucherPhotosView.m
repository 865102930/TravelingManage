//
//  XFJVoucherPhotosView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/17.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJVoucherPhotosView.h"
#import "XFJVoucherPhotosCollectionViewCell.h"

@interface XFJVoucherPhotosView() <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView *star_imageView;

@property (nonatomic, strong) UILabel *showPhotos_label;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation XFJVoucherPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
//        [self addSubview:self.star_imageView];
        [self addSubview:self.showPhotos_label];
        [self addSubview:self.collectionView];
        self.dataArr = [NSMutableArray array];
//        [self.star_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(18.0);
//            make.bottom.mas_equalTo(-25.0);
//            make.height.width.mas_equalTo(5.0);
//        }];
        [self.showPhotos_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.bottom.mas_equalTo(self.mas_bottom).mas_equalTo(-25.0);
        }];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15.0);
            make.left.mas_equalTo(18.0);
            make.right.mas_equalTo(-18.0);
            make.bottom.mas_equalTo(self.showPhotos_label.mas_top).mas_offset(-20);
        }];
        [self.collectionView registerClass:[XFJVoucherPhotosCollectionViewCell class] forCellWithReuseIdentifier:KCellIdentifier_XFJVoucherPhotosCollectionViewCell];
    }
    return self;
}

//- (UIImageView *)star_imageView
//{
//    if (_star_imageView == nil) {
//        _star_imageView = [[UIImageView alloc] init];
//        _star_imageView.image = [UIImage originalWithImage:@"xinghao"];
//    }
//    return _star_imageView;
//}

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
    XFJVoucherPhotosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KCellIdentifier_XFJVoucherPhotosCollectionViewCell forIndexPath:indexPath];
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
