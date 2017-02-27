//
//  XFJSignNoPeopleView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/24.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFJTeamSignListItem.h"
@interface XFJSignNoPeopleView : UIView

//签退时候调用的block
@property (nonatomic, copy) void (^signNoButtonClickBlock)();
//签退页面的人数
@property (nonatomic, strong) NSMutableArray<XFJTeamSignListItem *> *signNoPeopleArray;

@end
