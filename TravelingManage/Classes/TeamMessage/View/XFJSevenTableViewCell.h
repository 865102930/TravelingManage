//
//  XFJSevenTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/8.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

//选择照片
#define KCellIdentifier_XFJSevenTableViewCell @"XFJSevenTableViewCell"


#import <UIKit/UIKit.h>

@class TZImagePickerController;
@interface XFJSevenTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^presentPickPhotosBlock)(TZImagePickerController *);


@end
