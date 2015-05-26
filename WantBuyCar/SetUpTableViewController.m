//
//  SetUpTableViewController.m
//  要买车
//
//  Created by 王落凡 on 15/4/29.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "CLAlertView.h"
#import "NetworkingOperation.h"
#import "ConstantDef.h"
#import "SetUpTableViewController.h"
#import "SetUpTableViewCell.h"

@interface SetUpTableViewController () {
    NSDictionary* optionDict;
    CLAlertView* alertView;
}

@end

@implementation SetUpTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我的设置"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoRequestCompletionNotification:) name:kUserInfoRequestCompletionNotification object:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(leftButtonPressed:)];
    NSString* userToken = [[[NSUserDefaults standardUserDefaults] valueForKey:@"userToken"] stringValue];
    if(userToken!=nil)
        [NetworkingOperation sendPOSTRequestWithUrl:[NSString stringWithFormat:@"%@/getprofile",kUserApiUrl] params:@{@"usertoken":userToken} notificationName:kUserInfoRequestCompletionNotification];
    else {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
    return ;
}

-(void)leftButtonPressed:(UIBarButtonItem*)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    return ;
}

-(void)userInfoRequestCompletionNotification:(NSNotification*)notification {
    NSString* message = [notification.userInfo[@"message"] stringValue];
    if([message isEqualToString:@"ok"]) {
        
        NSString* imageUrl = [notification.userInfo[@"result"][@"photo"] stringValue];
        NSString* phone = [notification.userInfo[@"result"][@"phone"] stringValue];
        NSString* aPhone = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"*"];
        
        optionDict=@{
                     @"0":@[imageUrl,@"头像",@"更改",@1],
                     @"1":@[@"login_set",@"登陆密码",@"修改",@1],
                     @"2":@[@"bind_set",[NSString stringWithFormat:@"已绑定手机号码%@",aPhone],@"更改",@1],
                     @"3":@[@"about_set",@"关于",@"",@0],
                     @"4":@[@"logout_set",@"退出",@"",@0]
                     };
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
    return ;
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

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
