//
//  ChatRecordViewController.m
//  要买车
//
//  Created by 王落凡 on 15/4/28.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "ConstantDef.h"
#import "ChatRecordViewController.h"
#import "CLNavigationViewController.h"
#import "ChatRecordTableViewCell.h"
#import "ChatTableViewController.h"

@interface ChatRecordViewController ()<UITableViewDataSource,UITableViewDelegate> {
    UISearchController* searchController;
    UISearchBar* searchBar;
}

@end

@implementation ChatRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"聊天记录"];
    
    //顶部条
    UIView* searchView = [[UIView alloc] initWithFrame:CGRectMake(0, kBaseHeight, self.view.frame.size.width, kTabViewHeight)];
    [searchView setBackgroundColor:[UIColor colorWithRed:0.910f green:0.914f blue:0.910f alpha:1.0f]];
    [searchView.layer setShadowOffset:CGSizeMake(0, 2)];
    [searchView.layer setShadowOpacity:0.3f];
    [searchView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchesBackGround)]];
    [self.view addSubview:searchView];

//    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setFrame:CGRectMake(100, 100, 50, 30)];
//    [button setBackgroundColor:[UIColor orangeColor]];
//    [button setTitle:@"测试" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
    //搜索栏
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 5, searchView.frame.size.width-40, searchView.frame.size.height-10)];
    [searchBar setPlaceholder:@"搜索"];
    [searchBar setBackgroundImage:[[UIImage imageNamed:@"search"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 25, 26, 26)]];
    [searchView addSubview:searchBar];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kBaseHeight+kTabViewHeight, self.view.frame.size.width, self.view.frame.size.height - kBaseHeight - 2*kTabViewHeight)];
//    [self.tableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchesBackGround)]];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
}

-(void)touchesBackGround {
    [searchBar resignFirstResponder];
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
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatRecordTableViewCell* cell =  [tableView dequeueReusableCellWithIdentifier:@"RecordCellIdentifier"];
    
    if(cell == nil)
        cell = [[ChatRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecordCellIdentifier"];
    
    [cell.headerImage setImage:[UIImage imageNamed:@"liaottx"]];
    [cell.userInfoLabel setText:@"湖南力天汽车集团有限公司"];
    [cell.vehicleInfoLabel setText:@"经营品牌:奔驰"];
    [cell.phoneNumberInfoLabel setText:@"电话号码:0731-8885326"];
    [cell.dateInfoLabel setText:@"03:07 12:00"];
    
    return cell ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self presentViewController:[[CLNavigationViewController alloc] initWithRootViewController:[[ChatTableViewController alloc] init]] animated:YES completion:^{
    }];
    return ;
}

@end
