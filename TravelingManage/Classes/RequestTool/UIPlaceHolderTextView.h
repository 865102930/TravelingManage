//
//  UIPlaceHolderTextView.h
//  elevator
//
//  Created by 戎翠林 on 16/9/1.
//  Copyright © 2016年 郑子煜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIPlaceHolderTextView : UITextView {
    
    NSString *placeholder;
    
    UIColor *placeholderColor;
    
@private
    
    UILabel *placeHolderLabel;
    
}

@property(nonatomic, strong) UILabel *placeHolderLabel;

@property(nonatomic, strong) NSString *placeholder;

@property(nonatomic, strong) UIColor *placeholderColor;



-(void)textChanged:(NSNotification*)notification;



@end
