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

@interface XFJOpenGroupViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,XFJUploadPhotosTableViewCellDelegate>

@property (nonatomic, strong) UIBarButtonItem *pushToLeftViewButton;

@property (nonatomic, strong) UILabel *title_label;

@property (nonatomic, strong) UITableView *openGroupTableView;

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, assign) NSInteger maxImageCount;

@property (nonatomic, strong) XFJUploadPhotosTableViewCell *cell;

@end

@implementation XFJOpenGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
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

#pragma mark - 添加主内容
- (void)setUpOpenGroup
{
    [self.view addSubview:self.openGroupTableView];
    [self.openGroupTableView registerClass:[XFJConventionMessageTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJConventionMessageTableViewCell];
    [self.openGroupTableView registerClass:[XFJCarNameTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJCarNameTableViewCell];
    [self.openGroupTableView registerClass:[XFJGuestSourceInformationTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJGuestSourceInformationTableViewCell];
    [self.openGroupTableView registerClass:[XFJTeamInformationTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJTeamInformationTableViewCell];
    [self.openGroupTableView registerClass:[XFJOtherInformationTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJOtherInformationTableViewCell];
    [self.openGroupTableView registerClass:[XFJUploadPhotosTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJUploadPhotosTableViewCell];
    [self.openGroupTableView registerClass:[XFJStarTaskTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJStarTaskTableViewCell];
}

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
        _openGroupTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _openGroupTableView.backgroundColor = kColoreeee;
        //去掉分割线
        _openGroupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _openGroupTableView.delegate = self;
        _openGroupTableView.dataSource = self;
        _openGroupTableView.contentInset = UIEdgeInsetsMake(0, 0, 4, 0);
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
    return 7 + [self.datas count];
}

#pragma amrk - cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        XFJConventionMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJConventionMessageTableViewCell forIndexPath:indexPath];
        return cell;
    }else if (indexPath.row == 1) {
        XFJCarNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJCarNameTableViewCell forIndexPath:indexPath];
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
        cell.maxImageCount = 6;
//        __weak __typeof(self)wself = self;
        cell.chosePhotosBlock = ^() {
//            [wself chooseImage];
        };
        return cell;
    }else {
        XFJStarTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJStarTaskTableViewCell forIndexPath:indexPath];
        cell.startTaskButtonBlock = ^(){
            HomeViewController *homeController = [[HomeViewController alloc]init];
            [self.navigationController pushViewController:homeController animated:YES];
        };
        return cell;
    }
    
    return nil;
}

#pragma makr - 访问照相机
- (void)chooseImage:(XFJUploadPhotosTableViewCell *)SerPhotoCell
{
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
                [weakself.openGroupTableView reloadData];
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
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxImageCount - self.dataArr.count delegate:self];
        
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }else{
//        [MBProgressHUD showHUDMsg: @"请打开允许访问相册权限" ];
    }
}

//相机选的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.dataArr addObject:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.openGroupTableView reloadData];
}

//取消按钮
- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picke{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 相册选的图片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    [self.dataArr addObjectsFromArray:photos];
    [self.openGroupTableView reloadData];
}
    

- (void)addCarNameButton:(NSInteger)buttonTag
{
//    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
//    for (NSInteger i = buttonTag; i < 6; i++) {
//        NSString *s = [[NSString alloc] initWithFormat:@"hello %ld",i];
//        [self.datas addObject:s];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:1];
//        [indexPaths addObject: indexPath];
//    }
//    [self.openGroupTableView beginUpdates];
//    [self.openGroupTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
//    [self.openGroupTableView endUpdates];
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
    }else {
        return [XFJStarTaskTableViewCell cellHeight];
    }
    return 0;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ADDPHOTOSBUTTONCLICKNOTIC" object:nil];
}






@end
