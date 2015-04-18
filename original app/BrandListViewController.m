//
//  BrandListViewController.m
//  original
//
//  Created by ia on 2015/04/18.
//  Copyright (c) 2015年 Life is tech. All rights reserved.
//

#import "BrandListViewController.h"

@interface BrandListViewController ()
<UITableViewDataSource, UITableViewDelegate>

@end

@implementation BrandListViewController{
    IBOutlet UITableView *table;
    NSMutableArray *brandArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    table.dataSource = self;
    
    table.delegate = self;
    
    NSString *csvfile = [[NSBundle mainBundle] pathForResource:@"fashionbrand" ofType:@"csv"];
    NSData *csvData = [NSData dataWithContentsOfFile:csvfile];
    NSString *csv = [[NSString alloc] initWithData:csvData encoding:NSUTF8StringEncoding];
    
    NSArray *lines = [csv componentsSeparatedByString:@"\n"];

    if (!brandArray) {
        brandArray = [NSMutableArray new];
    }
    for (NSString *row in lines) {
        [brandArray addObject:row];
    }
    
    [table reloadData];
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return brandArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = brandArray[indexPath.row];
    
    return cell;
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
