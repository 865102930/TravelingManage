//
//  XFJMineTeamViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/15.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJMineTeamViewController.h"
#import "XFJAllTaskViewController.h"
#import "XFJTaskingViewController.h"
#import "XFJPleaseDoITViewController.h"
#import "XFJPleaseCheckViewController.h"
#import "XFJPleaseAskingViewController.h"
#import "XFJSubscribeButton.h"
#import "XFJFindTeamInFoStateItem.h"

@interface XFJMineTeamViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UILabel *title_label;
//设置该控制器装标题的数组
@property (nonatomic, strong) NSMutableArray *subscribeTitleArray;
//设置添加标题栏的view
@property (nonatomic, strong) UIView *titleView;
//设置一个属性记录上一个按钮的状态
@property (nonatomic, strong) UIButton *previousButton;
//设置下划线属性
@property (nonatomic, strong) UIView *underLineVeiw;
//设置添加内容的属性
@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) UILabel *firest_label;
@property (nonatomic, strong) UILabel *second_label;
@property (nonatomic, strong) UILabel *third_label;
@property (nonatomic, strong) UILabel *four_label;

@property (nonatomic, strong) NSMutableArray <XFJFindTeamInFoStateItem *> *findTeamInFoStateItemArray;

@end

@implementation XFJMineTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self setInitWithNav];
    
    [self setAllRequest];
    
    [self setUpInitController];
    
    [self setUpAllVeiwController];
    
    [self setUpInit];
    
    //显示第0个控制器
    [self addChildVCIntoScrollView:0];
    if (self.strNumber == 2) {
        for (UIView *subView in self.titleView.subviews) {
            if ([subView isKindOfClass:[UIButton class]]) {
                if (subView.tag == 2) {
                    NSLog(@"subview==%@",subView);
                    [self titleMineTeamButtonClick:(UIButton *)subView];
                }
            }
        }
    }else if (self.strNumber == 3) {
        for (UIView *subView in self.titleView.subviews) {
            if ([subView isKindOfClass:[UIButton class]]) {
                if (subView.tag == 3) {
                    NSLog(@"subview==%@",subView);
                    [self titleMineTeamButtonClick:(UIButton *)subView];
                }
            }
        }
    }else if (self.strNumber == 4){
        for (UIView *subView in self.titleView.subviews) {
            if ([subView isKindOfClass:[UIButton class]]) {
                if (subView.tag == 4) {
                    NSLog(@"subview==%@",subView);
                    [self titleMineTeamButtonClick:(UIButton *)subView];
                }
            }
        }
    }
    
    //刷新标题
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setAllRequest) name:@"REFRESHCOMMENTNSNOTICA" object:nil];
}

#pragma mark - 所有的请求接口
- (void)setAllRequest
{
    [self lineCountRequest];
}

#pragma mark - 每个标题中有多少为查看的数字接口
- (void)lineCountRequest
{
    [self.findTeamInFoStateItemArray removeAllObjects];
    NSDictionary *dictParaments = @{
                                    @"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"]
                                    };
    __weak __typeof(self)wself = self;
    [[NetWorkManager shareManager] requestWithType:HttpRequestTypeGet withUrlString:FINDTEAMINFOSTATEURL withParaments:dictParaments withSuccessBlock:^(id object) {
        if (object) {
            NSLog(@"+++++++++++获取到的团队状态数字是 :%@",object);
            [wself.findTeamInFoStateItemArray addObjectsFromArray: [XFJFindTeamInFoStateItem mj_objectArrayWithKeyValuesArray:[object objectForKey:@"rows"]]];
            for (NSInteger i = 0; i < wself.findTeamInFoStateItemArray.count; i++) {
                XFJFindTeamInFoStateItem *findTeamInFoStateItem = wself.findTeamInFoStateItemArray[i];
                if (findTeamInFoStateItem.state == 0) {
                    wself.firest_label.text = [NSString stringWithFormat:@"(%zd)",findTeamInFoStateItem.total];
                }else if (findTeamInFoStateItem.state == 1) {
                    wself.second_label.text = [NSString stringWithFormat:@"(%zd)",findTeamInFoStateItem.total];
                }else if (findTeamInFoStateItem.state == 2) {
                    wself.third_label.text = [NSString stringWithFormat:@"(%zd)",findTeamInFoStateItem.total];
                }else {
                    wself.four_label.text = [NSString stringWithFormat:@"(%zd)",findTeamInFoStateItem.total];
                }
            }
        }
    } withFailureBlock:^(NSError *error) {
        if (error) {
            NSLog(@"++=========获取到的团队状态数字失败的是:%@",error);
            [MBProgressHUD showHudTipStr:@"主人~~网络君错误啦!!" contentColor:HidWithColorContentBlack];
        }
    } progress:^(float progress) {
    }];
}

- (void)setInitWithNav
{
    self.navigationItem.titleView = self.title_label;
}

- (void)setUpInitController
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (UILabel *)title_label
{
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.XFJ_centerX, 6, 100, 44)];
        _title_label.text = @"我的团队";
        _title_label.textColor = kColor6565;
        _title_label.textAlignment = NSTextAlignmentCenter;
    }
    return _title_label;
}

- (NSMutableArray <XFJFindTeamInFoStateItem *> *)findTeamInFoStateItemArray
{
    if (_findTeamInFoStateItemArray == nil) {
        _findTeamInFoStateItemArray = [NSMutableArray array];
    }
    return _findTeamInFoStateItemArray;
}

#pragma mark - 将数组存在偏好设置中
- (void)storeSubscribeTitleArray
{
    [[NSUserDefaults standardUserDefaults] setObject:self.subscribeTitleArray forKey:@"subscribeTitleArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 懒加载控制器装标题的数组
- (NSMutableArray *)subscribeTitleArray
{
    if (_subscribeTitleArray == nil) {
        _subscribeTitleArray = [NSMutableArray array];
        //获取偏好设置中的数组进行添加
        NSArray *array = [[NSUserDefaults standardUserDefaults] arrayForKey:@"subscribeTitleArray"];
        [_subscribeTitleArray addObjectsFromArray:array];
        if (_subscribeTitleArray.count == 0) {
            [_subscribeTitleArray addObjectsFromArray:@[
                                                        @" 全部",
                                                        @"任务中",
                                                        @"待完善",
                                                        @"待审核",
                                                        @"待评价"
                                                        ]];
            //将数组存在偏好设置中
            [self storeSubscribeTitleArray];
        }
        
    }
    return _subscribeTitleArray;
}

#pragma mark - 添加所有的控制器
- (void)setUpAllVeiwController
{
    XFJTaskingViewController *taskingViewController = [[XFJTaskingViewController alloc] init];
    [self addChildViewController:[[XFJAllTaskViewController alloc] init]];
    [self addChildViewController:taskingViewController];
    [self addChildViewController:[[XFJPleaseDoITViewController alloc] init]];
    [self addChildViewController:[[XFJPleaseCheckViewController alloc] init]];
    [self addChildViewController:[[XFJPleaseAskingViewController alloc] init]];
    __weak __typeof(self)wself = self;
    taskingViewController.requestTitleBolock = ^() {
        [wself lineCountRequest];
    };
}

#pragma mark - 添加控件的方法
- (void)setUpInit
{
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.titleView];
    [self setUpTitleButton:self.subscribeTitleArray];
    [self setUpUnderLineView];
    [self.titleView addSubview:self.underLineVeiw];
    //不要调整scrollerView的内边距
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

#pragma mark - 懒加载标题栏
- (UIView *)titleView
{
    if (_titleView == nil) {
        _titleView = [[UIView alloc] init];
        _titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
        _titleView.backgroundColor = [UIColor whiteColor];
    }
    return _titleView;
}


#pragma mark - 添加标题按钮
- (void)setUpTitleButton:(NSMutableArray *)subscribeTitleArray
{
    NSInteger count = subscribeTitleArray.count;
    CGFloat titleButtonX = 0.0;
    CGFloat titleButtonY = 0.0;
    CGFloat titleButtonW = self.titleView.XFJ_Width / count;
    CGFloat titleButtonH = self.titleView.XFJ_Height;
    for (NSInteger i = 0; i < count; i++) {
        XFJSubscribeButton *titleButtons = [[XFJSubscribeButton alloc] init];
        titleButtonX = i * titleButtonW;
        titleButtons.tag = i;
        titleButtons.frame = CGRectMake(titleButtonX, titleButtonY, titleButtonW, titleButtonH);
        [titleButtons setTitle:subscribeTitleArray[i] forState:UIControlStateNormal];
        [titleButtons addTarget:self action:@selector(titleMineTeamButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 1) {
            [self contentWithNameLabel:self.firest_label contentButton:titleButtons];
        }else if (i == 2) {
            [self contentWithNameLabel:self.second_label contentButton:titleButtons];
        }else if (i == 3) {
            [self contentWithNameLabel:self.third_label contentButton:titleButtons];
        }else {
            [self contentWithNameLabel:self.four_label contentButton:titleButtons];
        }
        [self.titleView addSubview:titleButtons];
    }
}

- (void)setStrNumber:(NSInteger)strNumber
{
    _strNumber = strNumber;
    
}

- (void)contentWithNameLabel:(UILabel *)nameLabel contentButton:(UIButton *)contentButton
{
    contentButton.titleEdgeInsets = UIEdgeInsetsMake(0, -9, 0, 0);
    [contentButton addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(contentButton.mas_centerY);
        if (iphone6) {
            make.right.mas_equalTo(contentButton.mas_right).mas_offset(0);
        }else if (iphone5) {
            make.right.mas_equalTo(contentButton.mas_right).mas_offset(0);
        }else if (iphone6P) {
            make.right.mas_equalTo(contentButton.mas_right).mas_offset(-3.0);
        }
    }];
}


- (UILabel *)firest_label
{
    if (_firest_label == nil) {
        _firest_label = [[UILabel alloc] init];
        _firest_label.textColor = kColorff47;
        _firest_label.font = [UIFont systemFontOfSize:11.0];
    }
    return _firest_label;
}

- (void)returnRangColorWithString:(NSMutableAttributedString *)string
{
    [string addAttribute:NSForegroundColorAttributeName value:kColorff47 range:NSMakeRange(1,1)];
    [string addAttribute:NSForegroundColorAttributeName value:kColor6565 range:NSMakeRange(0,1)];
    [string addAttribute:NSForegroundColorAttributeName value:kColor6565 range:NSMakeRange(2,1)];
}

- (UILabel *)second_label
{
    if (_second_label == nil) {
        _second_label = [[UILabel alloc] init];
        _second_label.textColor = kColorff47;
        _second_label.font = [UIFont systemFontOfSize:11.0];
    }
    return _second_label;
}

- (UILabel *)third_label
{
    if (_third_label == nil) {
        _third_label = [[UILabel alloc] init];
        _third_label.textColor = kColorff47;
        _third_label.font = [UIFont systemFontOfSize:11.0];
    }
    return _third_label;
}

- (UILabel *)four_label
{
    if (_four_label == nil) {
        _four_label = [[UILabel alloc] init];
        _four_label.textColor = kColorff47;
        _four_label.font = [UIFont systemFontOfSize:11.0];
    }
    return _four_label;
}

#pragma mark - 监听按钮的点击
- (void)titleMineTeamButtonClick:(UIButton *)button
{
    self.previousButton.selected = NO;
    button.selected = YES;
    self.previousButton = button;
    NSInteger index = [self.titleView.subviews indexOfObject:button];
    __weak typeof (self) weakself = self;
    [UIView animateWithDuration:0.25 animations:^{
        if (iphone5) {
            //点击按钮的时候线的移动
            weakself.underLineVeiw.XFJ_Width = 63.0;
        }else if (iphone6P) {
            weakself.underLineVeiw.XFJ_Width = 85.0;
        }else if (iphone6) {
            weakself.underLineVeiw.XFJ_Width = 75.0;
        }
        weakself.underLineVeiw.XFJ_centerX = button.XFJ_centerX;
        //相应的控制器的移动
        NSInteger index = [weakself.titleView.subviews indexOfObject:button];
        weakself.contentView.contentOffset = CGPointMake(index * SCREEN_WIDTH,
                                                         weakself.contentView.bounds.origin.y);
    }completion:^(BOOL finished) {
        [weakself addChildVCIntoScrollView:index];
    }];
}

#pragma mark - 懒加载下划线
- (UIView *)underLineVeiw
{
    if (_underLineVeiw == nil) {
        _underLineVeiw = [[UIView alloc] init];
        CGFloat underLineX = 0;
        CGFloat underLineH = 2;
        CGFloat underLineY = self.titleView.XFJ_Height - underLineH;
        CGFloat underLineW = 0;
        _underLineVeiw.frame = CGRectMake(underLineX, underLineY, underLineW, underLineH);
        _underLineVeiw.backgroundColor = kColorff47;
    }
    return _underLineVeiw;
}

#pragma mark - 设置线的状态
- (void)setUpUnderLineView
{
    XFJSubscribeButton *firestButton = self.titleView.subviews.firstObject;
    firestButton.selected = YES;
    self.previousButton = firestButton;
    [firestButton.titleLabel sizeToFit];
    if (iphone5) {
        self.underLineVeiw.XFJ_Width = 63.0;
    }else if (iphone6P) {
        self.underLineVeiw.XFJ_Width = 85.0;
    }else if (iphone6) {
        self.underLineVeiw.XFJ_Width = 75.0;
    }
    self.underLineVeiw.XFJ_centerX = firestButton.XFJ_centerX;
}

#pragma mark - 懒加载内容控制器
- (UIScrollView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64);
        NSInteger count = self.childViewControllers.count;
        _contentView.pagingEnabled = YES;
        _contentView.delegate = self;
        _contentView.contentSize = CGSizeMake(count * SCREEN_WIDTH, 0);
        _contentView.backgroundColor = DEF_RGB_COLOR(214, 214, 214);
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.showsHorizontalScrollIndicator = NO;
    }
    return _contentView;
}

#pragma mark - 添加对应的子控制器的view到scrollerView中
- (void)addChildVCIntoScrollView:(NSInteger)index
{
    UIViewController *childVC = self.childViewControllers[index];
    if ([childVC isViewLoaded]) return;
    childVC.view.frame = self.contentView.bounds;
    [self.contentView addSubview:childVC.view];
}

#pragma mark - 滑动完毕的时候调用
#pragma mark - scrollerView的代理方法(设置拖动scrollerView与标题按钮联动)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    XFJSubscribeButton *titleButton = self.titleView.subviews[index];
    if (self.previousButton == titleButton) return;
    [self titleMineTeamButtonClick:titleButton];
}

- (void)dealloc
{
    NSLog(@"我的控制器被销毁了~~");
}



@end
