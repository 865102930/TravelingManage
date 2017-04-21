//
//  XFJSceneryAnnotationView.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/23.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSceneryAnnotationView.h"

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


@end
