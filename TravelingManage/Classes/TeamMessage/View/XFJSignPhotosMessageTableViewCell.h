//
//  XFJSignPhotosMessageTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/6.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFJTaskItemRows.h"
@class PhotoModel;
@class XFJSignPhotosMessageTableViewCell;
@protocol XFJSignPhotosMessageTableViewCellDelegate <NSObject>

- (void)chooseVoucherPhotosImage:(XFJSignPhotosMessageTableViewCell *)voucherPhotos;

- (void)jumpToCell:(XFJSignPhotosMessageTableViewCell *)cell indexPath:(NSIndexPath *)indexPath ;


@end

@interface XFJSignPhotosMessageTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *addPicBtn;

@property (nonatomic, strong) UIImage *photoImage;

@property (nonatomic, weak) id <XFJSignPhotosMessageTableViewCellDelegate>delegate;

@property (nonatomic, copy) void (^photos_buttonBlock)(UIButton *);

@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@property (nonatomic, strong)PhotoModel *photoM;

@property (nonatomic, strong) XFJTaskItemRows *taskItemRows;

@end
