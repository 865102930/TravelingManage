//
//  MessageListViewController.m
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/10.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "MessageListViewController.h"
#import "MessageViewController.h"
#import "XFJAnnouncementViewController.h"
#import "PageButton.h"

@interface MessageListViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIView *titlesView;
@property (nonatomic, weak) UIView *titleUnderline;
@property (nonatomic, weak) PageButton *previousClickedTitleButton;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) UIView *unreadMessageView;
@end

@implementation MessageListViewController

//- (UIView *)unreadMessageView
//{
//    if (!_unreadMessageView) {
//        _unreadMessageView = [[UIView alloc] initWithFrame:CGRectMake(30, 100, 6, 6)];
//        _unreadMessageView.layer.masksToBounds = YES;
//        _unreadMessageView.layer.cornerRadius = 3;
//        _unreadMessageView.backgroundColor = RedColor;
//        [_titlesView addSubview:_unreadMessageView];
//    }
//    return _unreadMessageView;
//}

- (UILabel *)title_label {
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.XFJ_centerX, 6, 100, 44)];
        _title_label.text = @"消息列表";
        _title_label.textColor = kColor6565;
        _title_label.textAlignment = NSTextAlignmentCenter;
    }
    return _title_label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackgroudColor;
    self.navigationItem.titleView = self.title_label;
    [self setupChildVCs];
    [self setupScrollView];
    [self setupTitlesView];
    [self addChildVcViewIntoScrollView:0];
    if (self.strNum == 2) {
        for (UIView *subView in self.titlesView.subviews) {
            if ([subView isKindOfClass:[UIButton class]]) {
                if (subView.tag == 1) {
                    NSLog(@"subview==%@",subView);
                    [self titleButtonClick:(PageButton *)subView];
                }
            }
        }
    }
    [self loadData];
}

- (void)loadData {
    NSDictionary *dictParaments = @{
                                    @"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"],
                                    };
    [[NetWorkManager shareManager] requestWithType:HttpRequestTypeGet withUrlString:MESSAGELISTTOTAL withParaments:dictParaments withSuccessBlock:^(id object) {
        if (object) {
            NSLog(@"%@",object);
            NSInteger total = [object [@"object"] integerValue];
             if(total == 0) {
                _unreadMessageView.backgroundColor = [UIColor clearColor];
            }else{
                _unreadMessageView.backgroundColor = RedColor;
            }
        }
    } withFailureBlock:^(NSError *error) {
        if (error) {
            
        }
    } progress:^(float progress) {
        
    }];
}
//  初始化子控制器
- (void)setupChildVCs
{
    [self addChildViewController:[[MessageViewController alloc] init]];
    [self addChildViewController:[[XFJAnnouncementViewController alloc] init]];
}

//  scrollView
- (void)setupScrollView
{
    NSInteger count = self.childViewControllers.count;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = self.view.bounds;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollEnabled = NO;
    scrollView.contentSize = CGSizeMake(count * scrollView.XFJ_Width, 0);
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

//标题栏
- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
    
    titlesView.frame = CGRectMake(0, 64, self.view.XFJ_Width, 46);
    titlesView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = kColorD7D7D7;
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titlesView.mas_bottom).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.height.mas_equalTo(3);
    }];
    [self setupTitleButtons];
    [self setupTitleUnderline];
}

//下划线
- (void)setupTitleUnderline
{
    
    PageButton *firstTitleButton = self.titlesView.subviews.firstObject;
    
    UIView *titleUnderline = [[UIView alloc] init];
    CGFloat titleUnderlineH = 2;
    CGFloat titleUnderlineY = self.titlesView.XFJ_Height - titleUnderlineH;
    titleUnderline.frame = CGRectMake(0, titleUnderlineY, 0, titleUnderlineH);
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderline];
    self.titleUnderline = titleUnderline;
    
    _unreadMessageView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3 , 13, 6, 6)];
    _unreadMessageView.layer.masksToBounds = YES;
    _unreadMessageView.layer.cornerRadius = 3;
    [_titlesView addSubview:_unreadMessageView];
    
    // 新点击的按钮
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    
    // 下划线
    [firstTitleButton.titleLabel sizeToFit];
    self.titleUnderline.XFJ_Width =firstTitleButton.titleLabel.XFJ_Width + 10;
    self.titleUnderline.XFJ_centerX = firstTitleButton.XFJ_centerX;
}


//  标题按钮
- (void)setupTitleButtons
{
    NSArray *titles =@[@"消息",@"公告"];
    NSUInteger count = titles.count;
    CGFloat titleButtonH = self.titlesView.XFJ_Height;
    CGFloat titleButtonW = self.titlesView.XFJ_Width / count;

    for (NSInteger i = 0; i < count; i++) {
        PageButton *titleButton = [[PageButton alloc] init];
        titleButton.tag = i;
        
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        [self.titlesView addSubview:titleButton];
    }
}


#pragma mark - 监听点击
//监听标题按钮点击
- (void)titleButtonClick:(PageButton *)titleButton
{
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    NSInteger index = titleButton.tag;
    
    // 下划线
    [UIView animateWithDuration:0.25 animations:^{
        if (self.strNum == 2) {
            self.titleUnderline.XFJ_Width = 43.0;
            self.titleUnderline.XFJ_centerX = titleButton.XFJ_centerX;
        }else {
            self.titleUnderline.XFJ_Width = titleButton.titleLabel.XFJ_Width + 10;
            NSLog(@">>>>>>>>--------标题下划线的宽度是 :%f",self.titleUnderline.XFJ_Width);
            self.titleUnderline.XFJ_centerX = titleButton.XFJ_centerX;
        }
        // 滑动scrollView到对应的子控制器界面
        CGPoint offset = self.scrollView.contentOffset;
        offset.x = index * self.scrollView.XFJ_Width;
        self.scrollView.contentOffset = offset;
    } completion:^(BOOL finished) {
        // 添加index位置的子控制器view到scrollView中
        [self addChildVcViewIntoScrollView:index];
        
    }];}

// scrollView滑动完毕的时候调用(速度减为0的时候调用)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.XFJ_Width;
    PageButton *titleButton = self.titlesView.subviews[index];
    [self titleButtonClick:titleButton];
}


#pragma mark - 其他
//添加index位置的子控制器view到scrollView中
- (void)addChildVcViewIntoScrollView:(NSInteger)index
{
    UIView *childVcView = self.childViewControllers[index].view;
    childVcView.frame = CGRectMake(index * self.scrollView.XFJ_Width, 46, self.scrollView.XFJ_Width, self.scrollView.XFJ_Height);
    [self.scrollView addSubview:childVcView];
}

@end
