//
//  TableViewController.m
//  original app
//
//  Created by ia on 2014/09/05.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//

#import "TableViewController.h"
#import "WebViewController.h"

#pragma mark - yuma_fix
#import "WebItem.h"
#import "AppDelegate.h"
#import "TutorialView.h"

@interface TableViewController ()<TutorialViewDelegate>
{
    NSMutableArray *yumaArray;
    NSArray *webArray;
    //NSArray *array;
    
}
@property (strong, nonatomic) TutorialView *hideView;
@property  int firstCount;
@end

@implementation TableViewController

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
    
//    yumaArray = [NSMutableArray array];
    
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
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *array = [userDefault dataForKey:@"webSite"];
    if ([[NSString alloc] initWithData:array encoding:NSUTF8StringEncoding]) {
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

}

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
    
    [self.view addSubview:self.hideView];
    
    
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
    } completion:^(BOOL finished) {
        if (finished) {
            self.hideView.hidden = YES;
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

/*-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //先にデータソースを削除する
    [yumaArray removeObjectAtIndex:indexPath.row];
    
    NSArray *deleteArray = [NSArray arrayWithObject:indexPath];
    //UITableViewの行を消去する
    [tableView deleteRowsAtIndexPaths:deleteArray withRowAnimation:UITableViewRowAnimationAutomatic];

}*/




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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return yumaArray.count;//列の数
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
       // Configure the cell...
    // cell.contentView.backgroundColor = [UIColor redColor];
    
#pragma mark yuma_fix
    WebItem *item = yumaArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", item.title];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WebController"];
    
#pragma mark yuma_fix
    WebItem *item = yumaArray[indexPath.row];
    vc.urlString = item.urlString;
    
    self.tabBarController.tabBar.hidden= YES;
    [self.navigationController pushViewController:vc animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
                        
