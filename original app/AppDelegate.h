//
//  AppDelegate.h
//  original app
//
//  Created by ia on 2014/06/27.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewController.h"
#import "ViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UITabBarController *_rootController;
}

@property (strong, nonatomic) UIWindow *window;

#pragma mark - yuma_fix
@property (nonatomic) NSMutableArray *dataArray;


@end
