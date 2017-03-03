//
//  AnnouncementCell.h
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/13.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AnnouncementModel;

@interface AnnouncementCell : UITableViewCell

@property (nonatomic, strong) UILabel     *titleLabel;//标题
@property (nonatomic, strong) UIView      *circleView;//圆圈
@property (nonatomic, strong) UILabel     *contentLabel;//内容
@property (nonatomic, strong) UILabel     *timeLabel;//时间
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UIView      *grayView;//cell灰色线
+ (instancetype)initWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) AnnouncementModel *announcementM;
@end
