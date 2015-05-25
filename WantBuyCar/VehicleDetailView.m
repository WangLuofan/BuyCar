//
//  VehicleDetailView.m
//  要买车
//
//  Created by 王落凡 on 15/4/30.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "VehicleDetailView.h"
#import "CLSegmentedControl.h"
#import "NetworkingOperation.h"
#import "SUBBrandQueryModel.h"
#import "UIImageView+WebCache.h"
#import "ConstantDef.h"

@interface VehicleDetailView ()<UITableViewDataSource,UITableViewDelegate,CLSegmentedControlDelegate>{
    UISwipeGestureRecognizer* swipeGesture;
    NSArray* dataSourceArray;
}

@end

@implementation VehicleDetailView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
        [self.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.layer setBorderWidth:0.4f];
        
        swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureHandle:)];
        [swipeGesture setDirection:UISwipeGestureRecognizerDirectionRight];
        [self addGestureRecognizer:swipeGesture];
        
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self addSubview:self.tableView];
        
        UIView* headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50)];
        [headerView setBackgroundColor:[UIColor whiteColor]];
        CLSegmentedControl* segmented=[[CLSegmentedControl alloc] initWithFrame:CGRectMake(20, 10, headerView.frame.size.width-40, 30) style:CLSegmentedControlStyleRound];
        [segmented setDelegate:self];
        [segmented addItemByTitle:@"在售" Image:nil];
        [segmented addItemByTitle:@"全部" Image:nil];
        [headerView addSubview:segmented];
        [self.tableView setTableHeaderView:headerView];
    }
    
    return self;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    return ;
}

-(void)requestCompletionNotification:(NSNotification*)notification {
    dataSourceArray = [self formatSUBBrandQueryFormJSONArray:notification.userInfo[@"result"][@"list"]];
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    return ;
}

-(void)swipeGestureHandle:(UIGestureRecognizer*)recognizer {
    [self.delegate swipeDetailHandler];
    return ;
}

-(void)segmentedControl:(CLSegmentedControl *)segmentedControl selectedItemIndex:(NSInteger)selectedItemIndex {
    switch (selectedItemIndex) {
        case 0:
            NSLog(@"在售");
            break;
            
        default:
            NSLog(@"全部");
            break;
    }
}

-(NSArray*)formatSUBBrandQueryFormJSONArray:(NSArray*)jsonArray {
    NSMutableArray* dataArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i != [jsonArray count]; ++i) {
        SUBBrandQueryModel* model = [[SUBBrandQueryModel alloc] initWithDictionary:jsonArray[i]];
        [dataArray addObject:model];
    }
    
    return dataArray;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataSourceArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"VehicleCellIdentifier"];
    if(cell==nil)
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"VehicleCellIdentifier"];
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:12.0f]];
    
    SUBBrandQueryModel* model = dataSourceArray[indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@(%@)",model._series,model._time]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"指导价:%@",model._price]];
    if([model._image isEqual:[NSNull null]])
        [cell.imageView setImage:[UIImage imageNamed:@"bmw"]];
    else
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:kImageUrl(model._image, 100, 100)] placeholderImage:[UIImage imageNamed:@"bmw"]];
    
    return cell;
}

-(void)refreshTableViewDataWithBrandName:(NSString *)brandName {
    [NetworkingOperation sendJSONRequestWithUrl:[NSString stringWithFormat:@"%@/getvehicle?brand=%@",kApiUrl,brandName]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestCompletionNotification:) name:kRequestCompletionNotification object:nil];
    return ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate tableView:tableView indexPath:indexPath];
    return ;
}

@end
