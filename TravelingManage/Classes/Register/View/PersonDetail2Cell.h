//
//  PersonDetail2Cell.h
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/16.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonDetail2Cell : UITableViewCell

@property (nonatomic, strong) UILabel     *title;//姓名标题
@property (nonatomic, strong) UILabel     *content;//姓名
@property (nonatomic, strong) UIImageView *rightImage;//姓名
+ (instancetype)initWithTableView:(UITableView *)tableView;
@end
