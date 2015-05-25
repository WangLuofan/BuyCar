//
//  MainViewController.m
//  要买车
//
//  Created by 王落凡 on 15/4/28.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "MainViewController.h"
#import "ZuiXinViewController.h"
#import "AttentionViewController.h"
#import "BuyCarViewController.h"
#import "ChatRecordViewController.h"
#import "OfferViewController.h"
#import "CLNavigationViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllControllers];
    [self addAllTabItems];
    return ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addAllTabItems {
    [self addTabItemByTitle:nil Image:@"zx" SelectedImage:@"zx_h"];
    [self addTabItemByTitle:nil Image:@"mc" SelectedImage:@"mc_h"];
    [self addTabItemByTitle:nil Image:@"mc" SelectedImage:@"mc_h"];
    [self addTabItemByTitle:nil Image:@"gz" SelectedImage:@"gz_h"];
    [self addTabItemByTitle:nil Image:@"lt" SelectedImage:@"lt_h"];
    return ;
}

-(void)addAllControllers {
    [self addChildViewController:[[CLNavigationViewController alloc] initWithRootViewController:[[ZuiXinViewController alloc] init]]];
    [self addChildViewController:[[CLNavigationViewController alloc] initWithRootViewController:[[BuyCarViewController alloc] init]]];
    [self addChildViewController:[[CLNavigationViewController alloc] initWithRootViewController:[[OfferViewController alloc] init]]];
    [self addChildViewController:[[CLNavigationViewController alloc] initWithRootViewController:[[AttentionViewController alloc] init]]];
    [self addChildViewController:[[CLNavigationViewController alloc] initWithRootViewController:[[ChatRecordViewController alloc] init]]];
    return ;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
