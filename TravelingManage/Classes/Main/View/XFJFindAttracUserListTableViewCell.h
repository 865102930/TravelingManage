//
//  XFJFindAttracUserListTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/21.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#define KCellIdentifier_XFJFindAttracUserListTableViewCell @"XFJFindAttracUserListTableViewCell"


#import <UIKit/UIKit.h>
#import "XFJFindAttracUserListItem.h"

@interface XFJFindAttracUserListTableViewCell : UITableViewCell

@property (nonatomic, strong) XFJFindAttracUserListItem *findAttracUserListItem;

@end
