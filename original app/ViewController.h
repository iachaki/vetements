//
//  ViewController.h
//  original app
//
//  Created by ia on 2014/06/27.
//  Copyright (c) 2014年 Life is tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *strArray;
}

@property IBOutlet UICollectionView *collectionView;

@end
