//
//  HomeViewController.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/6.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TopicEditType) {
    TopicEditTypeAdd = 0,
    TopicEditTypeModify,
    TopicEditTypeFeedBack
};

@interface HomeViewController : UIViewController

@property (nonatomic, assign) BOOL isProjectItem;
@property (nonatomic, assign) BOOL isFindTeamList;
@property (nonatomic, assign) BOOL isSecondProjectItem;

@end
