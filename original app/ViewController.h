//
//  ViewController.h
//  original app
//
//  Created by ia on 2014/06/27.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyFashionData.h"
#import "detailViewController.h"
#import "GAI.h"



@interface ViewController : GAITrackedViewController <UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *result;
    int selectedId;
}

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

/*@interface CollectionViewController : UICollectionViewController<UICollectionViewDataSource,UICollectionViewDelegate>
 @property (strong, nonatomic) IBOutlet UICollectionView *collectionView;*/



@end
