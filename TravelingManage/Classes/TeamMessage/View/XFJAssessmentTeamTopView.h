//
//  XFJAssessmentTeamTopView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/6.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFJAssessmentTeamTopView : UIView

//将用户的评分传入控制器中
@property (nonatomic, copy) void (^commitStarBlock)(NSString *);


@end
