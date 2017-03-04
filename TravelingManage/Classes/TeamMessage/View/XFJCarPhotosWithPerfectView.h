//
//  XFJCarPhotosWithPerfectView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/4.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XFJCarPhotosWithPerfectView;
@protocol XFJCarPhotosWithPerfectViewDelegate  <NSObject>

- (void)chooseImage:(XFJCarPhotosWithPerfectView *)SerPhotoCell;
- (void)jumpCell:(XFJCarPhotosWithPerfectView *)cell indexPath:(NSIndexPath *)indexPath ;

@end

@interface XFJCarPhotosWithPerfectView : UIView

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, assign) NSInteger maxImageCount;

@property (nonatomic, weak) id <XFJCarPhotosWithPerfectViewDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@end
