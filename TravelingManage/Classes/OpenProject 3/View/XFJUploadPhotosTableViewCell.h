//
//  XFJUploadPhotosTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/14.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//
#define KCellIdentifier_XFJUploadPhotosTableViewCell @"XFJUploadPhotosTableViewCell"


#import <UIKit/UIKit.h>

@class XFJUploadPhotosTableViewCell;
@protocol XFJUploadPhotosTableViewCellDelegate <NSObject>

- (void)chooseImage:(XFJUploadPhotosTableViewCell *)SerPhotoCell;
- (void)jumpCell:(XFJUploadPhotosTableViewCell *)cell indexPath:(NSIndexPath *)indexPath ;

@end

@interface XFJUploadPhotosTableViewCell : UIView

@property (nonatomic, strong) void (^chosePhotosBlock)();

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, assign) NSInteger maxImageCount;

@property (nonatomic, weak) id <XFJUploadPhotosTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *selectIndexPath;


@end
