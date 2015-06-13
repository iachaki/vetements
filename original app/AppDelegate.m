//
//  AppDelegate.m
//  original app
//
//  Created by ia on 2014/06/27.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//

#import "AppDelegate.h"
#import "TutorialViewController.h"
#import "GAI.h"
#import <Parse/Parse.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
//    TutorialViewController *tvc = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"TutorialVC"];//TutorialVCはstoryboardで自分で設定したい文字列
//    [self.window makeKeyAndVisible];//見えるようにする
//    [self.window.rootViewController presentViewController:tvc animated:NO completion:NULL];//modalで移動する
    // Google Analyticsの初期化


    
    [MagicalRecord setupCoreDataStack];
    [self initRootController];
    // window初期化

    // Google Analyticsの初期化
    [self initializeGoogleAnalytics];

    [Parse setApplicationId:@"ZwAtI84EsxxJRW5P0kqB1eRot2hR8axQF6mla9Yw"
                  clientKey:@"V7Koq4LiTwup5PCJnqpqgydURjvhVPDVPIidmoSl"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    
    return YES;
}

#pragma mark - Init Window

- (void)initializeGoogleAnalytics
{
    // トラッキングIDを設定
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-64072548-1"];
    
    // 例外を Google Analytics に送る
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
}

// window初期化
- (void)initWindow
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    _window = [[UIWindow alloc] initWithFrame:bounds];
}
- (void)initRootController
{
    // 基点となる Controller生成
    _rootController = [[UITabBarController alloc] init];
    TableViewController *tabTable =[[TableViewController alloc]init];
    ViewController *tabView = [[ViewController alloc]init];
    
    if ([self isIOS7]) { // iOS 7用のタブバー生成
//        // タブのアイコン指定
//        tabView.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"View"
//                                                            image:[[UIImage imageNamed:@"love4.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//                                                    selectedImage:[[UIImage imageNamed:@"love4.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//        
//        tabTable.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Table"
//                                                             image:[[UIImage imageNamed:@"internet5.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//                                                     selectedImage:[[UIImage imageNamed:@"internet5.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        UITabBarItem *table = [_rootController.tabBar.items objectAtIndex:0];
        table.image = [[UIImage imageNamed:@"love4.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

        // タブのフォント指定
        UIFont *tabFont = [UIFont fontWithName:@"HelveticaNeue" size:9.0f];
    
        // タブのタイトル色指定
        NSDictionary *attributesNormal = @{NSFontAttributeName:tabFont, NSForegroundColorAttributeName:[UIColor colorWithRed:0.733f green:0.733f blue:0.733f alpha:1.0f]};
        [[UITabBarItem appearance] setTitleTextAttributes:attributesNormal forState:UIControlStateNormal];
    
        // タブのタイトル色指定 (選択中)
        NSDictionary *selectedAttributes = @{NSFontAttributeName:tabFont, NSForegroundColorAttributeName:[UIColor colorWithRed:0.886f green:0 blue:0.415f alpha:1.0f]};
        [[UITabBarItem appearance] setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];

    } else {
        // タブのアイコン指定
        [tabView.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"love4.png"]
                          withFinishedUnselectedImage:[UIImage imageNamed:@"love4.png"]];
        [tabTable.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"internet5.png"]
                           withFinishedUnselectedImage:[UIImage imageNamed:@"internet5.png"]];

        // タブのタイトル指定
        [tabTable setTitle:@"Table"];
        [tabView setTitle:@"View"];
        
        // タブのタイトル色指定
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.733f green:0.733f blue:0.733f alpha:1.0f], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
        
        // タブのタイトル色指定 (選択中)
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.886f green:0 blue:0.415f alpha:1.0f], UITextAttributeTextColor,nil] forState:UIControlStateSelected];
    }
    
    // タブのタイトル位置設定
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    // ビューを Controllerに追加
    NSArray *controllers = [NSArray arrayWithObjects:tabTable, tabView, nil];
    [(UITabBarController *)_rootController setViewControllers:controllers animated:NO];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Private method

// iOS7以降であるか
- (BOOL)isIOS7
{
    NSString *osversion = [UIDevice currentDevice].systemVersion;
    NSArray *a = [osversion componentsSeparatedByString:@"."];
    return ([(NSString*)[a objectAtIndex:0] intValue] >= 7);
}


@end
