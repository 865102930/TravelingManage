//
//  XFJSignTeamPhotosView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/3.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XFJSignTeamPhotosView;
@protocol XFJSignTeamPhotosViewDelegate <NSObject>

- (void)chooseVoucherPhotosImage:(XFJSignTeamPhotosView *)voucherPhotos;

- (void)jumpToCell:(XFJSignTeamPhotosView *)cell indexPath:(NSIndexPath *)indexPath ;

@end

@interface XFJSignTeamPhotosView : UIView

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, weak) id <XFJSignTeamPhotosViewDelegate>delegate;

@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@property (nonatomic, assign) NSInteger maxImageCount;

@end
