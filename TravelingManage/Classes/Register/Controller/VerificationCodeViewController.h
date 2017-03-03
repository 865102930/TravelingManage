//
//  VerificationCodeViewController.h
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/9.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerificationCodeViewController : UIViewController

@property (nonatomic, strong) NSString *registTextField_text;

@property (nonatomic, assign) BOOL isVerificationCodeVC;

@property (nonatomic, assign) BOOL isNewVerificationCodeVC;//是否是新手机号验证码页面

@property (nonatomic, strong) NSUserDefaults *user;


@end
