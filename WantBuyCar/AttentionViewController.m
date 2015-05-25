//
//  AttentionViewController.m
//  要买车
//
//  Created by 王落凡 on 15/4/28.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "AttentionViewController.h"
#import "AttentionTableViewCell.h"
#import "ConstantDef.h"
#import "FilterView.h"
#import "CommAlgorithm.h"

@interface AttentionViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation AttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我的关注"];
    
    return ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AttentionTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"AttentionCellIdentifier"];
    if(cell==nil) {
        cell=[[AttentionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AttentionCellIdentifier"];
    }
    [cell.headerImageView setImage:[UIImage imageNamed:@"liaottx"]];
    [cell.nameInfoLabel setText:@"轻舞飞扬-刘小姐"];
    [cell.carInfoLabel setText:@"昂科雷（进口）09款 旗舰版"];
    [cell.priceInfoLabel setText:@"25万"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end