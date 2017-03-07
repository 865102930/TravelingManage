//
//  XFJOpinionAndSuggestView.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/3/6.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFJOpinionAndSuggestView : UIView

//将用户编辑的内容传递到控制器中
@property (nonatomic, copy) void (^textViewTextBlock)(NSString *) ;

@end
