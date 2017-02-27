//
//  XFJGuestSourceInformationTableViewCell.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/13.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "LMComBoxView.h"

@interface XFJGuestSourceInformationTableViewCell : UIView <LMComBoxViewDelegate>

//所选择的省
@property (nonatomic, strong) NSString *selectedProvince;

//所选择的市
@property (nonatomic, strong) NSString *selectedCity;

//所选择的区
@property (nonatomic, strong) NSString *selectedArea;

//目的属性
@property (nonatomic, assign) NSInteger paramName1;


@end
