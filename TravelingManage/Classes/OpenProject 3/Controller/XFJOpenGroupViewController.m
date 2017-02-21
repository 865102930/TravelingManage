//
//  XFJOpenGroupViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/10.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJOpenGroupViewController.h"
#import "XFJConventionMessageTableViewCell.h"
#import "XFJCarNameTableViewCell.h"
#import "XFJGuestSourceInformationTableViewCell.h"
#import "XFJTeamInformationTableViewCell.h"
#import <IQKeyboardManager.h>
#import "XFJOtherInformationTableViewCell.h"
#import "XFJUploadPhotosTableViewCell.h"
#import "XFJStarTaskTableViewCell.h"
#import "HomeViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "TZImagePickerController.h"
#import "WSImagePickerView.h"
#import "WSPhotosBroseVC.h"
#import "XFJMinusCarNumTableViewCell.h"
#import "XFJVoucherPhotosTableViewCell.h"

@interface XFJOpenGroupViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,XFJUploadPhotosTableViewCellDelegate,UIScrollViewDelegate,XFJVoucherPhotosTableViewCellDelegate>

@property (nonatomic, strong) UIBarButtonItem *pushToLeftViewButton;

@property (nonatomic, strong) UILabel *title_label;

@property (nonatomic, strong) UITableView *openGroupTableView;

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, assign) NSInteger maxImageCount;

@property (nonatomic, strong) NSMutableArray *indexPaths;

@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, strong) UIScrollView *scroll_view;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) XFJVoucherPhotosTableViewCell *cell;

@property (nonatomic, strong) XFJUploadPhotosTableViewCell *uploadPhotosTableViewCell;

@end

@implementation XFJOpenGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    
    [self setUpLeftBarButtonItem];
    
    [self setUpOpenGroup];
}

- (UILabel *)title_label
{
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.XFJ_centerX, 6, 100, 44)];
        _title_label.text = @"开团";
        _title_label.textColor = kColor6565;
        _title_label.textAlignment = NSTextAlignmentCenter;
    }
    return _title_label;
}

- (UIScrollView *)scroll_view
{
    if (_scroll_view == nil) {
        _scroll_view = [[UIScrollView alloc] init];
        _scroll_view.frame = CGRectMake(0, 67, self.view.bounds.size.width, 1.2 * self.view.XFJ_Height);
        _scroll_view.pagingEnabled = YES;
        _scroll_view.delegate = self;
        _scroll_view.contentSize = CGSizeMake(0, self.view.XFJ_Height * 1.8);
//        _scroll_view.backgroundColor = kColoreeee;
//        _scroll_view.showsVerticalScrollIndicator = NO;
        _scroll_view.showsHorizontalScrollIndicator = NO;
//        _scroll_view.backgroundColor = [UIColor redColor];
        _scroll_view.scrollEnabled = YES;
    }
    return _scroll_view;
}

#pragma mark - 处理左侧导航栏
- (void)setUpLeftBarButtonItem
{
    self.navigationItem.leftBarButtonItem = self.pushToLeftViewButton;
    self.navigationItem.titleView = self.title_label;
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.shouldResignOnTouchOutside = YES;
    keyboardManager.keyboardDistanceFromTextField = 50;
    self.maxImageCount = 6;
}

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)datas
{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - 添加主内容
- (void)setUpOpenGroup
{
    [self.view addSubview:self.openGroupTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.openGroupTableView registerClass:[XFJConventionMessageTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJConventionMessageTableViewCell];
    [self.openGroupTableView registerClass:[XFJCarNameTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJCarNameTableViewCell];
    [self.openGroupTableView registerClass:[XFJGuestSourceInformationTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJGuestSourceInformationTableViewCell];
    [self.openGroupTableView registerClass:[XFJTeamInformationTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJTeamInformationTableViewCell];
    [self.openGroupTableView registerClass:[XFJOtherInformationTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJOtherInformationTableViewCell];
    [self.openGroupTableView registerClass:[XFJUploadPhotosTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJUploadPhotosTableViewCell];
//    [self.openGroupTableView registerClass:[XFJStarTaskTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJStarTaskTableViewCell];
    [self.openGroupTableView registerClass:[XFJVoucherPhotosTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJVoucherPhotosTableViewCell];
    NSLog(@"++++++=========-----获取到的用户当前的城市是:%@",self.locationWithUser);
    
}

#pragma mark - 加载 0：目的属性 1: 团队性质请求

- (UIBarButtonItem *)pushToLeftViewButton
{
    if (_pushToLeftViewButton == nil) {
        _pushToLeftViewButton = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"yonghu"] hightImage:nil target:self action:@selector(pushToUserController)];
    }
    return _pushToLeftViewButton;
}
- (void)pushToUserController
{
    NSLog(@"主人,您push到了侧滑栏~~");
}

- (UITableView *)openGroupTableView
{
    if (_openGroupTableView == nil) {
        _openGroupTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _openGroupTableView.backgroundColor = kColoreeee;
        //去掉分割线
        _openGroupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _openGroupTableView.delegate = self;
        _openGroupTableView.dataSource = self;
        _openGroupTableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    }
    return _openGroupTableView;
}

#pragma mark - 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - cell的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"self.indexPaths的数量是 : %ld",self.indexPaths.count);
    return 8 + self.indexPaths.count;
}

#pragma amrk - cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        XFJConventionMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJConventionMessageTableViewCell forIndexPath:indexPath];
        return cell;
    }else if (indexPath.row == 1) {
        XFJCarNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJCarNameTableViewCell forIndexPath:indexPath];
        cell.userLocation = self.locationWithUser;
        __weak __typeof(self)wself = self;
        cell.addCellBlock = ^(NSInteger buttonTag) {
            NSLog(@"主人,您点击了添加车牌按钮~~");
            [wself addCarNameButton:buttonTag];
        };
        return cell;
    }else if (indexPath.row == 2){
        XFJGuestSourceInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJGuestSourceInformationTableViewCell forIndexPath:indexPath];
        return cell;
    }else if (indexPath.row == 3) {
        XFJTeamInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJTeamInformationTableViewCell forIndexPath:indexPath];
        return cell;
    }else if (indexPath.row == 4) {
        XFJOtherInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJOtherInformationTableViewCell forIndexPath:indexPath];
        return cell;
    }else if (indexPath.row == 5) {
        XFJUploadPhotosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJUploadPhotosTableViewCell forIndexPath:indexPath];
        cell.dataArr = self.dataArr;
        cell.delegate = self;
        self.uploadPhotosTableViewCell = cell;
        cell.maxImageCount = 6;
//        __weak __typeof(self)wself = self;
        cell.chosePhotosBlock = ^() {
//            [wself chooseImage];
        };
        return cell;
    }else if (indexPath.row == 6) {
        XFJVoucherPhotosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJVoucherPhotosTableViewCell forIndexPath:indexPath];
        cell.delegate = self;
        self.cell = cell;
        return cell;
    }else {
        //        XFJStarTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJStarTaskTableViewCell forIndexPath:indexPath];
        static NSString *cellID = @"cellID";
        XFJStarTaskTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[XFJStarTaskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        __weak __typeof(self)wself = self;
        cell.startTaskButtonBlock = ^(){
            //该处提交用户填写的创建团队时候的参数
            [wself requestWithOpenTeam];
        };
        return cell;
    }
    return nil;
}

#pragma mark - 发送请求
- (void)requestWithOpenTeam
{
    
}


#pragma makr - 访问照相机
- (void)chooseImage:(XFJUploadPhotosTableViewCell *)SerPhotoCell
{
    self.maxImageCount = 6;
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"请选择相机或者相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择",nil];
    [action showInView:self.view];
    
}

- (void)chooseVoucherPhotosImage:(XFJVoucherPhotosTableViewCell *)voucherPhotos
{
    self.maxImageCount = 1;
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"请选择相机或者相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择",nil];
    [action showInView:self.view];
}



- (void)jumpCell:(XFJUploadPhotosTableViewCell *)cell indexPath:(NSIndexPath *)indexPath
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
                weakself.cell.dataArr = _dataArr;
                if (_dataArr.count <= 4) {
                    self.uploadPhotosTableViewCell.frame = CGRectMake(0, 480, SCREEN_WIDTH, 200);
                }
            });
        };
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)jumpToCell:(XFJVoucherPhotosTableViewCell *)cell indexPath:(NSIndexPath *)indexPath
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
                //                if (_dataArr.count <= 4) {
                //                    self.uploadPhotos_view.frame = CGRectMake(0, 728, SCREEN_WIDTH, 200);
                //                }
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
        self.uploadPhotosTableViewCell.dataArr = self.dataArr;
        self.uploadPhotosTableViewCell.maxImageCount = 6;
        [self.openGroupTableView reloadData];
    }else {
        NSLog(@"self.maxImageCount == 1");
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.dataArray addObject:image];
        [picker dismissViewControllerAnimated:YES completion:nil];
        self.cell.dataArr = self.dataArray;
        self.cell.maxImageCount = 1;
        [self.openGroupTableView reloadData];
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
        self.uploadPhotosTableViewCell.dataArr = self.dataArr;
        self.uploadPhotosTableViewCell.maxImageCount = 6;
        if (self.dataArr.count < 4) {
        }else {
            self.uploadPhotosTableViewCell.frame = CGRectMake(0, 480, SCREEN_WIDTH, 290);
        }
        [self.openGroupTableView reloadData];
    }else {
        NSLog(@"self.maxImageCount == 1----------");
        [self.dataArray addObjectsFromArray:photos];
        self.cell.dataArr = self.dataArray;
        self.cell.maxImageCount = 1;
        [self.openGroupTableView reloadData];
    }
}

- (void)addCarNameButton:(NSInteger)buttonTag
{
//    if (self.totalCount <= 6) {
//        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
//        [indexPaths addObject: indexPath];
//        self.indexPaths = indexPaths;
//        [self.openGroupTableView beginUpdates];
//        [self.openGroupTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
//        [self.openGroupTableView endUpdates];
//        self.totalCount = self.totalCount + 1;
//    }
}

#pragma mark - cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [XFJConventionMessageTableViewCell cellHeight];
    }else if (indexPath.row == 1) {
        return [XFJCarNameTableViewCell cellHeight];
    }else if (indexPath.row == 2) {
        return [XFJGuestSourceInformationTableViewCell cellHeight];
    }else if (indexPath.row == 3) {
        return [XFJTeamInformationTableViewCell cellHeight];
    }else if (indexPath.row == 4) {
        return [XFJOtherInformationTableViewCell cellHeight];
    }else if (indexPath.row == 5) {
        if (iphone5) {
            return self.dataArr.count >= 4 ? 240: 170;
        }else if (iphone6P) {
            return self.dataArr.count >= 4 ? 290: 200;
        }else if (iphone6) {
            return self.dataArr.count >= 4 ? 290: 200;
        }
    }if (indexPath.row == 6) {
        return [XFJVoucherPhotosTableViewCell cellHeight];
    }
    else{
        return [XFJStarTaskTableViewCell cellHeight];
    }
    return 0;
}

@end
