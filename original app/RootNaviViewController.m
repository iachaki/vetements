//
//  RootNaviViewController.m
//  original
//
//  Created by ia on 2014/12/20.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//

#import "RootNaviViewController.h"

@interface RootNaviViewController ()

@end

@implementation RootNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationBarTitleImage:[UIImage imageNamed:@"vétements-logo.png"]];
}

- (void)setNavigationBarTitleImage:(UIImage *)image
{
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:image];
    // Adjust Image Size
    titleImageView.frame = CGRectMake(0, 0, image.size.width * 0.5, image.size.height * 0.5);
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(-image.size.width*0.5, 0, titleImageView.frame.size.width , titleImageView.frame.size.height)];
    [titleView addSubview:titleImageView];
    self.navigationItem.titleView = titleView;
    
}
- (void)didReceiveMemoryWarning {
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
