//
//  XFJFindCustomAttrListItem.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/7.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFJFindCustomAttrListItem : NSObject

//自定义属性
@property (nonatomic, strong) NSString *teamAttr;
//自定义属性名称
@property (nonatomic, strong) NSString *userName;
//文本的样式
@property (nonatomic, assign) int attrType;
//不是;是
@property (nonatomic, assign) BOOL isRequire;

@end
