//
//  SetUpTableViewController.m
//  要买车
//
//  Created by 王落凡 on 15/4/29.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "SetUpTableViewController.h"
#import "SetUpTableViewCell.h"

@interface SetUpTableViewController () {
    NSDictionary* optionDict;
}

@end

@implementation SetUpTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我的设置"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    optionDict=@{
                 @"0":@[@"header_set",@"头像",@"更改",@1],
                 @"1":@[@"login_set",@"登陆密码",@"修改",@1],
                 @"2":@[@"bind_set",@"已绑定手机号码186****1541",@"更改",@1],
                 @"3":@[@"about_set",@"关于",@"",@0],
                 @"4":@[@"logout_set",@"退出",@"",@0]
                 };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return optionDict.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetUpTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"SetUpCellIdentifier"];
    
    if(cell==nil)
        cell=[[SetUpTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SetUpCellIdentifier"];
    
    NSArray* contentArray=optionDict[[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    [cell.headerImageView setImage:[UIImage imageNamed:contentArray[0]]];
    [cell.setOptionLabel setText:contentArray[1]];
    [cell.changeOptionLabel setText:contentArray[2]];
    if([contentArray[3] intValue]==1)
       [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    else
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
