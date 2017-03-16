//
//  XFJTeamMessageViewController.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/4.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "XFJTeamMessageViewController.h"
#import "XFJPleasePerfectView.h"
#import "XFJGeneralMessageView.h"
#import "XFJOtherMessagePerfectView.h"
#import "XFJCarPhotosWithPerfectView.h"
#import "TZImagePickerController.h"
#import "WSImagePickerView.h"
#import "WSPhotosBroseVC.h"
#import "XFJUpPhotosOpenTeamMessageView.h"
#import "XFJTeamMessageBottomView.h"
#import "XFJFindTeamTasksItem.h"
#import "XFJTaskRowsItem.h"
#import "XFJPleasePerfectMessageViewController.h"
#import "XFJPleaseAppraiseViewController.h"
#import "XFJFindCustomAttrListItem.h"
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
#import "XFJMineTeamViewController.h"
#import "XFJSignMessageViewController.h"


@interface XFJTeamMessageViewController () <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,XFJCarPhotosWithPerfectViewDelegate,XFJUpPhotosOpenTeamMessageViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) UIScrollView *scroll_view;
@property (nonatomic, strong) XFJPleasePerfectView *pleasePerfectView;
@property (nonatomic, strong) XFJGeneralMessageView *generalMessageView;
@property (nonatomic, strong) XFJOtherMessagePerfectView *otherMessagePerfectView;
@property (nonatomic, strong) XFJCarPhotosWithPerfectView *carPhotosWithPerfectView;
@property (nonatomic, strong) XFJUpPhotosOpenTeamMessageView *upPhotosOpenTeamMessageView;
@property (nonatomic, strong) XFJTeamMessageBottomView *teamMessageBottomView;
@property (nonatomic, assign) NSInteger maxImageCount;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray <XFJFindTeamTasksItem *> *findTeamTasksItemArray;
@property (nonatomic, strong) NSMutableArray <XFJTaskRowsItem *> *taskRowsArray;
//自定义字段文本的内容
@property (nonatomic, strong) NSMutableArray <XFJFindCustomAttrListItem *> *findCustomAttrListItemArray;
//自定义属性
@property (nonatomic, strong) UITableView *attrList_tableView;
@property (nonatomic, strong) UIView *backGround_view;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSMutableArray *attrTypeArray;
@property (nonatomic, strong) XFJMaskView *maskView1;
@property (nonatomic, strong) XFJCheckBoxView *checkBoxView;
@property (nonatomic, strong) NSMutableArray *allBackArray;
@property (nonatomic, strong) NSMutableArray *allRootImage;
@property (nonatomic, strong) NSString *root;
@property (nonatomic, strong) NSString *voucherPicRoot;
@property (nonatomic, assign) NSInteger teamId;
//这个用来装所有的自定义信息的集合
@property (nonatomic, strong) NSMutableArray *allAttribute_array;
@property (nonatomic, strong) NSString *AttributeStr;


@end

@implementation XFJTeamMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setInitWithNav];
    
    [self.view addSubview:self.scroll_view];
    [self.scroll_view addSubview:self.backGround_view];
    [self.scroll_view addSubview:self.pleasePerfectView];
    [self.scroll_view addSubview:self.generalMessageView];
    [self.scroll_view addSubview:self.otherMessagePerfectView];
    [self.backGround_view addSubview:self.carPhotosWithPerfectView];
    [self.backGround_view addSubview:self.upPhotosOpenTeamMessageView];
    [self.scroll_view addSubview:self.teamMessageBottomView];
    [self.scroll_view addSubview:self.attrList_tableView];
    
    self.view.backgroundColor = [UIColor redColor];
    
    NSLog(@"-------------self.findTeamInfoByState_Id的结果是 :%zd",self.findTeamInfoByState_Id);
    
    self.teamMessageBottomView.findTeamInfoByState_Id = self.findTeamInfoByState_Id;
    
    //请求到的自定页面数据
    [self requestTeamMessage];
    
    //请求自定义字段数据
    [self requestFindCustomAttrListMessage:self.findTeamInfoByState_Id];
    __weak __typeof(self)wself = self;
    self.teamMessageBottomView.sureCommitBlock = ^(NSInteger teamId) {
        wself.teamId = teamId;
        //上传图片接口
        [wself requestWithOpenTeam];
    };
    self.teamMessageBottomView.taskRowsItemArrayItemBlock = ^(XFJTaskRowsItem *taskRowsItem) {
        XFJSignMessageViewController *signMessageController = [[XFJSignMessageViewController alloc] init];
        signMessageController.taskRowsItem = taskRowsItem;
        signMessageController.findNewTeamInfo_Id = wself.findTeamInfoByState_Id;
        [wself.navigationController pushViewController:signMessageController animated:YES];
    };
    self.checkBoxView.chooseCheckBoxBlock = ^(NSString *resultStr) {
        [wself.checkBoxView removeFromSuperview];
        [wself.maskView1 removeFromSuperview];
        NSLog(@"--------------在这里拿到所有用户选择的信息是 :%@",resultStr);
        wself.AttributeStr = resultStr;
        [wself.attrList_tableView reloadData];
    };
    self.maskView1.maskBlock = ^() {
        [wself.maskView1 removeFromSuperview];
    };
    [self.backGround_view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(340.0);
        make.top.mas_equalTo(self.attrList_tableView.mas_bottom);
    }];
    [self.teamMessageBottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(300.0);
        make.top.mas_equalTo(self.upPhotosOpenTeamMessageView.mas_bottom);
    }];
    [self.attrList_tableView registerClass:[XFJFirestAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJFirestAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJSecondAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJSecondAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJThirdAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJThirdAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJFourAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJFourAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJFiveAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJFiveAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJSixAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJSixAttributeTableViewCell];
    [self.attrList_tableView registerClass:[XFJSevenTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJSevenTableViewCell];
    [self.attrList_tableView registerClass:[XFJEigthAttributeTableViewCell class] forCellReuseIdentifier:KCellIdentifier_XFJEigthAttributeTableViewCell];
}

#pragma mark - 发送请求
- (void)requestWithOpenTeam
{
    //上传图片
    [self upLoadPic];
    [self upLoadVoucherPic];
}

- (NSMutableArray *)allRootImage
{
    if (_allRootImage == nil) {
        _allRootImage = [NSMutableArray array];
    }
    return _allRootImage;
}

- (NSMutableArray *)allAttribute_array
{
    if (_allAttribute_array == nil) {
        _allAttribute_array = [NSMutableArray array];
    }
    return _allAttribute_array;
}

#pragma mark - 图片上传车辆照片
- (void)upLoadPic
{
    if (self.dataArr.count == 0) {
        NSLog(@"图片上传失败------");
    }else {
        for (int i = 0; i < _dataArr.count; i++) {
            UIImage *image = _dataArr[i];
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
                [wself.allRootImage addObject:root];
                wself.root = [wself.allRootImage componentsJoinedByString:@","];
                NSLog(@"上传图片成功后的信息-------%@+++++++%@",root,wself.root);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"上传图片失败--------%@",error);
            }];
        }
    }
}

#pragma mark - 上传凭证
- (void)upLoadVoucherPic
{
    if (self.dataArray == 0) {
        NSLog(@"图片丢失~~~~~~");
    }else {
        UIImage *image = self.dataArray[0];
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
            wself.voucherPicRoot = root;
            NSLog(@"上传图片成功后的信息-------%@",root);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (wself.root.length == 0) {
                    [MBProgressHUD showHudTipStr:@"图片上传失败~~" contentColor:HidWithColorContentBlack];
                    return ;
                }
                //确认提交接口
                [wself sureCommitWithAttributeTeamId:self.teamId];
                //弹出确认提交和取消弹窗
                [wself sureAndCommitShow:self.teamId];
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"上传图片失败--------%@",error);
        }];
    }
}


#pragma mark - 完善资料的确认提交
- (void)sureCommitWithAttributeTeamId:(NSInteger)teamId
{
    //转成json格式给服务器发送
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.allAttribute_array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *dictParams = @{
                                 @"id":[NSString stringWithFormat:@"%zd",teamId],
                                 @"teamBack":jsonString,
                                 @"teamVehicleImages":self.voucherPicRoot//图片集合
                                 };
    [GRNetRequestClass POST:MODIFYTEAMINFOURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSString *success = [responseObject objectForKey:@"success"];
            if ([success intValue] == 1) {
                [MBProgressHUD showHudTipStr:@"修改资料成功!" contentColor:HidWithColorContentBlack];
            }
            NSLog(@"--------------修改信息完成后显示的结果是:%@",responseObject);
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            [MBProgressHUD showHudTipStr:@"修改信息失败" contentColor:HidWithColorContentBlack];
            NSLog(@"++++++++++++++修改信息失败的结果是 :%@",error);
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

- (XFJCheckBoxView *)checkBoxView
{
    if (_checkBoxView == nil) {
        _checkBoxView = [[XFJCheckBoxView alloc] initWithFrame:CGRectMake(50, 150, SCREEN_WIDTH - 2 * 50, SCREEN_HEIGHT - 2 * 150)];
    }
    return _checkBoxView;
}

- (NSMutableArray *)allBackArray
{
    if (_allBackArray == nil) {
        _allBackArray = [NSMutableArray array];
    }
    return _allBackArray;
}

- (XFJMaskView *)maskView1
{
    if (_maskView1 == nil) {
        _maskView1 = [[XFJMaskView alloc] initWithFrame:CGRectZero];
    }
    return _maskView1;
}


#pragma mark - 确认提交和上传附件
- (void)sureAndCommitShow:(NSInteger)teamId
{
    UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"提交完成!\n欢迎对本次带团进行评价!" preferredStyle:UIAlertControllerStyleAlert];
    __weak __typeof(self)wself = self;
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
        NSLog(@"主人~~您点击了上传附件按钮!");
        [wself.navigationController popViewControllerAnimated:YES];
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"立即评价" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"主人~~您点击了立即评价按钮!");
        [wself jumpPleaseAppraise:teamId];
    }]];
    [self presentViewController:alertVc animated:NO completion:nil];
}

- (UIView *)backGround_view
{
    if (_backGround_view == nil) {
        _backGround_view = [[UIView alloc] init];
        _backGround_view.backgroundColor = [UIColor redColor];
    }
    return _backGround_view;
}

#pragma mark - 跳转到完善资料的控制器
- (void)jumpPleasePerfectMessage:(NSInteger)teamId
{
    XFJPleasePerfectMessageViewController *pleasePerfectMessageViewController = [[XFJPleasePerfectMessageViewController alloc] init];
    pleasePerfectMessageViewController.teamId = teamId;
    [self.navigationController pushViewController:pleasePerfectMessageViewController animated:YES];
}
#pragma mark - 跳转到立即评价控制器
- (void)jumpPleaseAppraise:(NSInteger)teamId
{
    XFJPleaseAppraiseViewController *pleaseAppraiseViewController = [[XFJPleaseAppraiseViewController alloc] init];
    pleaseAppraiseViewController.teamId = teamId;
    [self.navigationController pushViewController:pleaseAppraiseViewController animated:YES];
}

- (void)setInitWithNav
{
    self.navigationItem.titleView = self.title_label;
}

- (UILabel *)title_label
{
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.XFJ_centerX, 6, 100, 44)];
        _title_label.text = @"待完善";
        _title_label.textColor = kColor6565;
        _title_label.textAlignment = NSTextAlignmentCenter;
    }
    return _title_label;
}

- (UITableView *)attrList_tableView
{
    if (_attrList_tableView == nil) {
        _attrList_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 293, SCREEN_WIDTH, 0.5) style:UITableViewStylePlain];
        _attrList_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _attrList_tableView.backgroundColor = [UIColor whiteColor];
        _attrList_tableView.delegate = self;
        _attrList_tableView.dataSource = self;
        _attrList_tableView.bounces = NO;
    }
    return _attrList_tableView;
}

- (NSMutableArray <XFJFindTeamTasksItem *> *)findTeamTasksItemArray
{
    if (_findTeamTasksItemArray == nil) {
        _findTeamTasksItemArray = [NSMutableArray array];
    }
    return _findTeamTasksItemArray;
}

- (NSMutableArray <XFJTaskRowsItem *> *)taskRowsArray
{
    if (_taskRowsArray == nil) {
        _taskRowsArray = [NSMutableArray array];
    }
    return _taskRowsArray;
}
- (void)requestTeamMessage
{
    NSDictionary *dictParams = @{
                                 @"id":[NSString stringWithFormat:@"%zd",self.findTeamInfoByState_Id]
                                 };
    __weak __typeof(self)wself = self;
    [GRNetRequestClass POST:FINDTEAMINFOTASKSURL params:dictParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSMutableArray *findArray = [responseObject objectForKey:@"rows"];
            wself.findTeamTasksItemArray = [XFJFindTeamTasksItem mj_objectArrayWithKeyValuesArray:findArray];
            wself.generalMessageView.findTeamTasksItem = wself.findTeamTasksItemArray;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"++++++++获取团队信息资料失败的是 :%@",error);
        }
    }];
}

#pragma mark - 加载自定义字段数据
- (void)requestFindCustomAttrListMessage:(NSInteger)teamId
{
    NSDictionary *dictParams = @{
                                 @"teamId":[NSString stringWithFormat:@"%zd",self.findTeamInfoByState_Id],
                                 @"teamAttractionsType":@0
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
            if (wself.findCustomAttrListItemArray.count == 0) {
                [wself.otherMessagePerfectView removeFromSuperview];
            }
            [wself.attrList_tableView reloadData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"___________返回错误的信息是 :%@",error);
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

- (UIScrollView *)scroll_view
{
    if (_scroll_view == nil) {
        _scroll_view = [[UIScrollView alloc] init];
        _scroll_view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 1.2 * self.view.XFJ_Height);
        _scroll_view.contentSize = CGSizeMake(0, self.view.XFJ_Height * 2);
        _scroll_view.backgroundColor = kColoreeee;
        _scroll_view.showsHorizontalScrollIndicator = NO;
        _scroll_view.scrollEnabled = YES;
    }
    return _scroll_view;
}

- (XFJPleasePerfectView *)pleasePerfectView
{
    if (_pleasePerfectView == nil) {
        _pleasePerfectView = [[XFJPleasePerfectView alloc] initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, 72.0)];
        _pleasePerfectView.backgroundColor = [UIColor whiteColor];
    }
    return _pleasePerfectView;
}

- (XFJGeneralMessageView *)generalMessageView
{
    if (_generalMessageView == nil) {
        _generalMessageView = [[XFJGeneralMessageView alloc] initWithFrame:CGRectMake(0, 73, SCREEN_WIDTH, 220)];
        _generalMessageView.backgroundColor = [UIColor whiteColor];
    }
    return _generalMessageView;
}

- (XFJOtherMessagePerfectView *)otherMessagePerfectView
{
    if (_otherMessagePerfectView == nil) {
        _otherMessagePerfectView = [[XFJOtherMessagePerfectView alloc] initWithFrame:CGRectMake(0, 293, SCREEN_WIDTH, 100)];
        _otherMessagePerfectView.backgroundColor = [UIColor whiteColor];
    }
    return _otherMessagePerfectView;
}

- (XFJCarPhotosWithPerfectView *)carPhotosWithPerfectView
{
    if (_carPhotosWithPerfectView == nil) {
        _carPhotosWithPerfectView = [[XFJCarPhotosWithPerfectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
        _carPhotosWithPerfectView.backgroundColor = [UIColor whiteColor];
        _carPhotosWithPerfectView.delegate = self;
    }
    return _carPhotosWithPerfectView;
}
- (XFJUpPhotosOpenTeamMessageView *)upPhotosOpenTeamMessageView
{
    if (_upPhotosOpenTeamMessageView == nil) {
        _upPhotosOpenTeamMessageView = [[XFJUpPhotosOpenTeamMessageView alloc] initWithFrame:CGRectMake(0, 170, SCREEN_WIDTH, 170)];
        _upPhotosOpenTeamMessageView.backgroundColor = [UIColor whiteColor];
        _upPhotosOpenTeamMessageView.delegate = self;
    }
    return _upPhotosOpenTeamMessageView;
}

- (XFJTeamMessageBottomView *)teamMessageBottomView
{
    if (_teamMessageBottomView == nil) {
        _teamMessageBottomView = [[XFJTeamMessageBottomView alloc] init];
        _teamMessageBottomView.backgroundColor = [UIColor whiteColor];
    }
    return _teamMessageBottomView;
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

#pragma makr - 访问照相机
- (void)chooseImage:(XFJCarPhotosWithPerfectView *)SerPhotoCell
{
    self.maxImageCount = 6;
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"请选择相机或者相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择",nil];
    [action showInView:self.view];
}

- (void)chooseVoucherPhotosImage:(XFJUpPhotosOpenTeamMessageView *)voucherPhotos
{
    self.maxImageCount = 1;
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"请选择相机或者相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择",nil];
    [action showInView:self.view];
}



- (void)jumpCell:(XFJCarPhotosWithPerfectView *)cell indexPath:(NSIndexPath *)indexPath
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
                weakself.carPhotosWithPerfectView.dataArr = _dataArr;
                if (_dataArr.count <= 4) {
                    self.carPhotosWithPerfectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 170);
                    self.upPhotosOpenTeamMessageView.frame = CGRectMake(0, 170, SCREEN_WIDTH, 170);
                }
            });
        };
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)jumpToCell:(XFJUpPhotosOpenTeamMessageView *)cell indexPath:(NSIndexPath *)indexPath
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
                weakself.upPhotosOpenTeamMessageView.dataArr = _dataArray;
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
        self.carPhotosWithPerfectView.dataArr = self.dataArr;
        self.carPhotosWithPerfectView.maxImageCount = 6;
    }else {
        NSLog(@"self.maxImageCount == 1");
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.dataArray addObject:image];
        [picker dismissViewControllerAnimated:YES completion:nil];
        self.upPhotosOpenTeamMessageView.dataArr = self.dataArray;
        self.upPhotosOpenTeamMessageView.maxImageCount = 1;
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
        self.carPhotosWithPerfectView.dataArr = self.dataArr;
        self.carPhotosWithPerfectView.maxImageCount = 6;
        if (self.dataArr.count < 4) {
        }else {
            self.carPhotosWithPerfectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 230);
            self.upPhotosOpenTeamMessageView.frame = CGRectMake(0, 230, SCREEN_WIDTH, 170);
        }
    }else {
        NSLog(@"self.maxImageCount == 1----------");
        [self.dataArray addObjectsFromArray:photos];
        self.upPhotosOpenTeamMessageView.dataArr = self.dataArray;
        self.upPhotosOpenTeamMessageView.maxImageCount = 1;
    }
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
            [[UIApplication sharedApplication].keyWindow addSubview:wself.maskView1];
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
        cell.presentPickPhotosBlock = ^(TZImagePickerController *pickerController) {
          [wself presentViewController:pickerController animated:YES completion:nil];
        };
        return cell;
    }else {
        XFJEigthAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_XFJEigthAttributeTableViewCell forIndexPath:indexPath];
        cell.teamAttr = self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr;
        NSLog(@"---------获取的back值是7 :%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr);
        __weak __typeof(self)wself = self;
        cell.presentMaskViewBlock = ^(NSString *typesStr) {
            [[UIApplication sharedApplication].keyWindow addSubview:wself.maskView1];
            self.checkBoxView.backStr = typesStr;
            [wself.maskView1 addSubview:self.checkBoxView];
            NSLog(@"-------------这里打印的back值是 :%@",typesStr);
        };
        if (self.AttributeStr != nil) {
            NSDictionary *dict = @{
                                   @"name":self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr,//这是显示的是back几
                                   @"value":self.AttributeStr//这里添加的是和back对应的值
                                   };
            [self.allAttribute_array addObject:dict];
            NSLog(@"这是显示的是back%@--------这里添加的是和back对应的值%@",self.findCustomAttrListItemArray[[ty_pe intValue]].teamAttr,self.AttributeStr);
        }
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





@end
