//
//  XFJCheckFooterView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFJCheckFooterView : UITableViewHeaderFooterView

@property (nonatomic, copy) void (^presentChoosrNumberBlock)();
@property (nonatomic, copy) void (^cancel_buttonClickBlock)();

@end
