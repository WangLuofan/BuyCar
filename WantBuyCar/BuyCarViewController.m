//
//  BuyCarViewController.m
//  要买车
//
//  Created by 王落凡 on 15/4/28.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "NetworkingOperation.h"
#import "BuyCarViewController.h"
#import "VehicleTableViewCell.h"
#import "QueryTableViewController.h"
#import "CLNavigationViewController.h"
#import "VehicleDetailView.h"
#import "BrandQueryModel.h"
#import "ConstantDef.h"

@interface BuyCarViewController ()<UITableViewDataSource,UITableViewDelegate,VehicleDetailViewDelegate> {
    NSArray* vehicleBrandKeyArray;
    NSDictionary* vehicleBrandDict;
    VehicleDetailView* vehicleDetailView;
    MBProgressHUD* progressHUD;
}

@end

@implementation BuyCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我要买车"];
    
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, kScreenHeight-kTabViewHeight) style:UITableViewStyleGrouped];
    [self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [self.tableView setSectionIndexColor:[UIColor grayColor]];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
  
    progressHUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [progressHUD setColor:[UIColor clearColor]];
    [progressHUD setLabelText:@"正在加载汽车列表，请耐心等待..."];
    [progressHUD setDimBackground:YES];
    
    [self initVehicleTable];
}

-(void)initVehicleTable {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestCompletionRequest:) name:kRequestCompletionNotification object:nil];
    [NetworkingOperation sendJSONRequestWithUrl:[NSString stringWithFormat:@"%@/getbrand",kApiUrl]];
    return ;
}

-(void)requestCompletionRequest:(NSNotification*)notification {
    vehicleBrandKeyArray = [self getOrderedKeyFromDictionary:notification.userInfo[@"result"]];
    vehicleBrandDict = [self formatBrandQueryFormJSONDictionary:notification.userInfo[@"result"]];
    
    [self.tableView reloadData];
    [progressHUD removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    return ;
}

-(NSDictionary*)formatBrandQueryFormJSONDictionary:(NSDictionary*)jsonDict {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    for (int i =0 ; i != vehicleBrandKeyArray.count; ++i) {
        NSMutableArray* array = [[NSMutableArray alloc] init];
        NSArray* vehicleArray = jsonDict[vehicleBrandKeyArray[i]];
        
        for(int j = 0; j != [vehicleArray count]; ++j) {
            BrandQueryModel* model = [[BrandQueryModel alloc] initWithDictionary:vehicleArray[j]];
            [array addObject:model];
        }
        
        [dict setValue:[array copy] forKey:vehicleBrandKeyArray[i]];
    }
    
    return dict;
}

-(NSArray*)getOrderedKeyFromDictionary:(NSDictionary*)dict {
    return [[dict allKeys] sortedArrayWithOptions:NSSortStable usingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [((NSString*)obj1) compare:((NSString *)obj2)];
        return result == NSOrderedDescending;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[vehicleBrandDict allKeys] count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [vehicleBrandDict[vehicleBrandKeyArray[section]] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VehicleTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"BuyCarCellIdentifier"];
    if(cell==nil) {
        cell=[[VehicleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BuyCarCellIdentifier"];
    }
    
    BrandQueryModel* model = vehicleBrandDict[vehicleBrandKeyArray[indexPath.section]][indexPath.row];
//    NSLog(@"%@",vehicleBrandDict[vehicleBrandKeyArray[indexPath.section]][indexPath.row]);
    
    [cell.textLabel setText:model._name];
    if([model._logo isEqual:[NSNull null]])
        [cell.imageView setImage:[UIImage imageNamed:@"bmw"]];
    else
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:kImageUrl(model._logo, 100, 100)] placeholderImage:[UIImage imageNamed:@"bmw"]];
//    else
//        [cell.imageView setImageWithURL:[NSURL URLWithString:kImageUrl(model._logo, 100, 100)] placeholderImage:@"bmw"];
    
    return cell;
}

-(NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return vehicleBrandKeyArray;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return vehicleBrandKeyArray[section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BrandQueryModel* model = vehicleBrandDict[vehicleBrandKeyArray[indexPath.section]][indexPath.row];
    
    if(vehicleDetailView == nil){
        vehicleDetailView = [[VehicleDetailView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width, kBaseHeight, self.view.bounds.size.width-40, self.view.bounds.size.height)];
        [vehicleDetailView setBackgroundColor:[UIColor whiteColor]];
        [vehicleDetailView setDelegate:self];
        [self.view addSubview:vehicleDetailView];
    }
    
    [vehicleDetailView refreshTableViewDataWithBrandName:model._name];
    [UIView animateWithDuration:kAnimateInterval animations:^{
        [vehicleDetailView setFrame:CGRectMake(40, kBaseHeight, self.view.bounds.size.width-40, self.view.bounds.size.height)];
    }completion:^(BOOL finished) {
        self.title=@"选车";
    }];
    return ;
}

-(void)tableView:(UITableView*)tableView indexPath:(NSIndexPath *)indexPath {
    UITableViewCell* selectedCell=[tableView cellForRowAtIndexPath:indexPath];
    QueryTableViewController* queryController = [[QueryTableViewController alloc] init];
    [queryController setTitle:selectedCell.textLabel.text];
    [self presentViewController:[[CLNavigationViewController alloc] initWithRootViewController:queryController] animated:YES completion:^{
    }];
    return ;
}

-(void)swipeDetailHandler {
    [UIView animateWithDuration:kAnimateInterval animations:^{
        [vehicleDetailView setFrame:CGRectMake(self.view.bounds.size.width, kBaseHeight, self.view.bounds.size.width-40, self.view.bounds.size.height)];
    }completion:^(BOOL finished) {
        self.title=@"我要买车";
    }];
    return ;
}

@end
