//
//  XFJPleaseAskingViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/15.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJPleaseAskingViewController.h"

@interface XFJPleaseAskingViewController ()

@end

@implementation XFJPleaseAskingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
}

- (XFJStateType)type
{
    return 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
