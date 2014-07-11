//
//  WebViewController.m
//  original app
//
//  Created by ia on 2014/07/04.
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
	
    //UIWebViewのインスタンス化
//    CGRect rect = self.view.frame;
//    UIWebView *webView = [[UIWebView alloc]initWithFrame:rect];
    
    //Webページの大きさを自動的に画面にフィットさせる
    //webView.scalesPageToFit = YES;
    
    //デリゲートを指定
    //webView.delegate = self;
    
    //URLを指定
    NSURL *url =[NSURL URLWithString:@"http://www.google.com"];
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
    NSString* title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //NSLog(@"%@",title);
    label.text=[NSString stringWithFormat:@"%@",title];
    
    NSString* url = [webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
//NSLog(@"%@",url);
label2.text=[NSString stringWithFormat:@"%@",url];
}


@end
