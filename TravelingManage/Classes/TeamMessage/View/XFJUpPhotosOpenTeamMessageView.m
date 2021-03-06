//
//  XFJUpPhotosOpenTeamMessageView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/4.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJUpPhotosOpenTeamMessageView.h"
#import "XFJTeamMessagePerfectCollectionViewCell.h"

@interface XFJUpPhotosOpenTeamMessageView() <UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, strong) UIView *line_view;

@property (nonatomic, strong) UIImageView *carPhotos_imageView;
@property (nonatomic, strong) UILabel *carPhotos_label;

@property (nonatomic, strong) UIImageView *carPhotosStar_imageView;
@property (nonatomic, strong) UILabel *carPhotosMessage_label;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation XFJUpPhotosOpenTeamMessageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.line_view];
        [self addSubview:self.carPhotos_imageView];
        [self addSubview:self.carPhotos_label];
        [self addSubview:self.carPhotosStar_imageView];
        [self addSubview:self.carPhotosMessage_label];
        [self addSubview:self.collectionView];
        [self.line_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(2.0);
        }];
        [self.carPhotos_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.line_view.mas_bottom).mas_offset(9.0);
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.width.mas_equalTo(10.0);
            make.height.mas_equalTo(12.0);
        }];
        [self.carPhotos_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.carPhotos_imageView.mas_right).mas_offset(8.0);
            make.centerY.mas_equalTo(self.carPhotos_imageView.mas_centerY);
        }];
        [self.carPhotosStar_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.carPhotos_imageView.mas_left);
            make.bottom.mas_equalTo(-25.0);
            make.height.width.mas_equalTo(5.0);
        }];
        [self.carPhotosMessage_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.carPhotosStar_imageView.mas_right).mas_offset(2.0);
            make.centerY.mas_equalTo(self.carPhotosStar_imageView.mas_centerY);
        }];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.carPhotos_label.mas_bottom).mas_offset(15.0);
            make.left.mas_equalTo(self.carPhotos_imageView.mas_left);
            make.right.mas_equalTo(-18.0);
            make.bottom.mas_equalTo(self.carPhotosMessage_label.mas_top).mas_offset(-10);
        }];
        [self.collectionView registerClass:[XFJTeamMessagePerfectCollectionViewCell class] forCellWithReuseIdentifier:KCellIdentifier_XFJTeamMessagePerfectCollectionViewCell];
    }
    return self;
}

- (UIImageView *)carPhotos_imageView
{
    if (_carPhotos_imageView == nil) {
        _carPhotos_imageView = [[UIImageView alloc] init];
        _carPhotos_imageView.image = [UIImage originalWithImage:@"uploading-"];
    }
    return _carPhotos_imageView;
}

- (UILabel *)carPhotos_label
{
    if (_carPhotos_label == nil) {
        _carPhotos_label = [[UILabel alloc] init];
        _carPhotos_label.text = @"凭证照片上传";
        _carPhotos_label.font = [UIFont fontWithName:PingFang size:13.0];
        _carPhotos_label.textColor = kColorFF38;
    }
    return _carPhotos_label;
}

- (UIView *)line_view
{
    if (_line_view == nil) {
        _line_view = [[UIView alloc] init];
        _line_view.backgroundColor = kColoreeee;
    }
    return _line_view;
}

- (UIImageView *)carPhotosStar_imageView
{
    if (_carPhotosStar_imageView == nil) {
        _carPhotosStar_imageView = [[UIImageView alloc] init];
        _carPhotosStar_imageView.image = [UIImage originalWithImage:@"xinghao"];
    }
    return _carPhotosStar_imageView;
}

- (UILabel *)carPhotosMessage_label
{
    if (_carPhotosMessage_label == nil) {
        _carPhotosMessage_label = [[UILabel alloc] init];
        _carPhotosMessage_label.text = @"此照片为您的纸质开团照片";
        _carPhotosMessage_label.textColor = kColorBCBC;
        [_carPhotosMessage_label setFont:[UIFont systemFontOfSize:12.0]];
        _carPhotosMessage_label.textAlignment = NSTextAlignmentLeft;
    }
    return _carPhotosMessage_label;
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
    NSLog(@"-----------cell的个数是 :%zd",self.dataArr.count);
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
    NSLog(@"-----------cell的个数是2 :%zd",self.dataArr.count);
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

- (void)setImageView_array:(NSMutableArray *)imageView_array
{
    _imageView_array = imageView_array;
    [self downloadImagesWithImageViewArray:imageView_array];
}

//开启子线程下载图片
- (void)downloadImagesWithImageViewArray:(NSMutableArray *)picStrs
{
    _dataArr = [NSMutableArray array];
    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __weak typeof(self) weakself = self;
    dispatch_async(queue, ^{
        __strong typeof(weakself) strongself = weakself;
        for (NSString *imageUrl in picStrs ) {
            NSString *url = [NSString stringWithFormat:@"%@/%@",IMAGEVIEWBASEURL,imageUrl];
            NSData *resultData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            UIImage *img = [UIImage imageWithData:resultData];
            dispatch_sync(dispatch_get_main_queue(), ^{
                if(img){
                    [strongself.dataArr addObject:img];
                }
                self.maxImageCount = 1;
                //放在这个位置,有几张图片就会刷新几次页面
                [weakself.collectionView reloadData];
            });
        }
        
    });
}


@end
