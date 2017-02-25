//
//  XFJOpenGroupViewController.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/10.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XFJOpenGroupViewControllerDelegate <NSObject>

- (void)teamPeopleNumber:(NSString *)peopleNumber teamId:(NSString *)teamId;

@end

@interface XFJOpenGroupViewController : UIViewController

@property (nonatomic, strong) NSString *locationWithUser;

@property (nonatomic, copy) void (^signViewBlock)(NSString *, NSString *);

@property (nonatomic, weak) id <XFJOpenGroupViewControllerDelegate>delegate;

@end
