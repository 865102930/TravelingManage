//
//  XFJChooseHotelFooterView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/22.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFJChooseHotelFooterView : UIView

@property (nonatomic, copy) void (^sureChoose_buttonClickBlock)();
@property (nonatomic, copy) void (^cancelChoose_buttonClickBlock)();

@end
