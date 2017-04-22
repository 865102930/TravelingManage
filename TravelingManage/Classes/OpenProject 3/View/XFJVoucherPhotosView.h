//
//  XFJVoucherPhotosView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/17.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XFJVoucherPhotosView;
@protocol XFJVoucherPhotosViewDelegate <NSObject>

- (void)chooseVoucherPhotosImage:(XFJVoucherPhotosView *)voucherPhotos;

- (void)jumpToCell:(XFJVoucherPhotosView *)cell indexPath:(NSIndexPath *)indexPath ;

@end

@interface XFJVoucherPhotosView : UIView

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, weak) id <XFJVoucherPhotosViewDelegate>delegate;

@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@property (nonatomic, assign) NSInteger maxImageCount;

@property (nonatomic, copy) void (^addPhotos_photosImageViewBlock)(NSInteger);

@property (nonatomic, strong) UIImage *addPhotos_imageView1;




@end
