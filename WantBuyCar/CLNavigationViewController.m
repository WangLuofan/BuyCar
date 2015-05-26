//
//  CLNavigationViewController.m
//  要买车
//
//  Created by 王落凡 on 15/4/28.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "CLNavigationViewController.h"

@interface CLNavigationViewController ()

@end

@implementation CLNavigationViewController

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    
    if(self) {
        self.rootViewController = rootViewController;
    }
    
    return self;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarAppearance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置全局NavigationBar的属性
-(void) setNavigationBarAppearance {
    UINavigationBar* navigationBar=[UINavigationBar appearance];
    UIBarButtonItem* barButtonItem=[UIBarButtonItem appearance];
    [navigationBar setBarTintColor:[UIColor colorWithRed:0.984 green:0.455 blue:0.035 alpha:1.0f]];
    [navigationBar setTitleTextAttributes:@{
                                           NSForegroundColorAttributeName:[UIColor whiteColor]
                                           }];
    [barButtonItem setTitleTextAttributes:@{
                                           NSForegroundColorAttributeName:[UIColor whiteColor]
                                           }forState:UIControlStateNormal];
    return ;
}

@end
