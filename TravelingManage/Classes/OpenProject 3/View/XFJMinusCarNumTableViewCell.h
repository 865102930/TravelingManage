//
//  XFJMinusCarNumTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/16.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#define kReuseIdentifier_XFJMinusCarNumTableViewCell @"XFJMinusCarNumTableViewCell"


#import <UIKit/UIKit.h>
#import "XFJCarNumberItem.h"
#import "XFJFindTeamCarItem.h"

@interface XFJMinusCarNumTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^minusCarNumBlock)(UITableViewCell *);
//传递用户输入的车辆
@property (nonatomic, copy) void (^AllMinusCarNumberBlock)(NSString *, UITableViewCell *);
@property (nonatomic, strong) NSString *textFieldStr;

@property (nonatomic, strong) NSMutableArray<XFJCarNumberItem *> *carNumberItemArray;
@property (nonatomic, strong) XFJFindTeamCarItem *findTeamCarItem;

@property (nonatomic, strong) NSString *carNum;


@end
