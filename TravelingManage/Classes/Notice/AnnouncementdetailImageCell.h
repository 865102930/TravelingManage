//
//  AnnouncementdetailImageCell.h
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/16.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnouncementdetailImageCell : UITableViewCell

@property (strong, nonatomic) UIImageView *detailImage;
@property (strong, nonatomic) UIView *lineV1;
@property (strong, nonatomic) UIView *lineV2;

+ (instancetype)initWithTableView:(UITableView *)tableView;

@end
