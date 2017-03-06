//
//  XFJPleaseUpPerfectPhotosView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/6.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XFJPleaseUpPerfectPhotosView;
@protocol XFJPleaseUpPerfectPhotosViewDelegate <NSObject>

- (void)chooseImage:(XFJPleaseUpPerfectPhotosView *)SerPhotoCell;
- (void)jumpCell:(XFJPleaseUpPerfectPhotosView *)cell indexPath:(NSIndexPath *)indexPath ;

@end

@interface XFJPleaseUpPerfectPhotosView : UIView

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, assign) NSInteger maxImageCount;

@property (nonatomic, weak) id <XFJPleaseUpPerfectPhotosViewDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@end
