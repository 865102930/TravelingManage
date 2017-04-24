//
//  XFJPurposeItem.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/21.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFJPurposeItem : NSObject
//目的属性
@property (nonatomic, strong) NSString *explainName;
//目的属性类型
@property (nonatomic, strong) NSString *paramName;

//目的属性id
@property (nonatomic, assign) NSInteger purpose_id;

@property (nonatomic, strong) NSString *paramVal;


@end
