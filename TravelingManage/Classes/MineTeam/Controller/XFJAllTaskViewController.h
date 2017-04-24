//
//  XFJAllTaskViewController.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/15.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFJFindTeamInfoByStateItem.h"

@interface XFJAllTaskViewController : UIViewController

//定义一个block用来对标题数量发送请求
@property (nonatomic, copy) void (^requestTitleBolock)();

@property (nonatomic, strong) NSString *currentCity;

- (XFJStateType)type;

@end
