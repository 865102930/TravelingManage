//
//  PersonalInformationViewController.h
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/9.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalInformationViewController : UIViewController

@property (nonatomic, strong) NSUserDefaults *user;

@property (nonatomic, strong) NSString *phoneNum_text;

@property (nonatomic, strong) NSString *idCode_text;//验证码
@end
