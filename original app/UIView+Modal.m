//
//  UIView+Modal.m
//  original
//
//  Created by ia on 2015/03/14.
//  Copyright (c) 2015年 Life is tech. All rights reserved.
//

#import "UIView+Modal.h"

@implementation UIView (Modal)

- (UIView *)overlayView
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:[self myWindow].frame];
    backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
    return backgroundView;
}

- (UIWindow *)myWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if(!window)window=[[UIApplication sharedApplication].windows objectAtIndex:0];
    window.frame = UIScreen.mainScreen.bounds;
    return window;
}

@end