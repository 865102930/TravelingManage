//
//  XFJTitleMessageTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/20.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#define KCellIdentifier_XFJTitleMessageTableViewCell @"XFJTitleMessageTableViewCell"

#import <UIKit/UIKit.h>

@interface XFJTitleMessageTableViewCell : UITableViewCell

+ (CGFloat)cellHeight;

- (void)setTitle:(NSString *)title;

@end
