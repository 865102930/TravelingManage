//
//  XFJFindAttracUserListView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/21.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFJFindAttracUserListItem.h"

@interface XFJFindAttracUserListView : UIView

@property (nonatomic, strong) NSMutableArray <XFJFindAttracUserListItem *> *findAttracUserListItem;
@property (nonatomic, strong) void (^sureUserButtonClickBlock)(NSMutableArray <XFJFindAttracUserListItem *> *);
@property (nonatomic, copy) void (^cancelUserButtonClickBlock)();

@end
