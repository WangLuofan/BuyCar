//
//  QueryTableViewController.m
//  要买车
//
//  Created by 王落凡 on 15/5/5.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "QueryTableViewCell.h"
#import "QueryTableViewController.h"

@interface QueryTableViewController ()<QueryTableViewCellDelegate> {
    NSMutableArray* cellButtonArray;
}

@end

@implementation QueryTableViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    return ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QueryTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"QueryCellIdentifier"];
    if(cell==nil)
        cell=[[QueryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QueryCellIdentifier"];
    [cell.textLabel setText:@"2015款SportBack 35 TSFI 手动进取型"];
    
    return cell;
}

-(void)queryButtonPressed:(UIButton *)sender {
    return ;
}

@end
