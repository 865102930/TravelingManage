//
//  XFJSignView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/23.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFJSignView : UIView

@property (nonatomic, copy) void (^signButtonClickBlock)();

@property (nonatomic, strong) NSString *peopleNumberStr;

@end