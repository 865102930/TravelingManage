//
//  XFJSignView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/23.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XFJSignViewDelegate <NSObject>

- (void)signButtonClick;

@end

@interface XFJSignView : UIView

@property (nonatomic, copy) void (^signButtonClickBlock)();
@property (nonatomic, copy) void (^signModifyCount)(NSString *, BOOL);
@property (nonatomic, strong) NSString *peopleNumberStr;
@property (nonatomic, assign) BOOL isSingCount;

@property (nonatomic, weak) id <XFJSignViewDelegate>delegate;

@end
