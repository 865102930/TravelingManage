//
//  DropDownTableViewCell.m
//  TravelingManage
//
//  Created by gz on 17/4/14.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "DropDownTableViewCell.h"

@implementation DropDownTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    self.singListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.singListButton setImage:[UIImage imageNamed:@"cycle@2x"] forState:UIControlStateNormal];
    self.nameLabel = [[UILabel alloc] init];
    [self addSubview:self.singListButton];
    [self addSubview:self.nameLabel];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.nameLabel.frame = CGRectMake(10, 7, 100, 30);
    self.singListButton.frame = CGRectMake(self.bounds.size.width - 50, 15, 14, 14);
}


@end
