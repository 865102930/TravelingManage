//
//  XFJCheckBoxView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFJCheckBoxView : UIView

@property (nonatomic, strong) NSString *backStr;
@property (nonatomic, copy) void (^chooseCheckBoxBlock)(NSString *);

@end
