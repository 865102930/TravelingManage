//
//  XFJSceneryAnnotationView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/23.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "XFJCustomCalloutView.h"
#import "XFJSceneryAnnotation.h"


@interface XFJSceneryAnnotationView : MAAnnotationView

//- (instancetype)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, readonly) XFJCustomCalloutView *calloutView;

@property (nonatomic, strong) XFJSceneryAnnotation *sceneryAnnotation;

@property (nonatomic, assign) BOOL isMineLocation;

@property (nonatomic, strong) NSMutableArray *screen_array;

@end
