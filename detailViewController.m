//
//  detailViewController.m
//  original app
//
//  Created by ia on 2014/08/04.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//

#import "detailViewController.h"

@interface detailViewController ()

@end

@implementation detailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
    NSString *title  = [ud stringForKey:@"KEY_1"];  // KEY_1の内容をNSString型として取得
    titleLabel.text=[NSString stringWithFormat:@"%@",title];//labelに表示
    
    NSString *url  = [ud stringForKey:@"KEY_2"];  // KEY_2の内容をNSString型として取得
    urlLabel.text=[NSString stringWithFormat:@"%@",url];//labelに表示


    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
    NSString *title  = [ud stringForKey:@"KEY_1"];  // KEY_1の内容をNSString型として取得
    titleLabel.text=[NSString stringWithFormat:@"%@",title];//labelに表示
    
    NSString *url  = [ud stringForKey:@"KEY_2"];  // KEY_2の内容をNSString型として取得
    urlLabel.text=[NSString stringWithFormat:@"%@",url];//labelに表示

    NSString *jpg64Str = [ud stringForKey:@"KEY_3"];// KEY_3の内容をNSString型として取得
    NSData *jpgData = [[NSData alloc] initWithBase64EncodedString:jpg64Str
                                                          options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage* image = [UIImage imageWithData:jpgData];
    imgView.image = image;


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
