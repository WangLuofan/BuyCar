//
//  CLTabViewController.m
//  要买车
//
//  Created by 王落凡 on 15/4/28.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "CLTabViewController.h"
#import "CLTabView.h"
#import "ConstantDef.h"

@interface CLTabViewController ()<CLTabViewDelegate> {
    CLTabView* tabView;
}

@end

@implementation CLTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tabView=[[CLTabView alloc] initWithFrame:CGRectMake(0, kScreenHeight-kTabViewHeight, kScreenWidth, kTabViewHeight)];
    [tabView setDelegate:self];
    [self.view addSubview:tabView];
}

-(void)addTabItemByTitle:(NSString *)title Image:(NSString *)image SelectedImage:(NSString *)selectedImage {
    [tabView addTabItemByTitle:title Image:image SelectedImage:selectedImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ChangeTabTagFrom:(NSInteger)tagFrom TagTo:(NSInteger)tagTo {
    if(tagTo<0||tagTo>self.childViewControllers.count)
        return ;
    
    UIViewController* oldViewController=self.childViewControllers[tagFrom];
    [oldViewController.view removeFromSuperview];
    UIViewController* newViewController=self.childViewControllers[tagTo];
    [newViewController.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-44)];
    [self.view addSubview:newViewController.view];
    return ;
}

@end
