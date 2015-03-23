//
//  TabBarViewController.m
//  original
//
//  Created by ia on 2014/12/20.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//

#import "TabBarViewController.h"
#import "TutorialViewController.h"

#define PINK_COLOR [UIColor colorWithRed:231/255.0 green:101/255.0 blue:131/255.0 alpha:1.0f]

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //YES -> modal
    //    flag = [[NSUserDefaults standardUserDefaults] boolForKey:@"launchFlag"];
    //    if (flag == NO) {
    //        NSLog(@"//YES -> modal to TutorialVC");
    //TODO: TutorialVCに移動する！
    
//    TutorialViewController *tvc = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialVC"];
//    [self presentViewController:tvc animated:NO completion:nil];
    //        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"launchFlag"];
    //    }
    //NO -> 移動しない
    //        NSLog(@"%d",flag);
    
    
   
}
- (void)viewWillAppear:(BOOL)animated {
    [UITabBar appearance].barTintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];//下のバーを白く
    //[UITabBar appearance].barTintColor = [UIColor colorWithRed:244/255.0 green:162/255.0 blue:173/255.0 alpha:1.000];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1.0f] }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor colorWithRed:231/255.0 green:101/255.0 blue:131/255.0 alpha:1.0f] }
                                             forState:UIControlStateSelected];
    //0.886f green:0 blue:0.415f alpha:1.0f]
    //[[self tabBar] setTintColor:[UIColor colorWithRed:241/255.0 green:206/255.0 blue:130/255.0 alpha:1.0f]];//文字の色
    [[self tabBar] setSelectedImageTintColor:PINK_COLOR];//選択されてるときの色
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
