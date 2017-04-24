//
//  PersonalInformationViewController.m
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/9.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "PersonalInformationViewController.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "JTNavigationController.h"
#import "XFJUpLoadPhotosView.h"
@interface PersonalInformationViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) UIImageView *backgroundImage;//背景图片
@property (nonatomic, strong) UIImageView *backImage;//返回
@property (nonatomic, strong) UITextField *nameTextF;//姓名
@property (nonatomic, strong) UITextField *idTextF;//身份证
@property (nonatomic, strong) UIButton *backButton;//返回按钮
@property (nonatomic, strong) UILabel *titleL;//标题
@property (nonatomic, strong) UILabel *idCodeL;
@property (nonatomic, strong) UILabel *promptL;//提示文字
@property (nonatomic, strong) UIButton *nextButton;//下一步
@property (nonatomic, strong) XFJUpLoadPhotosView *upLoadPhotosView;
@property (nonatomic, strong) UIImagePickerController *imageController;
@property (nonatomic, assign) NSInteger whichNumber;
@property (nonatomic, strong) NSMutableArray *font_array;
@property (nonatomic, strong) NSMutableArray *back_array;
@property (nonatomic, strong) NSMutableArray *guide_array;
@property (nonatomic, strong) NSString *font_imageViewRoot;
@property (nonatomic, strong) NSString *back_imageViewRoot;
@property (nonatomic, strong) NSString *guide_imageViewRoot;
//提供一个BOOL值,作为判断
@property (nonatomic, assign) BOOL isErrorToUpLoadPhotos;


@end

@implementation PersonalInformationViewController
#pragma  mark ----- lazy
- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [[UIButton alloc] init];
        [_backButton addTarget: self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backButton];
        
    }
    return _backButton;
}

- (UIImageView *)backImage{
    if (!_backImage){
        _backImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-2"]];
        [self.view addSubview:_backImage];
    }
    return _backImage;
}

- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.text = @"设置个人信息";
        _titleL.textColor = RedColor;
        _titleL.font = [UIFont fontWithName:PingFang size:16];
        [self.view addSubview:_titleL];
    }
    return _titleL;
}

- (UIImageView *)backgroundImage{
    if (!_backgroundImage){
        _backgroundImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BackgroundImage"]];
        _backgroundImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view addSubview:_backgroundImage];
    }
    return _backgroundImage;
}

- (UITextField *)phoneTextF{
    if(!_nameTextF){
        _nameTextF = [UITextField textLeftImage:@"name" placeholder:@"请输入姓名" imageWidth:14 imageHeight:19 lineWidth: SCREEN_WIDTH - 48];
        [_nameTextF addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:_nameTextF];
        [_nameTextF becomeFirstResponder];
    }
    return _nameTextF;
}
- (UITextField *)idTextF{
    if(!_idTextF){
        _idTextF = [UITextField textLeftImage:@"idNumber" placeholder:@"请输入身份号码" imageWidth:14 imageHeight:19 lineWidth: SCREEN_WIDTH - 48];
        [_idTextF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _idTextF.keyboardType = UIKeyboardTypeNumberPad;
        [_idTextF addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:_idTextF];
    }
    return _idTextF;
}

- (UILabel *)promptL{
    if (!_promptL){
        _promptL = [[UILabel alloc] init];
        _promptL.textColor = RedColor;
        _promptL.font = [UIFont fontWithName:PingFang size:13];
        [self.view addSubview:_promptL];
    }
    return _promptL;
}

- (NSMutableArray *)font_array
{
    if (_font_array == nil) {
        _font_array = [NSMutableArray array];
    }
    return _font_array;
}

- (NSMutableArray *)back_array
{
    if (_back_array == nil) {
        _back_array = [NSMutableArray array];
    }
    return _back_array;
}

- (NSMutableArray *)guide_array
{
    if (_guide_array == nil) {
        _guide_array = [NSMutableArray array];
    }
    return _guide_array;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [[UIButton alloc] init];
        _nextButton.titleLabel.font = [UIFont fontWithName:PingFang size:15];
        [_nextButton setTintColor:kColorFFFF];
        [_nextButton addTarget:self action:@selector(getIntoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _nextButton.userInteractionEnabled = NO;
        [self.view addSubview:_nextButton];
    }
    return _nextButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _user = [NSUserDefaults standardUserDefaults];
    [_user synchronize];
    [self creatUI];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.phoneTextF resignFirstResponder];
    [self.idTextF resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (XFJUpLoadPhotosView *)upLoadPhotosView
{
    if (_upLoadPhotosView == nil) {
        _upLoadPhotosView = [[XFJUpLoadPhotosView alloc] init];
        _upLoadPhotosView.backgroundColor = [UIColor clearColor];
    }
    return _upLoadPhotosView;
}

#pragma  mark ----- creatUI
- (void)creatUI{
    self.backgroundImage.userInteractionEnabled = YES;
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(0);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.top.equalTo(self.view).offset(29);
        make.size.mas_equalTo(CGSizeMake(9, 17));
    }];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backImage);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.phoneTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-24);
        make.top.equalTo(self.backImage.mas_bottom).offset(41);
        make.height.mas_equalTo(42);
    }];
    
    [self.idTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(24);
        make.right.equalTo(self.view).offset(-24);
        make.top.equalTo(self.phoneTextF.mas_bottom).offset(24);
        make.height.mas_equalTo(42);
    }];
    
    [self.nextButton setBackgroundImage: [UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
    [self.nextButton setTitle:@"马上进入" forState:UIControlStateNormal];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(17);
        make.right.equalTo(self.view).offset(-17);
        make.top.equalTo(self.idTextF.mas_bottom).offset(200);
        make.height.mas_equalTo(42);
    }];
    
    self.idTextF.delegate = self;
    self.nameTextF.delegate = self;
    __weak __typeof(self)wself = self;
    self.upLoadPhotosView.choosePhotosBlock = ^(NSInteger str) {
        wself.whichNumber = str;
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:wself cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择",@"拍照", nil];
        [sheet showInView:wself.view];
    };
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    self.imageController = [[UIImagePickerController alloc]init];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        self.imageController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
    }
    self.imageController.delegate = self;
    self.imageController.allowsEditing = YES;
    
    switch (buttonIndex) {
        case 1:
        {
            self.imageController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.imageController animated:YES completion:nil];
        }
            break;
        case 0:
        {
            self.imageController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.imageController animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self.imageController dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (self.whichNumber == 1) {
        self.upLoadPhotosView.font_imageView2 = image;
        [self.font_array addObject:image];
    }else if(self.whichNumber == 2) {
        self.upLoadPhotosView.back_imageView2 = image;
        [self.back_array addObject:image];
    }else {
        self.upLoadPhotosView.guide_imageView2 = image;
        [self.guide_array addObject:image];
    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.imageController dismissViewControllerAnimated:YES completion:nil];//退出
}


#pragma mark ----- textFieldDidChange
- (void) textFieldDidChange:(UITextField *)sender {
    if (_idTextF.text.length == 0){
        [self.promptL setHidden:NO];
        [self.promptL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(24);
            make.top.equalTo(_idTextF.mas_bottom).offset(17);
        }];
    }
}

#pragma mark ----- buttonClick
//已阅读
- (void)agreeClick: (UIButton *)button{

}
//马上进入
- (void)getIntoButtonClick{
    if (_idTextF.text.length != 18){
        [self.promptL setHidden:NO];
        self.promptL.text = @"身份证号输入错误,请重新输入";
        [self.promptL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(24);
            make.top.equalTo(_idTextF.mas_bottom).offset(17);
        }];
    }else {
        [self.promptL setHidden:YES];
        [self userRegister];
    }
}

//注册
- (void)userRegister {
    if ([self isCorrect:self.idTextF.text] == NO) {//如果为YES就是正确的
        [MBProgressHUD showHudTipStr:@"请输入正确的身份证号码" contentColor:HidWithColorContentBlack];
        return;
    }else {
        if (self.isErrorToUpLoadPhotos) {//如果BOOL值是YES,就进去
            //上传正面图片
            [self upFontPhoto_imageView];
        }else {
            [self requestIdCardIsRegister];
        }
    }
}

#pragma mark - 上传正面图片
- (void)upFontPhoto_imageView
{
    if (self.font_array.count == 0) {
        [MBProgressHUD hidenHud];
        [MBProgressHUD showHudTipStr:@"请上传身份证正面照片" contentColor:HidWithColorContentBlack];
        return;
    }else {
        UIImage *image = self.font_array[0];
        NSData *imageData = [UIImage compressImage:image maxSize:300];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        __weak __typeof(self)wself = self;
        [manager POST:UPLOADIMAGE parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpg" mimeType:@"image/jpg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSString *root = dict[@"object"];
            wself.font_imageViewRoot = root;
            NSLog(@"上传正面图片成功后的信息------->>>>>>>>>>>%@",root);
            //上传反面图片
            [self upBackPhoto_imageView];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"上传图片失败--------%@",error);
            [MBProgressHUD hidenHud];
        }];
    }
}

#pragma mark - 上传反面图片
- (void)upBackPhoto_imageView
{
    if (self.back_array.count == 0) {
        [MBProgressHUD hidenHud];
        [MBProgressHUD showHudTipStr:@"请上传身份证反面照片" contentColor:HidWithColorContentBlack];
        return;
    }else {
        UIImage *image = self.back_array[0];
        NSData *imageData = [UIImage compressImage:image maxSize:300];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        __weak __typeof(self)wself = self;
        [manager POST:UPLOADIMAGE parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpg" mimeType:@"image/jpg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSString *root = dict[@"object"];
            wself.back_imageViewRoot = root;
            NSLog(@"上传反面图片成功后的信息------->>>>>>>>>>>%@",root);
            //上传导游图片
            [self upGuide_imageView];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"上传图片失败--------%@",error);
            [MBProgressHUD hidenHud];
        }];
    }
}

#pragma mark - 上传导游图片
- (void)upGuide_imageView
{
    if (self.guide_array.count == 0) {
        [MBProgressHUD hidenHud];
        [MBProgressHUD showHudTipStr:@"请上传导游证照片" contentColor:HidWithColorContentBlack];
        return;
    }else {
        UIImage *image = self.guide_array[0];
        NSData *imageData = [UIImage compressImage:image maxSize:300];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        __weak __typeof(self)wself = self;
        [manager POST:UPLOADIMAGE parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpg" mimeType:@"image/jpg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSString *root = dict[@"object"];
            wself.guide_imageViewRoot = root;
            NSLog(@"上传导游图片成功后的信息------->>>>>>>>>>>%@",root);
            [self requestIdCardIsRegister];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"上传图片失败--------%@",error);
            [MBProgressHUD hidenHud];
        }];
    }
}

#pragma mark - 判断身份证是否注册过
- (void)requestIdCardIsRegister
{
    NSDictionary *dictParams = @{
                                 @"idCard":self.idTextF.text
                                 };
    NSLog(@"--------参数是 :%@",dictParams);
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:USERREGISTERIDCARDURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"msg"] isEqualToString:@"repeat"]) {
            [MBProgressHUD showHudTipStr:@"该身份证已注册" contentColor:HidWithColorContentBlack];
        }else if ([[responseObject objectForKey:@"msg"] isEqualToString:@"success"]) {
            [wself requestWithIdCardRegister];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"--------error : %@",error);
            [MBProgressHUD showHudTipStr:@"网络原因" contentColor:HidWithColorContentBlack];
        }
    }];
    //410183199105063010
}


#pragma Mark- 注册接口
- (void)requestWithIdCardRegister
{
    NSLog(@"正面图片地址是 :%@------反面图片地址是 :%@------导游图片地址是 :%@",self.font_imageViewRoot,self.back_imageViewRoot,self.guide_imageViewRoot);
    [MBProgressHUD showLoadHUD];
    NSDictionary *dictParaments = @{
                                    @"userMobile": self.phoneNum_text,
                                    @"idCard"    : self.idTextF.text,
                                    @"userName"  : self.nameTextF.text,
                                    @"frontImg"  : self.isErrorToUpLoadPhotos == YES ? self.font_imageViewRoot : @"",//身份证正面照片
                                    @"afterImg"  : self.isErrorToUpLoadPhotos == YES ? self.back_imageViewRoot : @"",//身份证背面照片
                                    @"guideImg"  : self.isErrorToUpLoadPhotos == YES ? self.guide_imageViewRoot : @""//导游照片
                                    };
    NSLog(@"<<<<<<<--------------需要传递的参数是 :%@",dictParaments);
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:REGISTURL params:dictParaments success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hidenHud];
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {//如果等于success表示注册成功
            [MBProgressHUD showHUDMsg:@"注册成功"];
            //登录
            [wself requestLogin];
        }else if ([responseObject[@"msg"] isEqualToString:@"error"]){//如果等于error表示注册失败,弹出让用户上传图片的弹框,并且让用户上传图片
            wself.isErrorToUpLoadPhotos = YES;
            //在这里弹出让用户上传照片的cell
            [wself.view addSubview:wself.upLoadPhotosView];
            [self.upLoadPhotosView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(18.0);
                make.top.mas_equalTo(self.idTextF.mas_bottom).mas_offset(28.0);
                make.right.mas_equalTo(-18.0);
                make.height.mas_equalTo(150.0);
            }];
            //提示用户上传图片
            [MBProgressHUD showHUDMsg:@"请上传相应的照片"];
            return ;
        }else {
            [MBProgressHUD showHudTipStr:@"改手机号已注册" contentColor:HidWithColorContentBlack];
            return;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hidenHud];
        if (error.code == NSURLErrorCancelled) return;
        [MBProgressHUD showHUDMsg:@"网络原因 "];
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.isErrorToUpLoadPhotos = NO;
}

//登录请求
- (void)requestLogin
{
    __weak typeof(self) weakself = self;
    NSDictionary *dictParaments = @{
                                    @"userMobile" : self.phoneNum_text,
                                    @"registrationId":@10,
                                    @"code" : self.idCode_text,
                                    @"terminal":@2
                                    };
    NSLog(@"--------------登录参数是 :%@",dictParaments);
    [GRNetRequestClass POST:LOGINURL params:dictParaments success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hidenHud];
        if (responseObject) {
            if ([responseObject[@"msg"] isEqualToString:@"success"]) {
                NSDictionary *dict = responseObject[@"object"];
                [_user setObject:dict[@"id"]forKey:@"userId"];
                [_user setObject:dict[@"userMobile"]forKey:@"phone"];
                [_user setObject:dict[@"userName"]forKey:@"userName"];
                [_user setObject:dict[@"idCard"]forKey:@"idCard"];
                [_user synchronize];
                NSLog(@"----------------------------登录后得到的返回值------------------------------:%@",responseObject);
                NSLog(@"phone:%@",[_user objectForKey:@"phone"]);
                NSLog(@"userId:%@",[_user objectForKey:@"userId"]);
                NSLog(@"userName:%@",[_user objectForKey:@"userName"]);
                NSLog(@"idCard:%@",[_user objectForKey:@"idCard"]);
                HomeViewController *homeVC = [[HomeViewController alloc] init];
                JTNavigationController *navVC = [[JTNavigationController alloc] initWithRootViewController:homeVC];
                [weakself presentViewController:navVC animated:YES completion:nil];
//                [weakself.navigationController pushViewController:homeVC animated:YES];
            }
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hidenHud];
        if (error.code == NSURLErrorCancelled) return;
    }];
}

//返回
- (void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ----- textFieldDelegate
- (void)textFieldChange:(UITextField *)sender {
    [self.upLoadPhotosView removeFromSuperview];
    self.isErrorToUpLoadPhotos = NO;
    //将数组中的内容清零
    self.upLoadPhotosView.font_imageView2 = [UIImage imageNamed:@"add"];
    self.upLoadPhotosView.back_imageView2 = [UIImage imageNamed:@"add"];
    self.upLoadPhotosView.guide_imageView2 = [UIImage imageNamed:@"add"];
    if (self.nameTextF.text.length > 0 && self.idTextF.text.length == 18) {
        //隐藏键盘
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
        [self.nextButton setBackgroundImage: [UIImage imageNamed:@"red"] forState:UIControlStateNormal];
        [self.nextButton setTitle:@"马上进入" forState:UIControlStateNormal];
        _nextButton.userInteractionEnabled = YES;
    }
    else {
        [self.nextButton setBackgroundImage: [UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        [self.nextButton setTitle:@"马上进入" forState:UIControlStateNormal];
        _nextButton.userInteractionEnabled = NO;
    }
}

/**
 *  验证身份证号码是否正确的方法
 *
 *  @param IDNumber 传进身份证号码字符串
 *
 *  @return 返回YES或NO表示该身份证号码是否符合国家标准
 */
- (BOOL)isCorrect:(NSString *)IDNumber
{
    NSMutableArray *IDArray = [NSMutableArray array];
    // 遍历身份证字符串,存入数组中
    for (int i = 0; i < 18; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [IDNumber substringWithRange:range];
        [IDArray addObject:subString];
    }
    // 系数数组
    NSArray *coefficientArray = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    // 余数数组
    NSArray *remainderArray = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil];
    // 每一位身份证号码和对应系数相乘之后相加所得的和
    int sum = 0;
    for (int i = 0; i < 17; i++) {
        int coefficient = [coefficientArray[i] intValue];
        int ID = [IDArray[i] intValue];
        sum += coefficient * ID;
    }
    // 这个和除以11的余数对应的数
    NSString *str = remainderArray[(sum % 11)];
    // 身份证号码最后一位
    NSString *string = [IDNumber substringFromIndex:17];
    // 如果这个数字和身份证最后一位相同,则符合国家标准,返回YES
    if ([str isEqualToString:string]) {
        return YES;
    } else {
        return NO;
    }
}


@end
