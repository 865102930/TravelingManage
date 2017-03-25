//
//  XFJChooseSceneryTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/11.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#define KCellIdentifier_XFJChooseSceneryTableViewCell @"XFJChooseSceneryTableViewCell"


#import <UIKit/UIKit.h>
#import "XFJFindAttractionsListItem.h"
@interface XFJChooseSceneryTableViewCell : UITableViewCell

@property (nonatomic, strong) XFJFindAttractionsListItem *findAttractionsListItem;
@property (nonatomic, copy) void (^chichButtonChooseBlock)(UIButton *);
@property (nonatomic, strong) UIButton *sceneryContent_button;
@property (nonatomic, strong) XFJFindAttractionsListItem *findAttractionsListItem2;


+ (CGFloat)cellHeight;

@end
