
//
//  XFJSevenTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSevenTableViewCell.h"
#import "TZImagePickerController.h"
#import "CollectionViewCell.h"

#define Kwidth [UIScreen mainScreen].bounds.size.width
#define Kheight [UIScreen mainScreen].bounds.size.height
@interface XFJSevenTableViewCell() <TZImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    CGFloat _itemWH;
    CGFloat _margin;
}
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) NSMutableArray *photosArray;
@property (nonatomic ,strong) NSMutableArray *assestArray;
@property BOOL isSelectOriginalPhoto;
@property (nonatomic, strong) UILabel *photos_label;
@property (nonatomic, strong) UIImageView *photoStar_imageView;


@end

@implementation XFJSevenTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:self.collectionView];
        [self addSubview:self.photos_label];
        [self addSubview:self.photoStar_imageView];
        [self.photos_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(12.0);
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
        }];
        [self.photoStar_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.photos_label.mas_centerY);
            make.left.mas_equalTo(self.photos_label.mas_right).mas_offset(2.0);
            make.height.with.mas_equalTo(4.0);
        }];
    }
    return self;
}

- (NSMutableArray *)photosArray{
    if (!_photosArray) {
        self.photosArray = [NSMutableArray array];
    }
    return _photosArray;
}

- (NSMutableArray *)assestArray{
    if (!_assestArray) {
        self.assestArray = [NSMutableArray array];
    }
    return _assestArray;
}

- (UILabel *)photos_label
{
    if (_photos_label == nil) {
        _photos_label = [[UILabel alloc] init];
        _photos_label.text = @"图片上传";
        _photos_label.textColor = kColor2f2f;
        _photos_label.font = [UIFont systemFontOfSize:13.0];
    }
    return _photos_label;
}

- (UIImageView *)photoStar_imageView
{
    if (_photoStar_imageView == nil) {
        _photoStar_imageView = [[UIImageView alloc] init];
        _photoStar_imageView.image = [UIImage originalWithImage:@"xinghao"];
    }
    return _photoStar_imageView;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _margin = 4;
        _itemWH = (self.bounds.size.width - 2 * _margin - 4) / 3 - _margin;
        UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
        flowLayOut.itemSize = CGSizeMake(((Kwidth - 2 * 18) - 40)/4, ((Kwidth - 2 * 18) - 40)/4);
//        flowLayOut.sectionInset = UIEdgeInsetsMake(5, 1, 5, 10);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(18, 40, Kwidth - 2 * 18, 200) collectionViewLayout:flowLayOut];
        _collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
    }
    return _collectionView;
}

- (void)checkLocalPhoto{
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:6 delegate:self];
    [imagePicker setSortAscendingByModificationDate:NO];
    imagePicker.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    imagePicker.selectedAssets = _assestArray;
    imagePicker.allowPickingVideo = NO;
    if (self.presentPickPhotosBlock) {
        self.presentPickPhotosBlock(imagePicker);
    }
    
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    self.photosArray = [NSMutableArray arrayWithArray:photos];
    self.assestArray = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [_collectionView reloadData];
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == _photosArray.count) {
        [self checkLocalPhoto];
    }else{
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_assestArray selectedPhotos:_photosArray index:indexPath.row];
        imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            _photosArray = [NSMutableArray arrayWithArray:photos];
            _assestArray = [NSMutableArray arrayWithArray:assets];
            _isSelectOriginalPhoto = isSelectOriginalPhoto;
            [_collectionView reloadData];
            _collectionView.contentSize = CGSizeMake(0, ((_photosArray.count + 2) / 3 ) * (_margin + _itemWH));
        }];
        if (self.presentPickPhotosBlock) {
            self.presentPickPhotosBlock(imagePickerVc);
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _photosArray.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row == _photosArray.count) {
        cell.imagev.image = [UIImage imageNamed:@"s-add-img-"];
        //        cell.imagev.backgroundColor = [UIColor redColor];
        cell.deleteButton.hidden = YES;
        
    }else{
        cell.imagev.image = _photosArray[indexPath.row];
        cell.deleteButton.hidden = NO;
    }
    cell.deleteButton.tag = 100 + indexPath.row;
    [cell.deleteButton addTarget:self action:@selector(deletePhotos:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

- (void)deletePhotos:(UIButton *)sender{
    [_photosArray removeObjectAtIndex:sender.tag - 100];
    [_assestArray removeObjectAtIndex:sender.tag - 100];
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag-100 inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
}



@end
