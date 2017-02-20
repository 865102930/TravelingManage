//
//  XFJTitleMessageContentTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/20.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#define KCellIdentifier_XFJTitleMessageContentTableViewCell @"XFJTitleMessageContentTableViewCell"


#import <UIKit/UIKit.h>

@interface XFJTitleMessageContentTableViewCell : UITableViewCell

+ (CGFloat)cellHeight;

- (void)setTitle:(NSString *)title content:(NSString *)content;

@end
