//
//  XFJGuestSourceInformationTableViewCell.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/13.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJGuestSourceInformationTableViewCell.h"
#import "LMContainsLMComboxScrollView.h"
#import "XFJPurposeItem.h"

#define kDropDownListTag 1000

@interface XFJGuestSourceInformationTableViewCell() <UITableViewDelegate,UITableViewDataSource>
{
    LMContainsLMComboxScrollView *bgScrollView;
    NSMutableDictionary *addressDict;   //地址选择字典
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    NSString *selectedProvince;
    NSString *selectedCity;
    NSString *selectedArea;
}

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIImageView *guestSourceInformation_imageVeiw;

@property (nonatomic, strong) UILabel *guestSourceInformation_label;

@property (nonatomic, strong) UIButton *goalAttribute_button;

@property (nonatomic, strong) UILabel *goalAttribute_label;

@property (nonatomic, strong) UIImageView *goalAttribute_imageViewLeft;

@property (nonatomic, strong) UIImageView *goalAttribute_imageViewRight;

@property (nonatomic, strong) UILabel *goalAttributeContent_label;

@property (nonatomic, strong) UITableView *goalAttributeTableView;

@property (nonatomic, strong) NSArray *goalAttributeArray;

//创建一个可变数组用来装目的属性的种类
@property (nonatomic, strong) NSMutableArray <XFJPurposeItem *> *purposeArray;


@end

@implementation XFJGuestSourceInformationTableViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initShu];
        [self requestPurposeAttribute];
        [self addSubview:self.lineView];
        [self addSubview:self.guestSourceInformation_imageVeiw];
        [self addSubview:self.guestSourceInformation_label];
        [bgScrollView addSubview:self.goalAttribute_button];
        [self.goalAttribute_button addSubview:self.goalAttributeContent_label];
        [self.goalAttribute_button addSubview:self.goalAttribute_label];
        [self.goalAttribute_button addSubview:self.goalAttribute_imageViewLeft];
        [self.goalAttribute_button addSubview:self.goalAttribute_imageViewRight];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.mas_left);
            make.height.mas_equalTo(3.0);
            make.right.mas_equalTo(self.mas_right);
        }];
        [self.guestSourceInformation_imageVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(30.0);
            make.left.mas_equalTo(18.0);
            make.height.mas_equalTo(15.0);
            make.width.mas_equalTo(13.0);
        }];
        [self.guestSourceInformation_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.guestSourceInformation_imageVeiw.mas_centerY);
            make.left.mas_equalTo(self.guestSourceInformation_imageVeiw.mas_right).mas_offset(10.0);
        }];
        [self.goalAttribute_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(110.0);
            make.left.mas_equalTo(self.mas_left).mas_offset(18.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-18.0);
            make.height.mas_equalTo(38.0);
        }];
        [self.goalAttribute_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.goalAttribute_button.mas_centerY);
            make.left.mas_equalTo(self.goalAttribute_button.mas_left).mas_offset(15.0);
        }];
        [self.goalAttribute_imageViewLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.goalAttribute_button.mas_top).mas_offset(13.0);
            make.left.mas_equalTo(self.goalAttribute_label.mas_right).mas_offset(5.0);
            make.height.mas_equalTo(5.0);
            make.width.mas_equalTo(5.0);
        }];
        [self.goalAttribute_imageViewRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.goalAttribute_button.mas_right).mas_offset(-2);
            make.centerY.mas_equalTo(self.goalAttribute_button.mas_centerY);
            make.height.mas_equalTo(6.0);
            make.width.mas_equalTo(8.0);
        }];
        [self.goalAttributeContent_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.goalAttribute_imageViewLeft.mas_right).mas_offset(18.0);
            make.centerY.mas_equalTo(self.goalAttribute_label.mas_centerY);
        }];
    }
    return self;
}

- (NSMutableArray<XFJPurposeItem *> *)purposeArray
{
    if (_purposeArray == nil) {
        _purposeArray = [NSMutableArray array];
    }
    return _purposeArray;
}

#pragma makr - 目的属性
- (void)requestPurposeAttribute
{
    NSDictionary *dictParaments = @{
                                    @"state":@"0"
                                    };
    __weak __typeof(self)wself = self;
    [[NetWorkManager shareManager] requestWithType:HttpRequestTypeGet withUrlString:TEAMNUMBERQUERYURL withParaments:dictParaments withSuccessBlock:^(id object) {
        NSLog(@"+++++++获取到的目的属性的值是 :%@",object);
        if (object) {
            //取出
            NSMutableArray *purposeRows = [object objectForKey:@"rows"];
            wself.purposeArray = [XFJPurposeItem mj_objectArrayWithKeyValuesArray:purposeRows];
            [wself.goalAttributeTableView reloadData];
        }
    } withFailureBlock:^(NSError *error) {
        if (error) {
            [MBProgressHUD showHudTipStr:@"请求出错" contentColor:HidWithColorContentBlack];
        }
    } progress:^(float progress) {
    }];
}


- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kColoreeee;
    }
    return _lineView;
}

- (UIImageView *)guestSourceInformation_imageVeiw
{
    if (_guestSourceInformation_imageVeiw == nil) {
        _guestSourceInformation_imageVeiw = [[UIImageView alloc] init];
        _guestSourceInformation_imageVeiw.image = [UIImage originalWithImage:@"information-"];
    }
    return _guestSourceInformation_imageVeiw;
}

- (UILabel *)guestSourceInformation_label
{
    if (_guestSourceInformation_label == nil) {
        _guestSourceInformation_label = [[UILabel alloc] init];
        _guestSourceInformation_label.text = @"客源信息";
        _guestSourceInformation_label.textColor = kColorff47;
        [_guestSourceInformation_label setFont:[UIFont systemFontOfSize:15.0]];
        _guestSourceInformation_label.textAlignment = NSTextAlignmentLeft;
    }
    return _guestSourceInformation_label;
}

- (UIButton *)goalAttribute_button
{
    if (_goalAttribute_button == nil) {
        _goalAttribute_button = [UIButton buttonWithType:UIButtonTypeCustom];
        _goalAttribute_button.layer.borderColor = kBorderColor.CGColor;
        _goalAttribute_button.layer.borderWidth = 0.5;
        _goalAttribute_button.layer.cornerRadius = 3.0;
        _goalAttribute_button.clipsToBounds = YES;
        _goalAttribute_button.layer.masksToBounds = YES;
        [_goalAttribute_button addTarget:self action:@selector(goalAttributeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goalAttribute_button;
}

- (UILabel *)goalAttribute_label
{
    if (_goalAttribute_label == nil) {
        _goalAttribute_label = [[UILabel alloc] init];
        _goalAttribute_label.text = @"目 的 属 性";
        _goalAttribute_label.textColor = kColor2f2f;
        _goalAttribute_label.font = [UIFont systemFontOfSize:13.0];
    }
    return _goalAttribute_label;
}

- (UIImageView *)goalAttribute_imageViewLeft
{
    if (_goalAttribute_imageViewLeft == nil) {
        _goalAttribute_imageViewLeft = [[UIImageView alloc] init];
        _goalAttribute_imageViewLeft.image = [UIImage originalWithImage:@"xinghao"];
    }
    return _goalAttribute_imageViewLeft;
}

- (UIImageView *)goalAttribute_imageViewRight
{
    if (_goalAttribute_imageViewRight == nil) {
        _goalAttribute_imageViewRight = [[UIImageView alloc] init];
        _goalAttribute_imageViewRight.image = [UIImage originalWithImage:@"Triangle-"];
    }
    return _goalAttribute_imageViewRight;
}

- (UILabel *)goalAttributeContent_label
{
    if (_goalAttributeContent_label == nil) {
        _goalAttributeContent_label = [[UILabel alloc] init];
        _goalAttributeContent_label.text = @"请选择目的属性";
        _goalAttributeContent_label.textColor = kColor2f2f;
        _goalAttributeContent_label.font = [UIFont systemFontOfSize:14.0];
    }
    return _goalAttributeContent_label;
}

- (void)goalAttributeButtonClick
{
    NSLog(@"主人,您点击了目的属性~~");
    bgScrollView.frame = CGRectMake(-30, 0, SCREEN_WIDTH + 30, 350);
    [bgScrollView addSubview:self.goalAttributeTableView];
    [self.goalAttributeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goalAttribute_button.mas_left).mas_offset(95.0);
        make.right.mas_equalTo(self.goalAttribute_button.mas_right);
        make.top.mas_equalTo(self.goalAttribute_button.mas_bottom);
        if (self.purposeArray.count > 5) {
            make.height.mas_equalTo(196.0);
        }else {
            make.height.mas_equalTo(self.purposeArray.count * 33.0);
        }
    }];
    self.goalAttribute_imageViewRight.image = [UIImage originalWithImage:@"triangle"];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    UITableView *firTableView = [self viewWithTag:10001];
    if (view == nil) {
        CGPoint tempoint = [firTableView convertPoint:point fromView:self];
        if (CGRectContainsPoint(firTableView.bounds, tempoint))
        {
            view = firTableView;
        }
    }
    return view;
}

- (UITableView *)goalAttributeTableView
{
    if (_goalAttributeTableView == nil) {
        _goalAttributeTableView = [[UITableView alloc] init];
        _goalAttributeTableView.delegate = self;
        _goalAttributeTableView.dataSource = self;
        _goalAttributeTableView.backgroundColor = [UIColor whiteColor];
        [_goalAttributeTableView.layer setBorderWidth:1.0];
        _goalAttributeTableView.layer.borderColor = kBorderColor.CGColor;
        _goalAttributeTableView.layer.cornerRadius = 5.0;
        _goalAttributeTableView.tag = 10001;
    }
    return _goalAttributeTableView;
}

- (void)initShu
{
    //解析全国省市区信息
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    areaDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSArray *components = [areaDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableArray *provinceTmp = [NSMutableArray array];
    for (int i=0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[areaDic objectForKey: index] allKeys];
        [provinceTmp addObject: [tmp objectAtIndex:0]];
    }
    NSLog(@"%s",__func__);
    province = [NSArray arrayWithArray:provinceTmp];
    
    NSString *index = [sortedArray objectAtIndex:0];
    NSString *selected = [province objectAtIndex:0];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[areaDic objectForKey:index]objectForKey:selected]];
    
    NSArray *cityArray = [dic allKeys];
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
    city = [NSArray arrayWithArray:[cityDic allKeys]];
    
    selectedCity = [city objectAtIndex:0];
    district = [NSArray arrayWithArray:[cityDic objectForKey:selectedCity]];
    
    addressDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                   province,@"province",
                   city,@"city",
                   district,@"area",nil];
    
    selectedProvince = [province objectAtIndex:0];
    selectedArea = [district objectAtIndex:0];
    
    bgScrollView = [[LMContainsLMComboxScrollView alloc]initWithFrame:CGRectMake(-30, 0, SCREEN_WIDTH + 30, 250)];
    bgScrollView.backgroundColor = [UIColor clearColor];
    bgScrollView.showsVerticalScrollIndicator = NO;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.tag = 1000;
    [self addSubview:bgScrollView];
    
    [self setUpBgScrollView];
}

- (void)setUpBgScrollView
{
    NSArray *keys = [NSArray arrayWithObjects:@"province",@"city",@"area", nil];
    for(NSInteger i = 0; i < 3; i++)
    {
        LMComBoxView *comBox = [[LMComBoxView alloc]initWithFrame:CGRectMake(50+((SCREEN_WIDTH - 44) / 3 + 3) * i, 60, (SCREEN_WIDTH - 44) / 3, 38.0)];
        comBox.backgroundColor = [UIColor whiteColor];
        if (i == 0) {
            comBox.ButtonTypeNum = 1;
        }else if (i == 1) {
            comBox.ButtonTypeNum = 2;
        }else {
            comBox.ButtonTypeNum = 3;
        }
        comBox.arrowImgName = @"down_dark0.png";
        NSMutableArray *itemsArray = [NSMutableArray arrayWithArray:[addressDict objectForKey:[keys objectAtIndex:i]]];
        comBox.titlesList = itemsArray;
        comBox.delegate = self;
        comBox.supView = bgScrollView;
        [comBox defaultSettings];
        comBox.tag = kDropDownListTag + i;
        [bgScrollView addSubview:comBox];
    }
}

#pragma mark -LMComBoxViewDelegate
-(void)selectAtIndex:(NSInteger)index inCombox:(LMComBoxView *)_combox
{
    NSInteger tag = _combox.tag - kDropDownListTag;
    switch (tag) {
        case 0:
        {
            selectedProvince =  [[addressDict objectForKey:@"province"]objectAtIndex:index];
            //字典操作
            NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: [NSString stringWithFormat:@"%ld", index]]];
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
            NSArray *cityArray = [dic allKeys];
            NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
                
                if ([obj1 integerValue] > [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedDescending;//递减
                }
                
                if ([obj1 integerValue] < [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedAscending;//上升
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
            
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int i=0; i<[sortedArray count]; i++) {
                NSString *index = [sortedArray objectAtIndex:i];
                NSArray *temp = [[dic objectForKey: index] allKeys];
                [array addObject: [temp objectAtIndex:0]];
            }
            city = [NSArray arrayWithArray:array];
            
            NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
            district = [NSArray arrayWithArray:[cityDic objectForKey:[city objectAtIndex:0]]];
            //刷新市、区
            addressDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                           province,@"province",
                           city,@"city",
                           district,@"area",nil];
            LMComBoxView *cityCombox = (LMComBoxView *)[bgScrollView viewWithTag:tag + 1 + kDropDownListTag];
            cityCombox.titlesList = [NSMutableArray arrayWithArray:[addressDict objectForKey:@"city"]];
            [cityCombox reloadData];
            LMComBoxView *areaCombox = (LMComBoxView *)[bgScrollView viewWithTag:tag + 2 + kDropDownListTag];
            areaCombox.titlesList = [NSMutableArray arrayWithArray:[addressDict objectForKey:@"area"]];
            [areaCombox reloadData];
            
            selectedCity = [city objectAtIndex:0];
            selectedArea = [district objectAtIndex:0];
            break;
        }
        case 1:
        {
            selectedCity = [[addressDict objectForKey:@"city"]objectAtIndex:index];
            
            NSString *provinceIndex = [NSString stringWithFormat: @"%ld", [province indexOfObject: selectedProvince]];
            NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: provinceIndex]];
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
            NSArray *dicKeyArray = [dic allKeys];
            NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
                
                if ([obj1 integerValue] > [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                
                if ([obj1 integerValue] < [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedAscending;
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
            
            NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: index]]];
            NSArray *cityKeyArray = [cityDic allKeys];
            district = [NSArray arrayWithArray:[cityDic objectForKey:[cityKeyArray objectAtIndex:0]]];
            //刷新区
            addressDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                           province,@"province",
                           city,@"city",
                           district,@"area",nil];
            LMComBoxView *areaCombox = (LMComBoxView *)[bgScrollView viewWithTag:tag + 1 + kDropDownListTag];
            areaCombox.titlesList = [NSMutableArray arrayWithArray:[addressDict objectForKey:@"area"]];
            [areaCombox reloadData];
            
            selectedArea = [district objectAtIndex:0];
            break;
        }
        case 2:
        {
            selectedArea = [[addressDict objectForKey:@"area"]objectAtIndex:index];
            break;
        }
        default:
            break;
    }
    NSLog(@"===%@===%@===%@",selectedProvince,selectedCity,selectedArea);
    self.selectedProvince = selectedProvince;
    self.selectedCity = selectedCity;
    self.selectedArea = selectedArea;
}

#pragma mark - 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - 每组cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.purposeArray count];
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33.0;
}

#pragma mark - cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.preservesSuperviewLayoutMargins = NO;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.purposeArray[indexPath.row].paramName];
    return cell;
}

#pragma mark - cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.goalAttribute_imageViewRight.image = [UIImage originalWithImage:@"Triangle-"];
    NSString *indeStr = [NSString stringWithFormat:@"%@",self.purposeArray[indexPath.row].paramName];
    self.goalAttributeContent_label.text = indeStr;
    self.paramName1 = indexPath.row;
    [self.goalAttributeTableView removeFromSuperview];
    bgScrollView.frame = CGRectMake(-30, 0, SCREEN_WIDTH + 30, 228);
}



@end
