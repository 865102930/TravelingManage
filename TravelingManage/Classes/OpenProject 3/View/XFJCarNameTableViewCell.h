//
//  XFJCarNameTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/13.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface XFJCarNameTableViewCell : UIView

@property (nonatomic, strong) NSString *userLocation;

@property (nonatomic, copy) void (^addCellBlock)(NSInteger,NSString *);

@end
