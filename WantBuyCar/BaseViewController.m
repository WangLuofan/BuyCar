//
//  BaseViewController.m
//  要买车
//
//  Created by 王落凡 on 15/5/4.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "ConstantDef.h"
#import "FilterView.h"
#import "BaseViewController.h"

@implementation BaseViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    //筛选View
    FilterView* filterView=[[FilterView alloc] initWithFrame:CGRectMake(0, kBaseHeight, self.view.bounds.size.width, kFilterHeight)];
    [self.view addSubview:filterView];
    
    //表
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, kBaseHeight+kFilterHeight, self.view.bounds.size.width, self.view.bounds.size.height-kBaseHeight-kTabViewHeight-kFilterHeight) style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    
    return ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
