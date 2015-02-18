//
//  WebViewController.m
//  original app
//
//  Created by ia on 2014/07/14.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//


#import "WebViewController.h"
#import "WebItem.h"
#import "UrlHideView.h"
#import "SaveHideView.h"


@interface WebViewController ()<UrlHideViewDelegate, SaveHideViewDelegate>
{
    AppDelegate *delegate;
    NSMutableArray *array;
}

@property (strong, nonatomic) UrlHideView *hideView;
@property (strong, nonatomic) SaveHideView *saveHideView;

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
    [self initSaveHideView];
    
    magicalContext=[NSManagedObjectContext MR_defaultContext];
    
    
    //ImageViewをボタンとして使えるようにした
    
    
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(push)];
    [imgView  addGestureRecognizer:tap];
    
    
#pragma mark yuma_fix
    if (!self.urlString) {
        self.urlString = @"http://cookpad.com/";
    }
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    //    delegate = [UIApplication sharedApplication].delegate;
    //    if (!delegate.dataArray) {
    //        delegate.dataArray = [NSMutableArray array];
    //    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *data = [ud objectForKey:@"dataArray"];
    array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (!array) {
        array = [NSMutableArray array];
    }

    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [webView loadRequest:req];
    
    UITapGestureRecognizer *gs = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapGesture:)];
    
    
    //gs.delegate = self;
    //gs.numberOfTapsRequired = 2;
    
    /* 長押し */
    UILongPressGestureRecognizer *longPressGesture =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPressGesture.minimumPressDuration = 1.0; //長押しの時間設定
    longPressGesture.allowableMovement = 10.0;//ロングタップ中に動いてもよいピクセル数,10秒
    longPressGesture.delegate = self;
    
    [webView addGestureRecognizer:longPressGesture];
    
    
    //UIWebViewのインスタンス化
    // CGRect rect = self.view.frame;
    // UIWebView *webView = [[UIWebView alloc]initWithFrame:rect];
    
    //Webページの大きさを自動的に画面にフィットさせる
    //webView.scalesPageToFit = YES;
    
    //デリゲートを指定
    //webView.delegate = self;
    
    //URLを指定
    //NSURL *url =[NSURL URLWithString:@"http://www.google.com"];
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //リクエストを投げる
    //[webView loadRequest:request];
    
    //UIWebViewのインスタンスをビューに追加
    //[self .view addSubview:webView];
    
    
}

- (void)initHideView
{
    self.hideView = [[UrlHideView alloc]init];
    self.hideView.delegate = self;
    self.hideView.alpha = 0;
    self.hideView.layer.cornerRadius = 5;
    self.hideView.clipsToBounds = true;
    
    
    CGRect tabFrame = self.hideView.frame;
    tabFrame.origin.y = CGRectGetHeight(self.view.frame) - tabFrame.size.height;
    self.hideView.frame = tabFrame;
    
    [self.view addSubview:self.hideView];
    
    
    [UIView animateWithDuration:2.5 animations:^{
        self.hideView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
        }
    }];
}

- (void)hideView:(UrlHideView *)view pushedUrlButton:(id)sender{
    [UIView animateWithDuration:2.5 animations:^{
        self.hideView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            self.hideView.hidden = YES;
        }
    }];
}

- (void)initSaveHideView
{
    self.saveHideView = [[SaveHideView alloc]init];
    self.saveHideView.delegate = self;
    self.saveHideView.alpha = 0;
    self.saveHideView.layer.cornerRadius = 5;
    self.saveHideView.clipsToBounds = true;
    
    
    CGRect tabFrame = self.saveHideView.frame;
    tabFrame.origin.y = CGRectGetHeight(self.view.frame) - tabFrame.size.height;
    self.saveHideView.frame = tabFrame;
    
    [self.view addSubview:self.saveHideView];
    
    
    [UIView animateWithDuration:2.5 animations:^{
        self.saveHideView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
        }
    }];
}

- (void)hideView:(SaveHideView *)view pushedSaveButton:(id)sender{
    [UIView animateWithDuration:2.5 animations:^{
        self.saveHideView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            self.saveHideView.hidden = YES;
        }
    }];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


- (void)longPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    NSLog(@"TAPPED");
    //Touch gestures below top bar should not make the page turn.
    //EDITED Check for only Tap here instead.
    
    NSLog(@"double tapped == %@", gestureRecognizer);

    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
        //Do Whatever You want on End of Gesture
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateBegan){
        NSLog(@"UIGestureRecognizerStateBegan.");
        //Do Whatever You want on Began of Gesture


    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        CGPoint touchPoint = [gestureRecognizer locationInView:self.view];
        
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
            
            NSData* jpgData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(image, 1.0f)];
            jpg64Str = [jpgData base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];//imageViewの画像を文字に変える
        
            //NSLog(@"%@", jpg64Str);
            
    if (![jpg64Str isEqualToString:@""]) {
                
                // Here we need to pass a full frame
                CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
                // Add some custom content to the alert view
                
                UIView *picView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 230, 280)];
                
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 210,260 )];
                
                
                
                [imageView setImage:image];
                [picView addSubview:imageView];
                
                [alertView setContainerView:picView];
                
                // Modify the parameters
                [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"保存", @"キャンセル", nil]];
                alertView.delegate = self;
                NSLog(@"%p", self);
                
                [alertView setUseMotionEffects:true];
                
                // And launch the dialog
                [alertView show];
                
                
            }
            
            
        }
    }

}
}

-(IBAction)push{
    // 1数行で書くタイプ（複数ボタンタイプ）
    
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"保存しますか？" message:@"確認"
                              delegate:self cancelButtonTitle:@"NO!" otherButtonTitles:@"YES!", nil];
    [alert show];
    
    
}

-(void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
    
    if (buttonIndex == 0) {
        
        /*MyFashionData *md = [MyFashionData MR_createEntity];
        md.timestampValue = 1;
        md.name =[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        md.picture = jpg64Str;
        md.url=[webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
        [magicalContext MR_saveOnlySelfAndWait];*/
        
        WebItem *item = [[WebItem alloc] init];
        item.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        item.urlString = [webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
        item.imageStr = jpg64Str;
        [array addObject:item];
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
        [ud setObject:data forKey:@"dataArray"];
        [ud synchronize];
    }
    [alertView close];
    [self initHideView];
}


- (IBAction)tapToTopButton:(id)sender {
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( buttonIndex != alertView.cancelButtonIndex )
    {
        // キャンセル以外がタップされた時の処理
        
        //NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];//NSUserDefaultsを宣言
        
        //画像をクリックして"画像"を取得するときに、一緒に"商品名"と"URL"の情報も取得できるようにした！
        //NSString* title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        //NSLog(@"%@",title);
        //[ud setObject:title forKey:@"KEY_1"];  // "title(商品名)"をKEY_1というキーで保存
        
        
        
        //NSString* url = [webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
        //NSLog(@"%@",url);
        
        //[ud setObject:url forKey:@"KEY_2"];  // "URL"をKEY_2というキーで保存
        
        //NSString *s = [ud stringForKey:@"KEY_1"];
        //NSLog(@"保存したタイトルは　%@",s);
        
        //[ud setObject:jpg64Str forKey:@"KEY_3"];  // "jpg64Str"をKEY_3というキーで保存
        
        
        
        
        
        
    }
}



@end
