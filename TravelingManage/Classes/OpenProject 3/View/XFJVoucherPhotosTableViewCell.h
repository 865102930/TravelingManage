//
//  XFJVoucherPhotosTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/20.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//
#define KCellIdentifier_XFJVoucherPhotosTableViewCell @"XFJVoucherPhotosTableViewCell"

#import <UIKit/UIKit.h>

@class XFJVoucherPhotosTableViewCell;
@protocol XFJVoucherPhotosTableViewCellDelegate <NSObject>

- (void)chooseVoucherPhotosImage:(XFJVoucherPhotosTableViewCell *)voucherPhotos;

- (void)jumpToCell:(XFJVoucherPhotosTableViewCell *)cell indexPath:(NSIndexPath *)indexPath ;

@end

@interface XFJVoucherPhotosTableViewCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, weak) id <XFJVoucherPhotosTableViewCellDelegate>delegate;

@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@property (nonatomic, assign) NSInteger maxImageCount;

+ (CGFloat)cellHeight;

@end
