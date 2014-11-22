//
//  ViewController.m
//  original app
//
//  Created by ia on 2014/06/27.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//

#import "ViewController.h"
#import "WebItem.h"

@interface ViewController (){
    NSString *selctedName;
    NSMutableArray *array;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = YES;
    self.collectionView.userInteractionEnabled = YES;
    
    selectedId = 0;
    
    // 複数選択を許可する
    self.collectionView.allowsMultipleSelection = YES;

}

-(void)viewWillAppear:(BOOL)animated {
    
        

#pragma mark - yuma_fix
NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
NSData *data = [ud objectForKey:@"dataArray"];
array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
[self.collectionView reloadData];
    
    UIBarButtonItem *dissmissButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editThisView:)];
    self.navigationItem.rightBarButtonItem = dissmissButton;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView

{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
#pragma mark - yuma_fix
    return array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //_collectionView.scrollEnabled=YES;
    
    UICollectionViewCell *cell;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    // 選択状態の UI を backgroundView に設定
    UIView *selectedView = [UIView new];
    selectedView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.8 alpha:1.0];
    cell.selectedBackgroundView = selectedView;
 

    
    

    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    //NSString *img = [[result objectAtIndex:[indexPath row]] picture];
#pragma mark - yuma_fix
    WebItem *item = array[indexPath.row];
    NSString *img = item.imageStr;
    
    //[NSString stringWithFormat:@"photo%d.jpg",(int)(indexPath.row+1)];
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:img
                                                       options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage* image = [UIImage imageWithData:data];
    
    imageView.image = image;
    
    
    
    UILabel*label = (UILabel *)[cell viewWithTag:2];
    label.text = [NSString stringWithFormat:@"No.%d",(int)(indexPath.row+1)];
    
    return cell;
    
    }


- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

   
    
   NSLog(@"selected %d", (int)indexPath.row);
    selectedId = (int)indexPath.row;
    
    
    detailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detailViewController"];
    
    WebItem *item = array[indexPath.row];
    detailVC.item = item;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:detailVC];
    [self presentViewController:nav animated:YES completion:nil];
    
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"cellcolection"])
    {
        // Get reference to the destination view controller
        
        detailViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.entryId = selectedId;
    }
}

- (void)editThisView:(id)sender
{
    editCount = 1;
}

@end
