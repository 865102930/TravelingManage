//
//  XFJMeDetailsViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/4/10.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJMeDetailsViewController.h"

@interface XFJMeDetailsViewController ()

@property (nonatomic, strong) UILabel *title_label;

@end

@implementation XFJMeDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setInitWithNav];
    
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)setInitWithNav
{
    self.navigationItem.titleView = self.title_label;
}

- (UILabel *)title_label
{
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.XFJ_centerX, 6, 100, 44)];
        _title_label.text = @"团队详情";
        _title_label.textColor = kColor6565;
        _title_label.textAlignment = NSTextAlignmentCenter;
    }
    return _title_label;
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
