//
//  detailViewController.m
//  original app
//
//  Created by ia on 2014/08/04.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//

#import "detailViewController.h"
#import "MyFashionData.h"

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
    
    // 全テキストフィールドのdelegateにselfを代入
    // ※テキストフィールドをメンバ変数に入れている場合は、それぞれのテキストフィールドに対して、変数名.delegate = self;とすればいい。
    for (id v in self.view.subviews) {
        if([NSStringFromClass([v class]) isEqualToString:@"UITextField"]){
            ((UITextField*)v).delegate = self;
        }
    }
}
    -(void)keyboardWillShow:(NSNotification*)note
    {
        // キーボードの表示完了時の場所と大きさを取得。
        CGRect keyboardFrameEnd = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        float screenHeight = screenBounds.size.height;
        
        if((activeField.frame.origin.y + activeField.frame.size.height)>(screenHeight - keyboardFrameEnd.size.height - 20)){
            // テキストフィールドがキーボードで隠れるようなら
            // 選択中のテキストフィールドの直ぐ下にキーボードの上端が付くように、スクロールビューの位置を上げる
            [UIView animateWithDuration:0.3
                             animations:^{
                                 scrollView.frame = CGRectMake(0, screenHeight - activeField.frame.origin.y - activeField.frame.size.height - keyboardFrameEnd.size.height - 20, scrollView.frame.size.width,scrollView.frame.size.height);
                             }];
        }
        
    }
    
    - (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
        // メンバ変数activeFieldに選択されたテキストフィールドを代入
        activeField = textField;
        return YES;
    }
    
    - (BOOL)textFieldShouldReturn:(UITextField *)textField{
        // viewのy座標を元に戻してキーボードをしまう
        [UIView animateWithDuration:0.2
            animations:^{
                scrollView.frame = CGRectMake(0, 0, scrollView.frame.size.width,scrollView.frame.size.height);
                         }];
        
        [textField resignFirstResponder];
        return YES;
    }
    


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
//    NSArray *result = [MyFashionData MR_findAll];
//    MyFashionData *data = [result objectAtIndex:_entryId];
    
     
    //NSString *title  = [data name];  // nameの情報を取得
    titleLabel.text=[NSString stringWithFormat:@"%@",self.item.title];//labelに表示
    
    //url  = [data url];  //urlの情報を取得
    urlLabel.text=[NSString stringWithFormat:@"%@",self.item.urlString];//labelに表示
    
    url = self.item.urlString;
    
    [urlbtn setTitle:url forState:UIControlStateNormal];
    
    

    //NSString *jpg64Str = [data picture];//pictureの情報を取得
//    NSData *jpgData = [[NSData alloc] initWithBase64EncodedString:jpg64Str
//                                                          options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSString *img = self.item.imageStr;
    
    //[NSString stringWithFormat:@"photo%d.jpg",(int)(indexPath.row+1)];
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:img
                                                       options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage* image = [UIImage imageWithData:data];
    
    imgView.image = image;
    
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"menu" style:UIBarButtonItemStylePlain target:self action:@selector(menuback)];
    self.navigationItem.leftBarButtonItem = button;
}

-(IBAction)openurl{//urlをopenする
    
    
    
    NSString *urlString = url;
    NSURL *nsurl = [NSURL URLWithString:urlString];
    
    // ブラウザを起動する
    [[UIApplication sharedApplication] openURL:nsurl];
    
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

-(IBAction)menuback{//menuへ戻る
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
