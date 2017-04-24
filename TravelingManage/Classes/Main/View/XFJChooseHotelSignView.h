//
//  XFJChooseHotelSignView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/22.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFJFindAttractionsListItem.h"
#import "XFJTaskRowsItem.h"

@interface XFJChooseHotelSignView : UIView

@property (nonatomic, strong) NSMutableArray <XFJFindAttractionsListItem *> *hotel_array;
@property (nonatomic, copy) void (^chooseBlockButtonWithSure)(XFJFindAttractionsListItem *);
@property (nonatomic, copy) void (^chooseBlockButtonWithCancel)();
@property (nonatomic, strong) NSMutableArray <XFJTaskRowsItem *> *taskRowsItemArray;


@end
