//
//  XFJCarNameTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/13.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#define kReuseIdentifier_XFJCarNameTableViewCell @"XFJCarNameTableViewCell"

#import <UIKit/UIKit.h>
@class XFJCarNumberItem;
@interface XFJCarNameTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString *userLocation;
@property (nonatomic, copy) void (^addCellBlock)(NSInteger,NSString *);
@property (nonatomic, copy) void (^carNumberBlock)(NSString *);
@property (nonatomic, strong) NSString *str;
@property (nonatomic, strong) NSMutableArray<XFJCarNumberItem *> *carNumberItemArray;
@property (nonatomic, strong) NSString *addStrNumber;
@property (nonatomic, assign) BOOL isAddStrBool;

@end
