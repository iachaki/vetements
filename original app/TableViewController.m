//
//  TableViewController.m
//  original app
//
//  Created by ia on 2014/09/05.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//

#import "TableViewController.h"
#import "WebViewController.h"
#import <Foundation/Foundation.h>

#pragma mark - yuma_fix
#import "WebItem.h"
#import "AppDelegate.h"
#import "TutorialView.h"
#import "UIView+Modal.h"//


@interface TableViewController ()<TutorialViewDelegate>
{
    NSMutableArray *yumaArray;
    NSArray *webArray;
    //NSArray *array;
    NSMutableArray *brandnameArray;
    NSMutableArray *brandurlArray;
    NSString *url;
}
@property (strong, nonatomic) TutorialView *hideView;
@property  int firstCount;
@property (weak, nonatomic) UIView *overlayView;//
@end

@implementation TableViewController{
    NSMutableArray *brandArray;
//    NSMutableArray *brandnameArray;
    NSArray *lines;
     UITableView *table;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    table.dataSource = self;
    
    table.delegate = self;
    
    brandnameArray = [NSMutableArray array];
    brandurlArray = [NSMutableArray array];
    
    //ブランド一覧を入れるための配列をつくる
//    yumaArray = [NSMutableArray array];
    
    /* == ファッションブランド一覧のCSVをデータに直してNSArrayに順番付きで保存 == */
    // UTF8 エンコードされた CSV ファイル
    /* ここから
    NSString *filePath = @"fashion brand.csv";
    NSString *text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    ここまで */
//    NSString *text = [[NSBundle mainBundle] pathForResource:csvFileName ofType:@"fashion brand.csv"];
//    NSData *csvData = [NSData dataWithContentsOfFile:csvFile];
//    NSString *csv = [[NSString alloc] initWithData:csvData encoding:NSUTF8StringEncoding];
    NSString *csvFile2 = [[NSBundle mainBundle] pathForResource:@"fashionbrand1" ofType:@"csv"];
    NSData *csvData2 = [NSData dataWithContentsOfFile:csvFile2];
    NSString *csv2 = [[NSString alloc] initWithData:csvData2 encoding:NSUTF8StringEncoding];
    
    // 改行文字で区切って配列に格納する
    NSArray *lines = [csv2 componentsSeparatedByString:@"\n"];
    NSLog(@"Count = %d",[lines count]);
    NSString *obj;
    NSArray *items;
    NSMutableArray *matrics; // 保管する配列
    matrics = [[NSMutableArray alloc]initWithCapacity:1];
    for(obj in lines){
        items =[obj componentsSeparatedByString:@","]; //コンマごとに区切る
        [matrics addObject:items]; // matrics に入れる。
        
        
    }
//    if (!brandnameArray) {
//        brandnameArray = [NSMutableArray new];
//    }

    for (int i = 0; i < [matrics count]; i++) {
        NSArray *temp = [matrics objectAtIndex:i];//matricsのi番目を取り出す
        NSArray *data =[NSArray arrayWithArray:temp];//i番目を配列にする
        NSLog(@" brand = %@", [data objectAtIndex:0]);// 0番目の方(floatの方)を全部出力
        NSLog(@" url = %@", [data objectAtIndex:1]);
        
        NSString *text = [data objectAtIndex:0] ;
        
        //brandnamearrrayにうまくはいっていない
        [brandnameArray addObject:text]; //[data objectAtIndex:0]];
        NSLog(@"ぶらんどかぞえると = %lu",(unsigned long)[brandnameArray count]);
        [brandurlArray addObject:[data objectAtIndex:1]]; //[data objectAtIndex:0]];
    }
    
    for (int i = 0; i < brandnameArray.count; i++){
        NSLog(@"なかみはああああああ%@",brandnameArray[i]);
         NSLog(@"URLLLLLL%@",brandurlArray[i]);
    }


    //ex) [brandnameArray addObject:@"hello"];
  
}

//    [table reloadData];

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return brandnameArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = brandnameArray[indexPath.row];
    
    return cell;
}


//
//UISearchBar *sb = [[[UISearchBar alloc] init] autorelease];
//sb.delegate = self;
//sb.showsCancelButton = YES;


    //NSLog(@"csv == %@", csv);
    
    // 改行文字で区切って配列に格納する
  
    //NSLog(@"lines count: %ld", lines.count);    // 行数






/*

    
    UIBarButtonItem *addLinkButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"plus.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(addLinkButtonTap)];
    self.navigationItem.rightBarButtonItem = addLinkButton;
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f];
    //タブ選択時のフォントとカラー
    NSDictionary *selectedAttributes = @{NSFontAttributeName : font,
                                         NSForegroundColorAttributeName : [UIColor redColor]};
    
    [[UITabBarItem appearance] setTitleTextAttributes:selectedAttributes
                                             forState:UIControlStateSelected];
    
    //通常時のフォントとカラー
    NSDictionary *attributesNormal = @{NSFontAttributeName : font,
                                       NSForegroundColorAttributeName : [UIColor blueColor]};
    
    [[UITabBarItem appearance] setTitleTextAttributes:attributesNormal
                                             forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.tabBarController.tabBar.hidden == YES) {//もしtabBarController.tabBar.hiddenがYESだったら
        self.tabBarController.tabBar.hidden = NO;//tabBarController.tabBar.hiddenをNOにする
    }
    
    
    
    */
    
    
    
    
    /*
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *array = [userDefault dataForKey:@"webSite"];
//    if ([[NSString alloc] initWithData:array encoding:NSUTF8StringEncoding]) {
    if (array) {
        yumaArray = [NSKeyedUnarchiver unarchiveObjectWithData:array];
        NSLog(@"%@",array);
    } else {
        NSLog(@"%@",array);
        
    }
    
    if (yumaArray.count <=7) {
        
        NSData *data =[NSKeyedArchiver archivedDataWithRootObject:yumaArray];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:data forKey:@"webSite"];
        
        //MARK:logo
        [self setNavigationBarTitleImage:[UIImage imageNamed:@"vétements-logo2.png"]];
        
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.firstCount = [defaults integerForKey:@"Pluscount"];
    if (self.firstCount == 0) {
        [self initHideView];
        self.firstCount = 1;
        [defaults setInteger:self.firstCount forKey:@"Pluscount"];
    }
 

}*/

- (void)initHideView
{
    self.hideView = [[TutorialView alloc]init];
    self.hideView.delegate = self;
    self.hideView.alpha = 0;
    self.hideView.layer.cornerRadius = 5;
    self.hideView.clipsToBounds = true;
    
    
    CGRect tabFrame = self.hideView.frame;
    tabFrame.origin.y = CGRectGetHeight(self.view.frame) - tabFrame.size.height;
    self.hideView.frame = tabFrame;
    
    UIView *overlayView = [[UIView alloc] overlayView];//
    [[overlayView myWindow] addSubview:overlayView];//
    self.overlayView = overlayView;//
    
    [self.overlayView addSubview:self.hideView];//
    
    [UIView animateWithDuration:2.5 animations:^{
        self.hideView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
        }
    }];
}

- (void)hideView:(TutorialView *)view pushedWebButton:(id)sender{
    [UIView animateWithDuration:2.5 animations:^{
        self.hideView.alpha = 0;
        self.overlayView.alpha = 0;//
    } completion:^(BOOL finished) {
        if (finished) {
            self.hideView.hidden = YES;
            self.overlayView.hidden = YES;//
        }
    }];
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

/*
-(IBAction)addLinkButtonTap{
    //アラートを表示す
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Enter File Details"
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Add", nil];
    
    [message setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    UITextField *fileDescription = [message textFieldAtIndex:0];
    fileDescription.placeholder=@"title";
    [[message textFieldAtIndex:1]setSecureTextEntry:NO];
    UITextField *fileName= [message textFieldAtIndex:1];
    fileName.placeholder=@"url";
    
    [message show];
}
*/

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *titleStr = [[alertView textFieldAtIndex:0] text];
        NSString *urlStr = [[alertView textFieldAtIndex:1] text];
        
        WebItem *item = [[WebItem alloc] init];
        item.title = titleStr;
        item.urlString = urlStr;
        [yumaArray addObject:item];
        [self.tableView reloadData];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:yumaArray];
        //NSData *data [NSKeyedArchived archievedDataWithRootObject:yumaArray];//archieved
        NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
        [defaults setObject:data forKey:@"webSite"];
        [defaults synchronize]; // 即時保存(UserDefaultsは、すぐに保存されない)
        
        NSLog(@"%@", [defaults objectForKey:@"webSite"]);
    }
}





-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //先にデータソースを削除する
    [yumaArray removeObjectAtIndex:indexPath.row];
    
    NSArray *deleteArray = [NSArray arrayWithObject:indexPath];
    //UITableViewの行を消去する
    [tableView deleteRowsAtIndexPaths:deleteArray withRowAnimation:UITableViewRowAnimationAutomatic];

}








- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

//TableViewのcellをdelete
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [yumaArray removeObjectAtIndex:indexPath.row];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:yumaArray];
        //NSData *data [NSKeyedArchived archievedDataWithRootObject:yumaArray];//archieved
        NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
        [defaults setObject:data forKey:@"webSite"];
        [userDefaults synchronize]; // 即時保存(UserDefaultsは、すぐに保存されない)
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //選択されたURLを画面遷移先に送る
    NSLog(@"%d番目を選択したよ",indexPath.row);
    
    
    //画面遷移をする
    url = @"はろはおr−";
    WebViewController* urlVC;
    urlVC = [[WebViewController alloc] initWithNibName:nil bundle:nil];
    // 遷移前のクラスの変数であるurlの値を、
    // 遷移後のクラス(SecondViewController)の変数であるurlに渡す
    urlVC.urlString = brandurlArray[indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

//    UINavigationController *webvc = [storyboard instantiateViewControllerWithIdentifier:@"WebController"];
    
    WebViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"WebController"];
    
    
#pragma mark yuma_fix
//    WebItem *item = yumaArray[indexPath.row];
//    vc.urlString = item.urlString;

    
    self.tabBarController.tabBar.hidden= YES;

    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"websegue" sender:self];
    
//        [self.navigationController pushViewController:webvc animated:YES];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"websegue"]) {
        WebViewController *vcntl = [segue destinationViewController];    // <- 1
        vcntl.urlString = brandurlArray[self.tableView.indexPathForSelectedRow.row];    // <- 2
    }
}





/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 //セル選択状態の解除
 [tableView deselectRowAtIndexPath:indexPath animated:YES];
 //ここにやりたいことを書く
 NSURL *url = [NSURL URLWithString:@"http://cookpad.com/"];
 }
 */







/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

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
                        
