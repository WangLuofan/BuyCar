//
//  NewestViewController.m
//  要买车
//
//  Created by 王落凡 on 15/5/5.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "ConstantDef.h"
#import "NewestAlertView.h"
#import "NewestHeaderView.h"
#import "CommentTableViewCell.h"
#import "NewestViewController.h"

#import "UserComment.h"

@interface NewestViewController ()<CLAlertViewDelegate,UITableViewDataSource,UITableViewDelegate> {
    NewestAlertView* newestAlertView;
    NewestHeaderView* newestHeaderView;
    NSMutableArray* tableCellArray;
}

@end

@implementation NewestViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"最新动态"];
    //表格头部
    newestHeaderView= [[NewestHeaderView alloc] initWithFrame:CGRectMake(0,kBaseHeight,self.view.frame.size.width,130)];
    [self.view addSubview:newestHeaderView];
    
//    //评论表格
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, newestHeaderView.frame.origin.y+newestHeaderView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - newestHeaderView.frame.origin.y-newestHeaderView.frame.size.height) style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    
    //评论按钮
    self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commentButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    [self.commentButton setFrame:CGRectMake(kScreenWidth-50, kScreenHeight-50, 40, 40)];
    [self.commentButton addTarget:self action:@selector(commentButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commentButton];
    
    tableCellArray = [[NSMutableArray alloc] init];
    [self decodeCommentProperty];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(leftButtonPressed:)];
    
    return;
}

-(void)leftButtonPressed:(UIBarButtonItem*)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    return ;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)decodeCommentProperty {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"TestComment" ofType:@"plist"];
    NSArray* array=[NSArray arrayWithContentsOfFile:filePath];
    
    [tableCellArray removeAllObjects];
    
    for (int i=0;i!=array.count;++i) {
        CommentTableViewCell* cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommentCellIdentifier"];
        [cell.headerImage setImage:[UIImage imageNamed:@"liaottx"]];
        [cell.usernameLabel setText:array[i][@"UserName"]];
        [cell.commentLabel setText:array[i][@"Comment"]];
        [cell.commentLabel sizeToFit];
        [cell.attendLabel setText:array[i][@"AttendCount"]];
        [tableCellArray addObject:cell];
    }
    
    return ;
}

-(void)commentButtonPressed:(UIButton*)sender {
    if(newestAlertView==nil)
        newestAlertView = [[NewestAlertView alloc] initWithTitle:@"发起评论" frame:CGRectMake(0,0,250,250) message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [newestAlertView show];
    
    return ;
}

-(void)sendCommentWithContents:(NSString*)contents attendCount:(NSInteger)attendCount {
    CommentTableViewCell* cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommentCellIdentifier"];
    
    [cell.headerImage setImage:[UIImage imageNamed:@"liaottx"]];
    [cell.usernameLabel setText:@"wangluofan"];
    [cell.commentLabel setText:contents];
    [cell.commentLabel sizeToFit];
    [cell.attendLabel setText:[NSString stringWithFormat:@"%ld人参与",(long)attendCount]];
    [tableCellArray insertObject:cell atIndex:0];
    [self.tableView reloadData];
    
    return ;
}

-(void)alertView:(CLAlertView *)alertView buttonPressedIndex:(NSInteger)buttonPressedIndex {
    if(buttonPressedIndex == 1) {
        [alertView dismiss];
        [self sendCommentWithContents:((NewestAlertView*)alertView).textView.text attendCount:15];
    }
    return ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableCellArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewCell* cell = (CommentTableViewCell*)tableCellArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewCell* cell = (CommentTableViewCell*)tableCellArray[indexPath.row] ;
    return [cell cellHeight];
}

@end
