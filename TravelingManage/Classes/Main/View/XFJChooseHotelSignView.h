//
//  XFJChooseHotelSignView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/22.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFJFindAttractionsListItem.h"

@interface XFJChooseHotelSignView : UIView

@property (nonatomic, strong) NSMutableArray *hotel_array;
@property (nonatomic, copy) void (^chooseBlockButtonWithSure)(XFJFindAttractionsListItem *);

@end
