//
//  NewestHeaderView.m
//  要买车
//
//  Created by 王落凡 on 15/5/5.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "ConstantDef.h"
#import "NewestHeaderView.h"
#import "HeaderSimpleTableViewCell.h"

@interface NewestHeaderView ()<UITableViewDataSource,UITableViewDelegate> {
    BOOL bExpand;
}

@end

@implementation NewestHeaderView

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [UIView animateWithDuration:kMovingInterval animations:^{
        [self.seperatorView setFrame:CGRectMake(0, self.frame.size.height-30.5f, self.frame.size.width, 0.5f)];
        [self.commentLabel setFrame:CGRectMake(10, self.frame.size.height-25, self.frame.size.width, 20)];
        [self.expandButton setFrame:CGRectMake(self.expandButton.frame.origin.x, self.seperatorView.frame.origin.y-self.expandButton.frame.size.height, self.expandButton.frame.size.width, self.expandButton.frame.size.height)];
    }];
    
    return ;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
        bExpand = YES;
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setMasksToBounds:YES];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -kBaseHeight, self.bounds.size.width, self.bounds.size.height)];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView setTableHeaderView:nil];
        [self addSubview:self.tableView];
        
        self.seperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-30.5f, self.frame.size.width, 0.5f)];
        [self.seperatorView setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:self.seperatorView];
        
        self.commentLabel= [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height - 25, self.frame.size.width, 20)];
        [self.commentLabel setTextColor:[UIColor lightGrayColor]];
        [self.commentLabel setText:@"最新评论"];
        [self.commentLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self addSubview:self.commentLabel];
        
        self.expandButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.expandButton setTitle:@"展开报价" forState:UIControlStateNormal];
        [self.expandButton.titleLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [self.expandButton setImage:[UIImage imageNamed:@"zhankai"] forState:UIControlStateNormal];
        [self.expandButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.expandButton setImageEdgeInsets:UIEdgeInsetsMake(6, 0, 5, 15)];
        [self.expandButton setFrame:CGRectMake(0, self.seperatorView.frame.origin.y-20, 100, 20)];
        [self.expandButton setCenter:CGPointMake(self.frame.size.width/2, self.expandButton.center.y)];
        [self.expandButton addTarget:self action:@selector(expandButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.expandButton setBackgroundImage:[[UIImage imageNamed:@"expand"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 6, 6)] forState:UIControlStateNormal];
        [self addSubview:self.expandButton];
    }
    
    return self;
}

-(void)expandButtonPressed:(UIButton*)sender {
    UITableView* tableView = nil;
    
    for(UIView* view in self.superview.subviews) {
        if([view isKindOfClass:[UITableView class]])
            tableView = (UITableView*)view;
    }
    
    if(bExpand) {
        [UIView animateWithDuration:kMovingInterval animations:^{
            [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+20)];
            [tableView setFrame:CGRectMake(tableView.frame.origin.x, self.frame.origin.y + self.frame.size.height, tableView.frame.size.width, tableView.frame.size.height - 20)];
        }completion:^(BOOL finished) {
            
            [self.expandButton setTitle:@"精简报价" forState:UIControlStateNormal];
            [self.expandButton setImage:[UIImage imageNamed:@"shousuo"] forState:UIControlStateNormal];
            
            bExpand = NO;
        }];
    }else {
        [UIView animateWithDuration:kMovingInterval animations:^{
            [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height-20)];
            [tableView setFrame:CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y-20, tableView.frame.size.width, tableView.frame.size.height + 20)];
        }completion:^(BOOL finished) {
            
            [self.expandButton setTitle:@"展开报价" forState:UIControlStateNormal];
            [self.expandButton setImage:[UIImage imageNamed:@"zhankai"] forState:UIControlStateNormal];
            
            bExpand = YES;
            
        }];
    }
    return ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HeaderSimpleTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleCellIdentifier"];
    if(cell ==nil )
        cell = [[HeaderSimpleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SimpleCellIdentifier"];
    
    [cell.headerImageView setImage:[UIImage imageNamed:@"liaottx"]];
    [cell.vehicleInfoLabel setText:@"奔驰（C级）2014款C200 Coupe"];
    [cell addDescribeInfo:@"GPS导航"];
    [cell addDescribeInfo:@"真皮坐椅"];
    [cell addDescribeInfo:@"天窗"];
    [cell addDescribeInfo:@"大奔驰"];
    [cell addDescribeInfo:@"给力"];
    [cell addDescribeInfo:@"牛逼"];
    
    [cell addOfferInfoWithCount:3 price:52.88];
    
    [cell.dateLabel setText:@"09:44"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
