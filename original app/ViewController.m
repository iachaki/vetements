//
//  ViewController.m
//  original app
//
//  Created by ia on 2014/06/27.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//

#import "ViewController.h"
#import "WebItem.h"
#import "TutorialViewController.h"
#import "ClickHideView.h"
#import "UIView+Modal.h"

#define KEY @"dataArray"
#define PINK_COLOR [UIColor colorWithRed:231/255.0 green:101/255.0 blue:131/255.0 alpha:1.0f]


@interface ViewController ()<ClickHideViewDelegate>{
    NSString *selctedName;
    NSMutableArray *array;
    int editCount;
    NSMutableArray *deleteArray;
    BOOL flag;
}

@property (strong, nonatomic) ClickHideView*hideView;
@property  int firstCount;
@property (weak, nonatomic) UIView *overlayView;
@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSInteger* test = [defaults objectForKey:0];
//    if (test) {
//            NSLog(@"%@", test);
//    } else {
//        NSLog(@"%@", @"データが存在しません。");
//    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.firstCount = [defaults integerForKey:@"Clickcount"];
    if (self.firstCount == 0) {
        [self initHideView];
        self.firstCount = 1;
        [defaults setInteger:self.firstCount forKey:@"Clickcount"];
    }
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = YES;
    self.collectionView.userInteractionEnabled = YES;
    
    selectedId = 0;
    
    // 複数選択を許可する
    self.collectionView.allowsMultipleSelection = YES;
    deleteArray = [[NSMutableArray alloc]init];
    
    //MARK:logo
 [self setNavigationBarTitleImage:[UIImage imageNamed:@"vétements-logo2.png"]];
    
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"checkbox.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(doneDeleteView:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
#pragma mark - omatty tutorialView
//    UIView *subview = [[NSBundle mainBundle] loadNibNamed:@"TutorialView" owner:self options:nil][0];
//    subview.frame = CGRectMake(100, 100, 100, 100);
//    [self.view addSubview:subview];
}


- (void)viewDidDisappear:(BOOL)animated {
    //ビューが見えなくなったときに呼ばれる
    [self.collectionView reloadData];
    //uicollectionview 選択解除！！
}





- (void)initHideView
{
    self.hideView = [[ClickHideView alloc]init];
    self.hideView.delegate = self;
    self.hideView.alpha = 0;
    self.hideView.layer.cornerRadius = 5;
    self.hideView.clipsToBounds = true;
    
    
    CGRect tabFrame = self.hideView.frame;
    tabFrame.origin.y = CGRectGetHeight(self.view.frame) - tabFrame.size.height;
    self.hideView.frame = tabFrame;
    
    UIView *overlayView = [[UIView alloc] overlayView];
    [[overlayView myWindow] addSubview:overlayView];
    self.overlayView = overlayView;
    
    [self.overlayView addSubview:self.hideView];
    
    
    [UIView animateWithDuration:2.5 animations:^{
        self.hideView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
        }
    }];
}

- (void)hideView:(ClickHideView *)view pushedClickButton:(id)sender{
    [UIView animateWithDuration:2.5 animations:^{
        self.hideView.alpha = 0;
        self.overlayView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            self.hideView.hidden = YES;
            self.overlayView.hidden = YES;
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


-(void)viewWillAppear:(BOOL)animated{
#pragma mark - yuma_fix
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *data = [ud objectForKey:KEY];
    array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSLog(@"array == %@", array);
    [self.collectionView reloadData];
    
    UIBarButtonItem *dissmissButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"checkbox.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
     style:UIBarButtonItemStylePlain
     target:self
     action:@selector(editThisView:)];
     self.navigationItem.rightBarButtonItem = dissmissButton;
    
}

// 当画面から別画面遷移時
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // NavigationBar 表示
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView

{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
#pragma mark - yuma_fix
    return array.count;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIScreen *mainScreen = [UIScreen mainScreen];
    NSLog(@"Screen bounds: %@, Screen resolution: %@, scale: %f, nativeScale: %f",
          NSStringFromCGRect(mainScreen.bounds), mainScreen.coordinateSpace, mainScreen.scale, mainScreen.nativeScale);
    int width = mainScreen.bounds.size.width;
    return CGSizeMake(width/3, (float)(width/3)*1.5);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.0f, 0.0f, 8.0f, 15.0f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //_collectionView.scrollEnabled=YES;
    
    UICollectionViewCell *cell;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    /*
    CGRect cellRect = cell.bounds;
    
    cellRect.size.width = 106;
    cell.bounds = cellRect;
    */
    
    // 選択状態の UI を backgroundView に設定
    UIView *selectedView = [UIView new];
    selectedView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.7];
    cell.selectedBackgroundView = selectedView;
    
    [cell bringSubviewToFront:selectedView];
    
    
    
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    /*
    CGRect imageRect = imageView.bounds;
    imageRect.size.width = 106;
    imageView.bounds = imageRect;*/
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


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO:編集モード時に選択中かそうでないかを判定するコードを追加する必要あり
    if (editCount == 1) {
        NSLog(@"selected %d",(int)indexPath.row);
        [deleteArray addObject:[NSNumber numberWithInteger:(int)indexPath.row]];
        return;
    }
    
    NSLog(@"selected %d", (int)indexPath.row);
    selectedId = (int)indexPath.row;
    
    
    //detailViewに
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
    //画像を設定
   // UIImage *NavigationBarImage = [UIImage imageNamed:@"button-edit.png"];

       editCount = 1;
    
    //MARK:左のBarbuttonItem
   UIBarButtonItem *dissmissButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteCollectionView:)];
    self.navigationItem.leftBarButtonItem = dissmissButton;
    dissmissButton.tintColor = [UIColor colorWithRed:231/255.0 green:101/255.0 blue:131/255.0 alpha:1.0f];
    
    
    //MARK:右のBarbuttonItem(done)
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"done.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(doneDeleteView:)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)deleteCollectionView:(id)sender
{
    [self.collectionView reloadData];
    for (int i = 0; i < deleteArray.count; i++) {
        int deleteNumber = [[deleteArray objectAtIndex:i] intValue];
        [array removeObjectAtIndex:deleteNumber];
        
    }
    
    //UserDefaultも更新
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [ud setObject:data forKey:KEY];
    [ud synchronize];//即時保存
    
    [self.collectionView reloadData];
    deleteArray = nil;
    deleteArray = [[NSMutableArray alloc] init];
}

- (void)doneDeleteView:(id)sender
{
    //MARK:DeleteArrayを空にしてあげないと
    deleteArray = nil;
    deleteArray = [[NSMutableArray alloc] init];
    
    editCount = 0;
    
    //MARK:右のBarbuttonItem
    UIBarButtonItem *dissmissButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"checkbox.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(editThisView:)];
    self.navigationItem.rightBarButtonItem = dissmissButton;
    
    
    self.navigationItem.leftBarButtonItem = nil;
}

@end
