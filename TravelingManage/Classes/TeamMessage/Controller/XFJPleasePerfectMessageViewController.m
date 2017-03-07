//
//  XFJPleasePerfectMessageViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/6.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

//跳转到完善资料控制器
#import "XFJPleasePerfectMessageViewController.h"
#import "XFJPleasePerfectMessageTopView.h"
#import "XFJPleaseUpPerfectPhotosView.h"
#import "TZImagePickerController.h"
#import "WSImagePickerView.h"
#import "WSPhotosBroseVC.h"
#import "XFJSignPhotosMessageTableViewCell.h"
#import "XFJFindTeamTasksItem.h"

@interface XFJPleasePerfectMessageViewController () <UIActionSheetDelegate,XFJPleaseUpPerfectPhotosViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource,XFJSignPhotosMessageTableViewCellDelegate>

@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) UIScrollView *scroll_view;
@property (nonatomic, strong) XFJPleasePerfectMessageTopView *pleasePerfectMessageTopView;
@property (nonatomic, strong) XFJPleaseUpPerfectPhotosView *pleaseUpPerfectPhotosView;
@property (nonatomic, assign) NSInteger maxImageCount;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *signPhotos_tableView;
@property (nonatomic, strong) XFJSignPhotosMessageTableViewCell *cell;
@property (nonatomic, strong) NSMutableArray <XFJFindTeamTasksItem *> *findTeamTasksItem;

@end

@implementation XFJPleasePerfectMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setInitWithNav];
    
    NSLog(@"-----++++++++++++传过来的TeamId是:%zd",self.teamId);
    //请求顶部的数据信息
    [self requestTopPerfectMessage];
}

- (void)requestTopPerfectMessage
{
    NSDictionary *dictParams = @{
                                 @"id":[NSString stringWithFormat:@"%zd",self.teamId]
                                 };
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:FINDTEAMINFOTASKSURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSLog(@"------------++++++++++++获取到的值是 :%@",responseObject);
            wself.findTeamTasksItem = [XFJFindTeamTasksItem mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"rows"]];
            wself.pleasePerfectMessageTopView.findTeamTasksItem = wself.findTeamTasksItem;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"---------+++++++++没得到后台返回的值,打印错误信息是 :%@",error);
        }
    }];
}

- (NSMutableArray <XFJFindTeamTasksItem *> *)findTeamTasksItem
{
    if (_findTeamTasksItem == nil) {
        _findTeamTasksItem = [NSMutableArray array];
    }
    return _findTeamTasksItem;
}

- (UIScrollView *)scroll_view
{
    if (_scroll_view == nil) {
        _scroll_view = [[UIScrollView alloc] init];
        _scroll_view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 1.2 * self.view.XFJ_Height);
        _scroll_view.contentSize = CGSizeMake(0, self.view.XFJ_Height * 2.5);
        _scroll_view.backgroundColor = kColoreeee;
        _scroll_view.showsHorizontalScrollIndicator = NO;
        _scroll_view.scrollEnabled = YES;
    }
    return _scroll_view;
}

- (XFJPleasePerfectMessageTopView *)pleasePerfectMessageTopView
{
    if (_pleasePerfectMessageTopView == nil) {
        _pleasePerfectMessageTopView = [[XFJPleasePerfectMessageTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 86)];
        _pleasePerfectMessageTopView.backgroundColor = [UIColor  whiteColor];
    }
    return _pleasePerfectMessageTopView;
}

- (XFJPleaseUpPerfectPhotosView *)pleaseUpPerfectPhotosView
{
    if (_pleaseUpPerfectPhotosView == nil) {
        _pleaseUpPerfectPhotosView = [[XFJPleaseUpPerfectPhotosView alloc] initWithFrame:CGRectMake(0, 86, SCREEN_WIDTH, 170)];
        _pleaseUpPerfectPhotosView.backgroundColor = [UIColor whiteColor];
        _pleaseUpPerfectPhotosView.delegate = self;
    }
    return _pleaseUpPerfectPhotosView;
}

- (void)setInitWithNav
{
    self.navigationItem.titleView = self.title_label;
    [self.view addSubview:self.scroll_view];
    [self.scroll_view addSubview:self.pleasePerfectMessageTopView];
    [self.scroll_view addSubview:self.pleaseUpPerfectPhotosView];
    [self.scroll_view addSubview:self.signPhotos_tableView];
}

- (UILabel *)title_label
{
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.XFJ_centerX, 6, 100, 44)];
        _title_label.text = @"完善资料";
        _title_label.textColor = kColor6565;
        _title_label.textAlignment = NSTextAlignmentCenter;
    }
    return _title_label;
}

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UITableView *)signPhotos_tableView
{
    if (_signPhotos_tableView == nil) {
        _signPhotos_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.pleaseUpPerfectPhotosView.XFJ_Height + 86, SCREEN_WIDTH, 300) style:UITableViewStylePlain];
        _signPhotos_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _signPhotos_tableView.delegate = self;
        _signPhotos_tableView.dataSource = self;
    }
    return _signPhotos_tableView;
}

#pragma makr - 访问照相机
- (void)chooseImage:(XFJPleaseUpPerfectPhotosView *)SerPhotoCell
{
    self.maxImageCount = 6;
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"请选择相机或者相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择",nil];
    [action showInView:self.view];
}

- (void)chooseVoucherPhotosImage:(XFJSignPhotosMessageTableViewCell *)voucherPhotos
{
    self.maxImageCount = 1;
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"请选择相机或者相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择",nil];
    [action showInView:self.view];
}

- (void)jumpCell:(XFJPleaseUpPerfectPhotosView *)cell indexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    if(indexPath.row < _dataArr.count) {
        for (UIImage *image in _dataArr) {
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
                [_dataArr removeAllObjects];
                [_dataArr addObjectsFromArray:array];
                weakself.pleaseUpPerfectPhotosView.dataArr = _dataArr;
                if (_dataArr.count <= 4) {
                    self.pleaseUpPerfectPhotosView.frame = CGRectMake(0, 86, SCREEN_WIDTH, 170);
                    self.signPhotos_tableView.frame = CGRectMake(0, self.pleaseUpPerfectPhotosView.XFJ_Height + 86, SCREEN_WIDTH, 300);
                }
            });
        };
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)jumpToCell:(XFJSignPhotosMessageTableViewCell *)cell indexPath:(NSIndexPath *)indexPath
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
                weakself.cell.dataArr = _dataArray;
//                                if (_dataArr.count <= 4) {
//                                    self.uploadPhotos_view.frame = CGRectMake(0, 728, SCREEN_WIDTH, 200);
//                                }
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
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxImageCount - (self.maxImageCount == 6 ? self.dataArr.count : self.dataArray.count) delegate:self];
        
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }else{
        //        [MBProgressHUD showHUDMsg: @"请打开允许访问相册权限" ];
    }
}

//相机选的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    if (self.maxImageCount == 6) {
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.dataArr addObject:image];
        [picker dismissViewControllerAnimated:YES completion:nil];
        self.pleaseUpPerfectPhotosView.dataArr = self.dataArr;
        self.pleaseUpPerfectPhotosView.maxImageCount = 6;
    }else {
        NSLog(@"self.maxImageCount == 1");
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.dataArray addObject:image];
        [picker dismissViewControllerAnimated:YES completion:nil];
        self.pleaseUpPerfectPhotosView.dataArr = self.dataArray;
        self.pleaseUpPerfectPhotosView.maxImageCount = 1;
    }
}

//取消按钮
- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picke{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 相册选的图片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    if (self.maxImageCount == 6) {
        [self.dataArr addObjectsFromArray:photos];
        self.pleaseUpPerfectPhotosView.dataArr = self.dataArr;
        self.pleaseUpPerfectPhotosView.maxImageCount = 6;
        if (self.dataArr.count < 4) {
        }else {
            self.pleaseUpPerfectPhotosView.frame = CGRectMake(0, 86, SCREEN_WIDTH, 230);
            self.signPhotos_tableView.frame = CGRectMake(0, self.pleaseUpPerfectPhotosView.XFJ_Height + 86, SCREEN_WIDTH, 300);
        }
    }else {
        NSLog(@"self.maxImageCount == 1----------");
        [self.dataArray addObjectsFromArray:photos];
        self.cell.dataArr = self.dataArray;
        self.cell.maxImageCount = 1;
        [self.signPhotos_tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *const cellId = @"cellId";
    XFJSignPhotosMessageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.cell = cell;
    cell.dataArr = self.dataArray;
    NSLog(@"++++++++++++++++选取到的照片数量是 :%@",self.dataArray);
    if (cell == nil) {
        cell = [[XFJSignPhotosMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

@end
