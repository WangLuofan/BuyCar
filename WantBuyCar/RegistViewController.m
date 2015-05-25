//
//  RegistViewController.m
//  要买车
//
//  Created by 王落凡 on 15/4/27.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "RegistViewController.h"
#import "RegistButton.h"
#import "CLNavigationViewController.h"
#import "BuyerRegistViewController.h"
#import "SalerRegistViewController.h"
#import "ConstantDef.h"

@interface RegistViewController ()

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"选择用户"];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.961 green:0.969 blue:0.925 alpha:1.0f]];
    
    //我要买车
    RegistButton* buyCarButton=[[RegistButton alloc] initWithFrame:CGRectMake(0, 0, 100, 125)];
    [buyCarButton setImage:[UIImage imageNamed:@"BuyCar"] forState:UIControlStateNormal];
    [buyCarButton setTitle:@"我要买车" forState:UIControlStateNormal];
    [buyCarButton setCenter:CGPointMake(kScreenWidth/2 - 20 - buyCarButton.bounds.size.width/2, kScreenHeight/2)];
    [buyCarButton addTarget:self action:@selector(buyCarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyCarButton];
    
    //我要卖车
    RegistButton* saleCarButton=[[RegistButton alloc] initWithFrame:CGRectMake(0, 0, 100, 125)];
    [saleCarButton setImage:[UIImage imageNamed:@"SaleCar"] forState:UIControlStateNormal];
    [saleCarButton setTitle:@"我要卖车" forState:UIControlStateNormal];
    [saleCarButton setCenter:CGPointMake(kScreenWidth/2 + 20 + saleCarButton.bounds.size.width/2, kScreenHeight/2)];
    [saleCarButton addTarget:self action:@selector(saleCarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saleCarButton];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
}

-(void)buyCarButtonPressed:(UIButton*)sender {
//    [self.navigationController pushViewController:[[BuyerRegistViewController alloc] init] animated:YES];
    [self presentViewController:[[CLNavigationViewController alloc] initWithRootViewController:[[BuyerRegistViewController alloc] init]] animated:YES completion:^{
    }];
    return ;
}

-(void)saleCarButtonPressed:(UIButton*)sender {
//    [self.navigationController pushViewController:[[SalerRegistViewController alloc] init] animated:YES];
    [self presentViewController:[[CLNavigationViewController alloc] initWithRootViewController:[[SalerRegistViewController alloc] init]] animated:YES completion:^{
    }];
    return ;
}

-(void)cancelButtonPressed {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
    return ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end