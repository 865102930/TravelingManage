//
//  XFJUploadPhotosTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/14.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJUploadPhotosTableViewCell.h"
#import "XFJUploadPhotosCollectionViewCell.h"

@interface XFJUploadPhotosTableViewCell() <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIView *line_view;

@property (nonatomic, strong) UIImageView *uploadPhotos_imageView;

@property (nonatomic, strong) UILabel *uploadPhotos_label;

@property (nonatomic, strong) UILabel *carPhotos_label;

@property (nonatomic, strong) UIImageView *star_imageView;

@property (nonatomic, strong) UILabel *showPhotos_label;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation XFJUploadPhotosTableViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.line_view];
        [self addSubview:self.uploadPhotos_imageView];
        [self addSubview:self.uploadPhotos_label];
        [self addSubview:self.star_imageView];
        [self addSubview:self.showPhotos_label];
        [self addSubview:self.collectionView];
        self.dataArr = [NSMutableArray array];
        [self.line_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.mas_left);
            make.height.mas_equalTo(3.0);
            make.right.mas_equalTo(self.mas_right);
        }];
        [self.uploadPhotos_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(24.0);
            make.left.mas_equalTo(18.0);
            make.height.mas_equalTo(15.0);
            make.width.mas_equalTo(13.0);
        }];
        [self.uploadPhotos_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.uploadPhotos_imageView.mas_centerY);
            make.left.mas_equalTo(self.uploadPhotos_imageView.mas_right).mas_offset(10.0);
        }];
        [self.star_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.uploadPhotos_imageView.mas_left);
            make.bottom.mas_equalTo(-25.0);
            make.height.width.mas_equalTo(5.0);
        }];
        [self.showPhotos_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.star_imageView.mas_right).mas_offset(2.0);
            make.centerY.mas_equalTo(self.star_imageView.mas_centerY);
        }];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.uploadPhotos_label.mas_bottom).mas_offset(15.0);
            make.left.mas_equalTo(self.uploadPhotos_imageView.mas_left);
            make.right.mas_equalTo(-18.0);
            make.bottom.mas_equalTo(self.showPhotos_label.mas_top).mas_offset(-20);
        }];
        [self.collectionView registerClass:[XFJUploadPhotosCollectionViewCell class] forCellWithReuseIdentifier:KCellIdentifier_XFJUploadPhotosCollectionViewCell];
    }
    return self;
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
- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColoreeee;
    }
    return _line_view;
}

- (UIImageView *)uploadPhotos_imageView
{
    if (_uploadPhotos_imageView == nil) {
        _uploadPhotos_imageView = [[UIImageView alloc] init];
        _uploadPhotos_imageView.image = [UIImage originalWithImage:@"Upload-"];
    }
    return _uploadPhotos_imageView;
}

- (UILabel *)uploadPhotos_label
{
    if (_uploadPhotos_label == nil) {
        _uploadPhotos_label = [[UILabel alloc] init];
        _uploadPhotos_label.text = @"照片上传";
        _uploadPhotos_label.textColor = kColorff47;
        [_uploadPhotos_label setFont:[UIFont systemFontOfSize:15.0]];
        _uploadPhotos_label.textAlignment = NSTextAlignmentLeft;
    }
    return _uploadPhotos_label;
}

- (UILabel *)carPhotos_label
{
    if (_carPhotos_label == nil) {
        _carPhotos_label = [[UILabel alloc] init];
        _carPhotos_label.text = @"车辆照片1";
        _carPhotos_label.textColor = kColor8383;
        [_carPhotos_label setFont:[UIFont systemFontOfSize:13.0]];
        _carPhotos_label.textAlignment = NSTextAlignmentLeft;
    }
    return _carPhotos_label;
}

- (UIImageView *)star_imageView
{
    if (_star_imageView == nil) {
        _star_imageView = [[UIImageView alloc] init];
        _star_imageView.image = [UIImage originalWithImage:@"xinghao"];
    }
    return _star_imageView;
}

- (UILabel *)showPhotos_label
{
    if (_showPhotos_label == nil) {
        _showPhotos_label = [[UILabel alloc] init];
        _showPhotos_label.text = @"此照片为您的车辆停在此地的照片确认凭证";
        _showPhotos_label.textColor = kColorBCBC;
        [_showPhotos_label setFont:[UIFont systemFontOfSize:12.0]];
        _showPhotos_label.textAlignment = NSTextAlignmentLeft;
    }
    return _showPhotos_label;
}

- (void)addPhotosButtonClick
{
    NSLog(@"主人,您点击了添加照片按钮~~");
    if (self.chosePhotosBlock) {
        self.chosePhotosBlock();
    }
}

#pragma mark - cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataArr.count < 6) {
        return self.dataArr.count + 1;
    }else {
        if (self.dataArr.count >= self.maxImageCount) {
            return self.maxImageCount;
        }
    }
    return self.dataArr.count + 1;
}

#pragma mark - cell的内容(自定义cell)
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XFJUploadPhotosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KCellIdentifier_XFJUploadPhotosCollectionViewCell forIndexPath:indexPath];
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
    }else if (self.dataArr.count < 6 && self.dataArr.count > 0) {
        index = self.dataArr.count + 1;
    }else {
        index = 6;
    }
    if (index == 0) {
        if (indexPath.row < index ) {
            if([self.delegate respondsToSelector:@selector(jumpCell:indexPath:)]) {
                [self.delegate jumpCell:self indexPath:indexPath];
            }
            return;
        }
        self.selectIndexPath = indexPath;
        if(self.dataArr.count < 6 && [self.delegate respondsToSelector:@selector(chooseImage:)]) {
            [self.delegate chooseImage:self];
        }
    }else if (index == 6){
        if(self.dataArr.count < 6 && [self.delegate respondsToSelector:@selector(chooseImage:)]) {
            [self.delegate chooseImage:self];
        }else
        {
            if([self.delegate respondsToSelector:@selector(jumpCell:indexPath:)]) {
                [self.delegate jumpCell:self indexPath:indexPath];
            }
            return;
        }
    }else {
        if (indexPath.row + 1 < index ) {
            if([self.delegate respondsToSelector:@selector(jumpCell:indexPath:)]) {
                [self.delegate jumpCell:self indexPath:indexPath];
            }
            return;
        }
        self.selectIndexPath = indexPath;
        if(self.dataArr.count < 6 && [self.delegate respondsToSelector:@selector(chooseImage:)]) {
            [self.delegate chooseImage:self];
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

- (void)setMaxImageCount:(NSInteger)maxImageCount{
    _maxImageCount = maxImageCount;
}


@end
