//
//  AnnouncementDetailViewController.h
//  TravelingManage
//
//  Created by 戎翠林 on 17/2/13.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AnnouncementDetailModel;

@interface AnnouncementDetailViewController : UITableViewController

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, strong) AnnouncementDetailModel *announcementDetailModel;

@end
