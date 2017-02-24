//
//  XFJSceneryAnnotationView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/23.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface XFJSceneryAnnotationView : MAAnnotationView

- (instancetype)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;

@end
