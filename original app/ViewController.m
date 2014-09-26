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
}

-(void)viewWillAppear:(BOOL)animated {
    
    /*Core Dataからデータ読み出し Magical Recoordをつかって。
    result = [MyFashionData MR_findAll];
    
    NSLog(@"results count ==== %d", [result count]);
    
    //配列の中身をforループで読み出し、collection Viewを埋める
    for(id d in result) {
        MyFashionData *data = (MyFashionData *)d;
        //NSLog(@"%@ %@　%@",[data name], [data picture], [data url]);
    }
    [self.collectionView reloadData];*/
   
    

#pragma mark - yuma_fix
NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
NSData *data = [ud objectForKey:@"dataArray"];
array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
[self.collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView

{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //NSLog(@"how many items? %d", [result count]);
    //return [result count];
#pragma mark - yuma_fix
    return array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //_collectionView.scrollEnabled=YES;
    
    UICollectionViewCell *cell;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
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
    /*
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    // NSStringの読み込み試験
    NSString* string = [defaults stringForKey:@"title"];
    NSLog(@"タイトルは%@",string);
     */
    
    [self performSegueWithIdentifier:@"cellcolection"sender:self];
    
    
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

@end
