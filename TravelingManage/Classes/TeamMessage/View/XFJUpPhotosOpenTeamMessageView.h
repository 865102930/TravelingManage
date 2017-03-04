//
//  XFJUpPhotosOpenTeamMessageView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/4.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XFJUpPhotosOpenTeamMessageView;
@protocol XFJUpPhotosOpenTeamMessageViewDelegate <NSObject>

- (void)chooseVoucherPhotosImage:(XFJUpPhotosOpenTeamMessageView *)voucherPhotos;

- (void)jumpToCell:(XFJUpPhotosOpenTeamMessageView *)cell indexPath:(NSIndexPath *)indexPath ;

@end

@interface XFJUpPhotosOpenTeamMessageView : UIView

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, weak) id <XFJUpPhotosOpenTeamMessageViewDelegate>delegate;

@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@property (nonatomic, assign) NSInteger maxImageCount;

@end
