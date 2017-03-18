//
//  XFJSignMessageViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/2.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJSignMessageViewController.h"
#import "XFJSignMessageTopVeiw.h"
#import "XFJSignMessageTimeView.h"
#import "XFJSignTeamPhotosView.h"
#import "XFJLaterTeamControlItem.h"
#import "XFJFirestAttributeTableViewCell.h"
#import "XFJSecondAttributeTableViewCell.h"
#import "XFJThirdAttributeTableViewCell.h"
#import "XFJFourAttributeTableViewCell.h"
#import "XFJFiveAttributeTableViewCell.h"
#import "XFJSixAttributeTableViewCell.h"
#import "XFJSevenTableViewCell.h"
#import "XFJEigthAttributeTableViewCell.h"
#import "XFJMaskView.h"
#import "XFJCheckBoxView.h"
#import "XFJFindCustomAttrListItem.h"
#import "TZImagePickerController.h"
#import "WSImagePickerView.h"
#import "WSPhotosBroseVC.h"
#import "XFJSureUpPhotosView.h"
#import "HomeViewController.h"
#import "JTNavigationController.h"

@interface XFJSignMessageViewController () <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource,XFJSignTeamPhotosViewDelegate>

@property (nonatomic, strong) XFJSignMessageTopVeiw *signMessageTopVeiw;
@property (nonatomic, strong) XFJSignMessageTimeView *signMessageTimeView;
@property (nonatomic, strong) XFJSignTeamPhotosView *signTeamPhotosView;
@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) UITableView *attrList_tableView;
@property (nonatomic, strong) UIScrollView *scroll_view;
@property (nonatomic, strong) NSMutableArray *attrTypeArray;
@property (nonatomic, strong) NSMutableArray <XFJFindCustomAttrListItem *> *findCustomAttrListItemArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger maxImageCount;
@property (nonatomic, strong) XFJSureUpPhotosView *sureUpPhotosView;
@property (nonatomic, strong) NSString *root;
@property (nonatomic, strong) NSString *voucherPicRoot;
@property (nonatomic, strong) XFJLaterTeamControlItem *laterTeamControlItem;
@property (nonatomic, assign) BOOL isUpHpotos;


@end

@implementation XFJSignMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.title_label;
    self.view.backgroundColor = kColoreeee;
    [self.view addSubview:self.scroll_view];
    [self.scroll_view addSubview:self.signMessageTopVeiw];
    [self.scroll_view addSubview:self.signMessageTimeView];
    [self.scroll_view addSubview:self.signTeamPhotosView];
    [self.scroll_view addSubview:self.attrList_tableView];
    [self.scroll_view addSubview:self.sureUpPhotosView];
    [self.attrList_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signTeamPhotosView.mas_bottom);
        make.height.mas_equalTo(30.0);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    [self.sureUpPhotosView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.attrList_tableView.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(100.0);
    }];
    
    [self.attrList_tableView registerClass:[XFJFirestAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJFirestAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJSecondAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJSecondAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJThirdAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJThirdAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJFourAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJFourAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJFiveAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJFiveAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJSixAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJSixAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJSevenTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJSevenTableViewCell];
    [self.attrList_tableView registerClass:[XFJEigthAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJEigthAttributeTableViewCell];
    
    [self requestLatelyControl];
    __weak __typeof(self)wself = self;
    self.sureUpPhotosView.sureUpDataButtonClickBlock = ^() {
      //上传接口
        [wself requestUpPhotos];
    };
}

#pragma mark - 上传图片
- (void)requestUpPhotos
{
    if (self.dataArray.count == 0) {
//        [MBProgressHUD showHudTipStr:@"请上传凭证照片" contentColor:HidWithColorContentBlack];
        self.isUpHpotos = YES;
        [self sureRequestUp];
    }else {
        [MBProgressHUD showLoadHUD];
        UIImage *image = self.dataArray[0];
        NSData *imageData = [UIImage compressImage:image maxSize:300];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        __weak __typeof(self)wself = self;
        [manager POST:UPLOADIMAGE parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpg" mimeType:@"image/jpg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hidenHud];
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSString *root = dict[@"object"];
            wself.voucherPicRoot = root;
            NSLog(@"上传图片成功后的信息-------%@",root);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (wself.root.length == 0) {
//                    [MBProgressHUD showHudTipStr:@"图片上传失败~~" contentColor:HidWithColorContentBlack];
//                    return ;
//                }
                //确认提交
                [wself sureRequestUp];
//            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hidenHud];
            NSLog(@"上传图片失败--------%@",error);
        }];
    }
}

- (void)setLaterTeamControlItem:(XFJLaterTeamControlItem *)laterTeamControlItem
{
    _laterTeamControlItem = laterTeamControlItem;
}

- (void)setTaskRowsItem:(XFJTaskRowsItem *)taskRowsItem
{
    _taskRowsItem = taskRowsItem;
    self.signMessageTopVeiw.taskRowsItem = taskRowsItem;
    self.signMessageTimeView.taskRowsItem = taskRowsItem;
}

#pragma makr - 任务信息提交
- (void)sureRequestUp
{
    NSLog(@"--------------获取到的模型是 :%@",self.laterTeamControlItem);
    NSDictionary *dictParams = @{
                                 @"id":[NSString stringWithFormat:@"%zd",self.taskRowsItem.taskId],//任务id
                                 @"teamId":[NSString stringWithFormat:@"%zd",self.findNewTeamInfo_Id],//团队id
                                 @"attractionsId":[NSString stringWithFormat:@"%zd",self.taskRowsItem.attractionsId],//景区id
                                 @"attracImagePath":self.isUpHpotos == YES ? @"" : self.voucherPicRoot,//非必传参数
                                 @"taskBack":@""//非必传参数
                                 };
    NSLog(@"+++++=====----------打印的参数是:%@",dictParams);
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:TASKPERFECTURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSLog(@"responseObject:%@",responseObject);
            [MBProgressHUD hidenHud];
            if ([[responseObject objectForKey:@"msg"] isEqualToString:@"success"]) {
                [MBProgressHUD showHudTipStr:@"信息提交成功" contentColor:HidWithColorContentBlack];
                [wself.navigationController popViewControllerAnimated:YES];
            }
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"error:%@",error);
            [MBProgressHUD showHudTipStr:@"信息提交失败,可能是网络原因" contentColor:HidWithColorContentBlack];
        }
    }];
}
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (XFJSignMessageTopVeiw *)signMessageTopVeiw
{
    if (_signMessageTopVeiw == nil) {
        _signMessageTopVeiw = [[XFJSignMessageTopVeiw alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 38.0)];
    }
    return _signMessageTopVeiw;
}

- (XFJSignMessageTimeView *)signMessageTimeView
{
    if (_signMessageTimeView == nil) {
        _signMessageTimeView = [[XFJSignMessageTimeView alloc] initWithFrame:CGRectMake(0, 38, SCREEN_WIDTH, 97.0)];
    }
    return _signMessageTimeView;
}

- (XFJSureUpPhotosView *)sureUpPhotosView
{
    if (_sureUpPhotosView == nil) {
        _sureUpPhotosView = [[XFJSureUpPhotosView alloc] init];
        _sureUpPhotosView.backgroundColor = [UIColor whiteColor];
    }
    return _sureUpPhotosView;
}

- (XFJSignTeamPhotosView *)signTeamPhotosView
{
    if (_signTeamPhotosView == nil) {
        _signTeamPhotosView = [[XFJSignTeamPhotosView alloc] initWithFrame:CGRectMake(0, 135, SCREEN_WIDTH, 150)];
        _signTeamPhotosView.delegate = self;
    }
    return _signTeamPhotosView;
}

- (void)chooseVoucherPhotosImage:(XFJSignTeamPhotosView *)voucherPhotos
{
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"请选择相机或者相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择",nil];
    [action showInView:self.view];
}

- (UILabel *)title_label
{
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.XFJ_centerX, 6, 100, 44)];
        _title_label.text = @"签到点信息";
        _title_label.textColor = kColor6565;
        _title_label.textAlignment = NSTextAlignmentCenter;
    }
    return _title_label;
}

#pragma mark - 最近操作的团队
- (void)requestLatelyControl
{
    NSDictionary *dictParams = @{
                                 @"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"]
                                 };
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:FINDNEWTEAMINFOURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSLog(@"+++++++++++获取到的最近的操作的团队是:%@",responseObject);
            NSDictionary *dict = [responseObject objectForKey:@"object"];
            XFJLaterTeamControlItem *laterTeamControlItem = [XFJLaterTeamControlItem mj_objectWithKeyValues:dict];
//            wself.signMessageTopVeiw.laterTeamControlItem = laterTeamControlItem;
//            wself.signMessageTimeView.laterTeamControlItem = laterTeamControlItem;
            wself.laterTeamControlItem = laterTeamControlItem;
            //如果状态值显示的是0就显示签到按钮
            //如果状态值显示的是1就是签退按钮
            NSLog(@"========打印出来的最近团队的参数模型是:%@",laterTeamControlItem);
            [wself requestTeamMessage:laterTeamControlItem.findNewTeamInfo_Id];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"+++++++++++++获取不到的最近的操作的团队打印的错误信息是:%@",error);
        }
    }];
}

- (NSMutableArray *)attrTypeArray
{
    if (_attrTypeArray == nil) {
        _attrTypeArray = [NSMutableArray array];
    }
    return _attrTypeArray;
}

- (UITableView *)attrList_tableView
{
    if (_attrList_tableView == nil) {
        _attrList_tableView = [[UITableView alloc] init];
        _attrList_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _attrList_tableView.delegate = self;
        _attrList_tableView.dataSource = self;
        _attrList_tableView.bounces = NO;
    }
    return _attrList_tableView;
}

- (UIScrollView *)scroll_view
{
    if (_scroll_view == nil) {
        _scroll_view = [[UIScrollView alloc] init];
        _scroll_view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 1.2 * self.view.XFJ_Height);
        _scroll_view.contentSize = CGSizeMake(0, self.view.XFJ_Height * 1.3);
        _scroll_view.backgroundColor = kColoreeee;
        _scroll_view.showsHorizontalScrollIndicator = NO;
        _scroll_view.scrollEnabled = YES;
    }
    return _scroll_view;
}
- (void)requestTeamMessage:(NSInteger)findNewTeamInfo_Id
{
    [self requestFindCustomAttrListMessage:findNewTeamInfo_Id];
}

#pragma mark - 加载自定义字段数据
- (void)requestFindCustomAttrListMessage:(NSInteger)teamId
{
    NSDictionary *dictParams = @{
                                 @"userId":@32,
                                 @"teamAttractionsType":@1
                                 };
    __weak __typeof(self)wself = self;
    NSLog(@"-------------自定义字段参数是 :%@",dictParams);
    [GRNetRequestClass GET:FINDCUSTOMATTRLISTURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSMutableArray *rowsArray = [responseObject objectForKey:@"rows"];
            wself.findCustomAttrListItemArray = [XFJFindCustomAttrListItem mj_objectArrayWithKeyValuesArray:rowsArray];
            for (NSInteger i = 0; i < wself.findCustomAttrListItemArray.count; i++) {
                int attrType = wself.findCustomAttrListItemArray[i].attrType;
                //                [wself.attrTypeArray addObject:attrType];
                [wself.attrTypeArray addObject:[NSString stringWithFormat:@"%d",attrType]];
                NSLog(@"+++++++++++返回的自定字段信息是 :%d",attrType);
            }
            [wself.attrList_tableView reloadData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"___________返回错误的信息是 :%@",error);
        }
    }];
}

- (NSMutableArray <XFJFindCustomAttrListItem *> *)findCustomAttrListItemArray
{
    if (_findCustomAttrListItemArray == nil) {
        _findCustomAttrListItemArray = [NSMutableArray array];
    }
    return _findCustomAttrListItemArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.findCustomAttrListItemArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger i = indexPath.row;
    NSString *ty_pe = self.attrTypeArray[i];
    if ([ty_pe intValue] == 0) {
        XFJFirestAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJFirestAttributeTableViewCell forIndexPath:indexPath];
        NSLog(@"---------获取的back值是0 :%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr);
        return cell;
    }else if ([ty_pe intValue] == 1) {
        XFJSecondAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJSecondAttributeTableViewCell forIndexPath:indexPath];
        NSLog(@"---------获取的back值是1 :%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr);
        return cell;
    }else if ([ty_pe intValue] == 2) {
        XFJThirdAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJThirdAttributeTableViewCell forIndexPath:indexPath];
        NSLog(@"---------获取的back值是2 :%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr);
        return cell;
    }else if ([ty_pe intValue] == 3) {
        XFJFourAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJFourAttributeTableViewCell forIndexPath:indexPath];
        NSLog(@"---------获取的back值是3 :%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr);
        cell.teamAttr = self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr;
        __weak __typeof(self)wself = self;
        cell.presentMaskViewBlock = ^(NSString *typesStr) {
//            [[UIApplication sharedApplication].keyWindow addSubview:wself.maskView1];
            NSLog(@"-------------这里打印的back值是 :%@",typesStr);
        };
        return cell;
    }else if ([ty_pe intValue] == 4) {
        XFJFiveAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJFiveAttributeTableViewCell forIndexPath:indexPath];
        NSLog(@"---------获取的back值是4 :%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr);
        return cell;
    }else if ([ty_pe intValue] == 5) {
        XFJSixAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJSixAttributeTableViewCell forIndexPath:indexPath];
        NSLog(@"---------获取的back值是5 :%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr);
        return cell;
    }else if ([ty_pe intValue] == 6) {
        XFJSevenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJSevenTableViewCell forIndexPath:indexPath];
        NSLog(@"---------获取的back值是6 :%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr);
        __weak __typeof(self)wself = self;
//        cell.presentPickPhotosBlock = ^(TZImagePickerController *pickerController) {
//            [wself presentViewController:pickerController animated:YES completion:nil];
//        };
        return cell;
    }else {
        XFJEigthAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJEigthAttributeTableViewCell forIndexPath:indexPath];
        cell.teamAttr = self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr;
        NSLog(@"---------获取的back值是7 :%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr);
        __weak __typeof(self)wself = self;
//        cell.presentMaskViewBlock = ^(NSString *typesStr) {
//            [[UIApplication sharedApplication].keyWindow addSubview:wself.maskView1];
//            self.checkBoxView.backStr = typesStr;
//            [wself.maskView1 addSubview:self.checkBoxView];
//            NSLog(@"-------------这里打印的back值是 :%@",typesStr);
//        };
//        if (self.AttributeStr != nil) {
//            NSDictionary *dict = @{
//                                   @"name":self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr,//这是显示的是back几
//                                   @"value":self.AttributeStr//这里添加的是和back对应的值
//                                   };
//            [self.allAttribute_array addObject:dict];
//            NSLog(@"这是显示的是back%@--------这里添加的是和back对应的值%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr,self.AttributeStr);
//        }
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.attrList_tableView.frame = CGRectMake(0, 323, SCREEN_WIDTH, 80 * self.findCustomAttrListItemArray.count);
    NSInteger i = indexPath.row;
    NSString *ty_pe = self.attrTypeArray[i];
    if ([ty_pe intValue] == 0) {
        return 45.0;
    }else if ([ty_pe intValue] == 1) {
        return 45.0;
    }else if ([ty_pe intValue] == 2) {
        return 100.0;
    }else if ([ty_pe intValue] == 3) {
        return 45.0;
    }else if ([ty_pe intValue] == 4) {
        return 53.0;
    }else if ([ty_pe intValue] == 5) {
        return 45.0;
    }else if ([ty_pe intValue] == 6) {
        return 240.0;
    }else {
        return 45.0;
    }
}

- (void)jumpToCell:(XFJSignTeamPhotosView *)cell indexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    if(indexPath.row < _dataArray.count) {
        for (UIImage *image in _dataArray) {
            WSImageModel *model = [[WSImageModel alloc] init];
            model.image = image;
            [tmpArray addObject:model];
        }
        WSPhotosBroseVC *vc = [[WSPhotosBroseVC alloc] init];;
        vc.imageArray = tmpArray;
        vc.showIndex = indexPath.row;
        __weak typeof (self)weakself = self;
        vc.completion = ^ (NSArray *array){
            dispatch_async(dispatch_get_main_queue(), ^{
                [_dataArray removeAllObjects];
                [_dataArray addObjectsFromArray:array];
                weakself.signTeamPhotosView.dataArr = _dataArray;
            });
        };
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self openCamera];
            break;
        case 1:
            [self openAlbum];
            break;
        default:
            break;
    }
}

- (void)openCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = self;
        [self presentViewController:ipc animated:YES completion:nil];
    } else {
        //        [MBProgressHUD showHUDMsg: @"请打开允许访问相机权限"];
        NSLog(@"请打开允许访问相机权限");
    }
}

- (void)openAlbum
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxImageCount - self.dataArray.count delegate:self];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }else{
        //        [MBProgressHUD showHUDMsg: @"请打开允许访问相册权限" ];
    }
}

//相机选的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.dataArray addObject:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.signTeamPhotosView.dataArr = self.dataArray;
    self.signTeamPhotosView.maxImageCount = 1;
}

//取消按钮
- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picke{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 相册选的图片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    [self.dataArray addObjectsFromArray:photos];
    self.signTeamPhotosView.dataArr = self.dataArray;
    self.signTeamPhotosView.maxImageCount = 1;
}



@end
