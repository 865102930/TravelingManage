//
//  MessageCell.h
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/13.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageModel;
@interface MessageCell : UITableViewCell

@property (nonatomic, strong) UILabel     *titleLabel;//标题
@property (nonatomic, strong) UIView      *circleView;//圆圈
@property (nonatomic, strong) UILabel     *contentLabel;//内容
@property (nonatomic, strong) UILabel     *timeLabel;//时间
@property (nonatomic, strong) UIButton    *deleteButton;//删除按钮
@property (nonatomic, strong) UIView     *deleteView;//删除按钮
@property (nonatomic, strong) UIImageView *enterIntoImage;//进入下一页按钮
@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)initWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) MessageModel *messageM;
@end
