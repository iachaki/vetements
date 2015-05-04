//
//  BrandListViewController.m
//  original
//
//  Created by ia on 2015/04/18.
//  Copyright (c) 2015年 Life is tech. All rights reserved.
//

#import "BrandListViewController.h"

@interface BrandListViewController ()
<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *yumaArray;
    NSArray *webArray;
    //NSArray *array;
    NSMutableArray *brandnameArray;
    
    
}

@end

@implementation BrandListViewController{
//    IBOutlet UITableView *table;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    table.dataSource = self;
    
    table.delegate = self;
    
    NSString *csvfile2 = [[NSBundle mainBundle] pathForResource:@"fashionbrand1" ofType:@"csv"];
    NSData *csvData2 = [NSData dataWithContentsOfFile:csvfile2];
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

    //    for (NSString *row in lines) {
    //        [brandArray addObject:row];
    //
    //    }
    for (int i = 0; i < [matrics count]; i++) {
        NSArray *temp = [matrics objectAtIndex:i];//matricsのi番目を取り出す
        NSArray *data =[NSArray arrayWithArray:temp];//i番目を配列にする
        NSLog(@" brand = %@", [data objectAtIndex:0]);// 0番目の方(floatの方)を全部出力
        NSLog(@" url = %@", [data objectAtIndex:1]);
        [brandnameArray addObject:[data objectAtIndex:0]];
        NSLog(@"Count = %lu",(unsigned long)[brandnameArray count]);
    }

    for (int i = 0; i < brandnameArray.count; i++) {
        NSLog(@"なかみはああああああ%@",brandnameArray[i]);
    }
    
    [brandnameArray addObject:@"hello"];
   
    [table reloadData];
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return brandnameArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
     return 0;
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






#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
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
