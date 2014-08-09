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

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *result;
    int selectedId;
}

@property IBOutlet UICollectionView *collectionView;

@end
