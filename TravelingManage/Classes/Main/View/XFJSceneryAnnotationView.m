//
//  XFJSceneryAnnotationView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/23.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSceneryAnnotationView.h"

#define kCalloutWidth       200.0
#define kCalloutHeight      70.0
@interface XFJSceneryAnnotationView()

@property (nonatomic, strong, readwrite) XFJCustomCalloutView *calloutView;

@end

@implementation XFJSceneryAnnotationView

- (instancetype)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        self.bounds = CGRectMake(0.f, 0.f, 13, 31);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        UIImage *qiImage = [UIImage imageNamed:@"location-map"];
        UIImageView *activityPopView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 31)];
        [activityPopView setImage:qiImage];
        [activityPopView setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview:activityPopView];
    }
    return self;
}

- (void)setSceneryAnnotation:(XFJSceneryAnnotation *)sceneryAnnotation
{
    _sceneryAnnotation = sceneryAnnotation;
    
    NSLog(@"-------->>>>--------景点的名称是 :%@",sceneryAnnotation);
}

- (void)setScreen_array:(NSMutableArray *)screen_array
{
    _screen_array = screen_array;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected) return;
    if (selected){
        if (self.calloutView == nil){
            self.calloutView = [[XFJCustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        }
        
        self.calloutView.subtitle = self.sceneryAnnotation.attractionsName;
        self.calloutView.title = @"当前可签到的景点";
        NSLog(@">>>>>>>>>>打印出来的景点名字是:%@",self.sceneryAnnotation.attractionsName);
        NSLog(@"<<<<<<<<<--------------景点总数是 :%@",self.screen_array);
        [self addSubview:self.calloutView];
    }else{
        
        [self.calloutView removeFromSuperview];
    }
    [super setSelected:selected animated:animated];
}


@end
