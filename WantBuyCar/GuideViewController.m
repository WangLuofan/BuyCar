//
//  GuideViewController.m
//  要买车
//
//  Created by 王落凡 on 15/4/24.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "ThirdPartyLogin.h"
#import "GuideViewController.h"
#import "GuideImageView.h"
#import "LoginAlertView.h"
#import "RegistViewController.h"
#import "CLNavigationViewController.h"
#import "ZuiXinViewController.h"
#import "MainViewController.h"
#import "ConstantDef.h"

@interface GuideViewController ()<UIScrollViewDelegate,GuideImageViewDelegate,CLAlertViewDelegate> {
    UIScrollView* guideScrollView;
    UIPageControl* pageControl;
    LoginAlertView* loginAlertView;
}

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray* guideImageViewArray=@[@"引导页01.jpg",@"引导页02.jpg",@"引导页03.jpg",@"ydy_bg.png"];
    
    //设置UIScrollView属性
    guideScrollView=[[UIScrollView alloc] initWithFrame:kScreenBounds];
    [guideScrollView setBounces:NO];
    [guideScrollView setDelegate:self];
    [guideScrollView setPagingEnabled:YES];
    [guideScrollView setShowsHorizontalScrollIndicator:NO];
    [guideScrollView setShowsVerticalScrollIndicator:NO];
    [guideScrollView setContentMode:UIViewContentModeScaleAspectFit];
    
    //添加引导页图片
    for(int i=0;i!=[guideImageViewArray count]-1;++i) {
        UIImage* guideImage=[UIImage imageNamed:guideImageViewArray[i]];
        UIImageView* imageView=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight)];
        [imageView setImage:guideImage];
        [guideScrollView addSubview:imageView];
    }
    
    //最后一张引导页的处理
    GuideImageView* imageView=[[GuideImageView alloc] initWithFrame:CGRectMake(kScreenWidth*(guideImageViewArray.count-1) , 0, kScreenWidth, kScreenHeight)];
    [imageView setImage:[UIImage imageNamed:[guideImageViewArray lastObject]]];
    [imageView setDelegate:self];
    [guideScrollView addSubview:imageView];
    [guideScrollView setContentSize:CGSizeMake(guideImageViewArray.count*kScreenWidth, 0)];
    [self.view addSubview:guideScrollView];
    
    //页面指示器
    pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [pageControl setCenter:CGPointMake(kScreenWidth/2,kScreenHeight-100)];
    [pageControl setNumberOfPages:guideImageViewArray.count];
    [self.view addSubview:pageControl];
    
    return ;
}


-(void)buttonPressedByIndex:(NSInteger)index {
    
    switch (index) {
        case 0:
        {
            if(loginAlertView==nil)
                loginAlertView=[[LoginAlertView alloc] initWithFrame:CGRectMake(0, 0, 277, 272)];
            [loginAlertView setAlertDelegate:self];
            [loginAlertView show];
        }
            break;
            
        case 1:
        {
            RegistViewController* registController=[[RegistViewController alloc] init];
            [self presentViewController:[[CLNavigationViewController alloc] initWithRootViewController:registController] animated:YES completion:^{
            }];
        }
            break;
            
        default:
            break;
    }
    
    return ;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [pageControl setCurrentPage:((int)scrollView.contentOffset.x/kScreenWidth+0.5)];
    return ;
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView:(CLAlertView *)alertView buttonPressedIndex:(NSInteger)buttonPressedIndex {
    switch (buttonPressedIndex) {
        //取消
        case 0:
        {
            return ;
        }
            break;
            
        //确定
        case 1:
        {
            return ;
        }
            break;
            
        //QQ登陆
        case 2:
        {
            MainViewController* mainViewController = [[MainViewController alloc] init];
            [self presentViewController:mainViewController animated:YES completion:^{
                ZuiXinViewController* zuiXin = (ZuiXinViewController*)((CLNavigationViewController*)[mainViewController.childViewControllers firstObject]).rootViewController;
                [zuiXin login:LoginPlatform_QQ];
            }];
            return ;
        }
            break;
            
        //微信登陆
        case 3:
        {
            MainViewController* mainViewController = [[MainViewController alloc] init];
            [self presentViewController:mainViewController animated:YES completion:^{
                ZuiXinViewController* zuiXin = (ZuiXinViewController*)((CLNavigationViewController*)[mainViewController.childViewControllers firstObject]).rootViewController;
                [zuiXin login:LoginPlatform_WX];
            }];
            return ;
        }
            break;
            
        //微博登陆
        case 4:
        {
            MainViewController* mainViewController = [[MainViewController alloc] init];
            [self presentViewController:mainViewController animated:YES completion:^{
                ZuiXinViewController* zuiXin = (ZuiXinViewController*)((CLNavigationViewController*)[mainViewController.childViewControllers firstObject]).rootViewController;
                [zuiXin login:LoginPlatform_Sina];
            }];
            return ;
        }
            break;
        default:
            break;
    }
    return ;
}

@end
