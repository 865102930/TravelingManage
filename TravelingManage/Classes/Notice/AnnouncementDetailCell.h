//
//  AnnouncementDetailCell.h
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/15.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnouncementDetailCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;//标题
@property (nonatomic, strong) UILabel *conentLabe;//内容
@property (nonatomic, strong) UILabel *timeLabel;//时间
@property (nonatomic, strong) UIImageView *detailImage;//图片
@property (nonatomic, strong) UIView *lineV;

+ (instancetype)initWithTableView:(UITableView *)tableView;
@end
