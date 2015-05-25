//
//  OfferViewController.m
//  要买车
//
//  Created by 王落凡 on 15/5/4.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "ConstantDef.h"
#import "FilterView.h"
#import "OfferAlertView.h"
#import "OfferTableViewCell.h"
#import "OfferViewController.h"
#import "NetworkingOperation.h"

@interface OfferViewController ()<OfferTableViewCellDelegate,CLAlertViewDelegate> {
    UIView* tableFooterView;
    OfferAlertView* offerAlertView;
    CLAlertView* attentionAlertView;
}

@end

@implementation OfferViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"我要报价"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self addOfferButton];
    
    return ;
}

-(void)requestCompletionNotification:(NSNotification*)notification {
    NSLog(@"%@",notification.userInfo);
    return ;
}

-(void)dealloc {
    return ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OfferTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OfferCellIdentifier"];
    if(cell==nil)
        cell=[[OfferTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OfferCellIdentifier"];
    [cell setDelegate:self];
    [cell.vehicleImageView setImage:[UIImage imageNamed:@"image1"]];
    [cell.userLabel setText:@"刘先生想买"];
    [cell.infoLabel setText:@"昂科雷（进口）09款 旗舰版"];
    [cell setPrice:@"388.88-488.88万"];
    [cell.dateLabel setText:@"09:55"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(void)addOfferButton {
    tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(20, 30, kScreenWidth-40, 40)];
    [button setTitle:@"一键报价" forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:@"buttonBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 21, 21) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(allOfferButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [tableFooterView addSubview:button];
    
    [self.tableView setTableFooterView:tableFooterView];
    return ;
}

-(void)allOfferButtonPressed:(UIButton*)sender {
    return ;
}

-(void)offerButtonPressed {
    offerAlertView=[[OfferAlertView alloc] initWithTitle:@"我要报价" frame:CGRectMake(0,0,250,250) message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [offerAlertView show];
    return ;
}

-(void)addAttentionButtonPressed {
    attentionAlertView=[[CLAlertView alloc] initWithTitle:@"添加关注" frame:CGRectMake(0,0,250,200) message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    NSString* tmpString=@"您确定关注刘先生吗?";
    NSMutableAttributedString* attributedString=[[NSMutableAttributedString alloc] initWithString:tmpString];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(5, 3)];
    [attentionAlertView addAttributedMessage:[attributedString copy]];
    
    [attentionAlertView show];
}

-(void)alertView:(CLAlertView *)alertView buttonPressedIndex:(NSInteger)buttonPressedIndex {
    if([alertView isKindOfClass:[OfferAlertView class]]) {
    }
    return ;
}

@end
