//
//  UIPlaceHolderTextView.m
//  elevator
//
//  Created by 戎翠林 on 16/9/1.
//  Copyright © 2016年 郑子煜. All rights reserved.
//

#import "UIPlaceHolderTextView.h"

@interface UIPlaceHolderTextView () <UITextViewDelegate>

@end

@implementation UIPlaceHolderTextView

@synthesize placeHolderLabel;

@synthesize placeholder;

@synthesize placeholderColor;

- (void)awakeFromNib

{
    
    [super awakeFromNib];
    
    [self setPlaceholder:@""];
    
    [self setPlaceholderColor:[UIColor lightGrayColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
}



- (id)initWithFrame:(CGRect)frame

{
    
    if( (self = [super initWithFrame:frame]) )
        
    {
        
        [self setPlaceholder:@""];
        
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    
    return self;
    
}



- (void)textChanged:(NSNotification *)notification

{
    if([[self placeholder] length] == 0) return;

    if([[self text] length] == 0) {
        
        [[self viewWithTag:999] setAlpha:1];
        
   } else{
        
        [[self viewWithTag:999] setAlpha:0];
        
    }
}



- (void)setText:(NSString *)text {
    
    [super setText:text];
    
    [self textChanged:nil];
    
}



- (void)drawRect:(CGRect)rect

{
    
    if( [[self placeholder] length] > 0 ) {
        
        if ( placeHolderLabel == nil ) {
            
            placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(3,6,self.bounds.size.width - 16,0)];

            placeHolderLabel.numberOfLines = 0;
            
            if(iphone4and5) {
               
                placeHolderLabel.font = [UIFont systemFontOfSize:12] ;

            }else{
               
                placeHolderLabel.font = [UIFont systemFontOfSize:14] ;

            }
            
            placeHolderLabel.backgroundColor = [UIColor clearColor];
            
            placeHolderLabel.textColor = self.placeholderColor;
            
            placeHolderLabel.alpha = 0;
            
            placeHolderLabel.tag = 999;
            
            
            
            [self addSubview:placeHolderLabel];
            
        }
        
        
        
        placeHolderLabel.text = self.placeholder;
        
        [placeHolderLabel sizeToFit];
        
        [self sendSubviewToBack:placeHolderLabel];
        
    }
    
    
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
        
    {
        
        [[self viewWithTag:999] setAlpha:1];
        
    }
    
    
    
    [super drawRect:rect];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

@end






