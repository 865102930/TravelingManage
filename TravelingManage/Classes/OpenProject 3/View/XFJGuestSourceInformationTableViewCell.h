//
//  XFJGuestSourceInformationTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/13.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#define KCellIdentifier_XFJGuestSourceInformationTableViewCell @"XFJGuestSourceInformationTableViewCell"

#import <UIKit/UIKit.h>
#import "LMComBoxView.h"

@interface XFJGuestSourceInformationTableViewCell : UITableViewCell <LMComBoxViewDelegate>

+ (CGFloat)cellHeight;

@end
