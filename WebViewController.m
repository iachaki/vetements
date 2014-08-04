//
//  WebViewController.m
//  original app
//
//  Created by ia on 2014/07/14.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
	
    NSURL *url = [NSURL URLWithString:@"http://www.dholic.co.jp/"];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [webView loadRequest:req];
    
    UITapGestureRecognizer *gs = [[UITapGestureRecognizer alloc] init];
    gs.numberOfTapsRequired = 1;
    gs.delegate = self;
    [self.view addGestureRecognizer:gs];
    
    
    //UIWebViewのインスタンス化
    // CGRect rect = self.view.frame;
    // UIWebView *webView = [[UIWebView alloc]initWithFrame:rect];
    
    //Webページの大きさを自動的に画面にフィットさせる
    //webView.scalesPageToFit = YES;
    
    //デリゲートを指定
    //webView.delegate = self;
    
    //URLを指定
    //NSURL *url =[NSURL URLWithString:@"http://www.google.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //リクエストを投げる
    [webView loadRequest:request];
    
    //UIWebViewのインスタンスをビューに追加
    //[self .view addSubview:webView];
    
    
}
//Webページのロード時にインジケータを動かす
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

//Webページのロード完了時にインジケータを非表示にする
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)getur{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString* title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //NSLog(@"%@",title);
    label.text=[NSString stringWithFormat:@"%@",title];
    [ud setObject:title forKey:@"KEY_1"];  // "title(商品名)"をKEY_1というキーで保存
    
    
    
    NSString* url = [webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
    //NSLog(@"%@",url);
    label2.text=[NSString stringWithFormat:@"%@",url];
    [ud setObject:url forKey:@"KEY_2"];  // "URL"をKEY_2というキーで保存
    
    NSString *s = [ud stringForKey:@"KEY_1"];
    NSLog(@"保存したタイトルは　%@",s);
    
    
    
    //NSUserdefaultsを使ってViewController.mにデータを送る
    
    //NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    // NSStringの保存
    //[defaults setObject:title forKey:@"title"];
    
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    NSLog(@"TAPPED");
    //Touch gestures below top bar should not make the page turn.
    //EDITED Check for only Tap here instead.
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        CGPoint touchPoint = [touch locationInView:self.view];
        
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        bool pageFlag = [userDefaults boolForKey:@"pageDirectionRTLFlag"];
        NSLog(@"pageFlag tapbtnRight %d", pageFlag);
        
        if(self.interfaceOrientation==UIInterfaceOrientationPortrait||self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
            NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
            NSString *urlToSave = [webView stringByEvaluatingJavaScriptFromString:imgURL];
            NSLog(@"urlToSave :%@",urlToSave);
            NSURL * imageURL = [NSURL URLWithString:urlToSave];
            NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
            UIImage * image = [UIImage imageWithData:imageData];
            imgView.image = image;
            
            
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];//NSUserDefaultsを宣言
        
        NSData* jpgData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(image, 1.0f)];
            NSString* jpg64Str = [jpgData base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];//imageViewの画像を文字に変える
            
            NSLog(@"%@", jpg64Str);
            [ud setObject:jpg64Str forKey:@"KEY_3"];  // "jpg64Str"をKEY_3というキーで保存
            
   
            
        }
    }
    return YES;
}





@end
