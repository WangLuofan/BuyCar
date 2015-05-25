//
//  MenuItemView.m
//  要买车
//
//  Created by 王落凡 on 15/4/28.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "MenuItemView.h"
#import "CommAlgorithm.h"
#import "ConstantDef.h"

@interface MenuItemView () {
    UIView* userInfoView;
    UISwipeGestureRecognizer* swipeGesture;
}

@end

@implementation MenuItemView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setLoginSuccessful:NO];
        [self setBackgroundColor:[UIColor colorWithRed:0.984 green:0.957 blue:0.910 alpha:1.0]];
        
        userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, kBaseHeight, self.frame.size.width, 100)];
        
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        [self.headerImageView.layer setBorderWidth:0.5f];
        [self.headerImageView.layer setMasksToBounds:YES];
        [userInfoView addSubview:self.headerImageView];
        
        self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, self.frame.size.width - 80, 20)];
        [self.userNameLabel setText:@"用户名:"];
        [self.userNameLabel setNumberOfLines:0];
        [self.userNameLabel setTextColor:[UIColor redColor]];
        [self.userNameLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [userInfoView addSubview:self.userNameLabel];
        
        self.loginDateLabel= [[UILabel alloc] initWithFrame:CGRectMake(80, userInfoView.frame.size.height - 60, self.frame.size.width - 80, 20)];
        [self.loginDateLabel setNumberOfLines:0];
        [self.loginDateLabel setFont:[UIFont systemFontOfSize:8.0f]];
        [self.loginDateLabel setTextColor:[UIColor lightGrayColor]];
        [self.loginDateLabel setText:@"登陆时间:"];
        [userInfoView addSubview:self.loginDateLabel];
        
        self.logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.logoutButton setFrame:CGRectMake(5, userInfoView.frame.size.height-25, userInfoView.frame.size.width-10, 20)];
        [self.logoutButton setBackgroundImage:[CommAlgorithm createImageWithUIColor:[UIColor orangeColor]] forState:UIControlStateNormal];
        [self.logoutButton setBackgroundImage:[CommAlgorithm createImageWithUIColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
        [self.logoutButton setBackgroundImage:[CommAlgorithm createImageWithUIColor:[UIColor grayColor]] forState:UIControlStateDisabled];
        [self.logoutButton setTitle:@"退出登陆" forState:UIControlStateNormal];
        [self.logoutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.logoutButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self.logoutButton setEnabled:NO];
        [self.logoutButton addTarget:self action:@selector(logoutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [userInfoView addSubview:self.logoutButton];
        
        UIView* seperator = [[UIView alloc] initWithFrame:CGRectMake(0, userInfoView.frame.size.height-0.5, userInfoView.frame.size.width, 0.5)];
        [seperator setBackgroundColor:[UIColor blackColor]];
        [userInfoView addSubview:seperator];
        
        [self addSubview:userInfoView];
        
        [self addAllMenuItemOptions];
        
        swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [self addGestureRecognizer:swipeGesture];
        
        [self addObserver:self forKeyPath:@"isLoginSuccessful" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    
    return self;
}

-(void)logoutButtonPressed:(UIButton*)sender {
    [self.delegate logout];
    return ;
}

-(void)setLoginSuccessful:(BOOL)isLoginSuccessful {
    [self setValue:isLoginSuccessful?@"YES":@"NO" forKey:@"isLoginSuccessful"];
    return ;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context  {
    if([keyPath isEqualToString:@"isLoginSuccessful"]) {
        [self.logoutButton setEnabled:self.isLoginSuccessful];
    }
    return ;
}

-(void)handleGesture:(UISwipeGestureRecognizer*)gestureRecognizer {
    if(gestureRecognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        [self hideMenuItem];
    }
    return ;
}

-(UIButton*)createMenuItemByImageName:(NSString*)imageName SelectedImageName:(NSString*)selectedImage{
    UIButton* menuItem=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [menuItem setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [menuItem setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateHighlighted];
    [menuItem addTarget:self action:@selector(menuItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return menuItem;
}

-(void)menuItemClicked:(UIButton*)sender {
    [self.delegate menuItemClicked:sender.tag];
    return ;
}

-(void)addAllMenuItemOptions {
    NSArray* menuArray=@[@"yhdl",@"zc",@"xtsz",@"wbdl",@"qqdl",@"wxdl"];
    
    for(int i=0;i!=menuArray.count;++i) {
        UIButton* menuItem=[self createMenuItemByImageName:menuArray[i] SelectedImageName:[NSString stringWithFormat:@"%@_h",menuArray[i]]];
        [menuItem setFrame:CGRectMake(0, userInfoView.frame.size.height+kBaseHeight+i*kMenuItemHeight, self.bounds.size.width, kMenuItemHeight)];
        [menuItem setTag:i];
        [self addSubview:menuItem];
    }
    
    return ;
}

-(void)setUserInfoWithHeaderURLString:(NSString *)headerURL UserName:(NSString *)userName {
    [self.headerImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:headerURL]]]];
    NSMutableString* nameString = [[NSMutableString alloc] initWithString:self.userNameLabel.text];
    [nameString appendString:userName];
    [self.userNameLabel setText:[nameString copy]];
    
    nameString = [[NSMutableString alloc] initWithString:self.loginDateLabel.text];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    [nameString appendString:[formatter stringFromDate:[NSDate date]]];
    [self.loginDateLabel setText:[nameString copy]];
    
    return ;
}

-(void)clearUserInfo {
    [self.headerImageView setImage:nil];
    [self.userNameLabel setText:@""];
    [self.loginDateLabel setText:@""];
    return ;
}

-(void)showMenuItem {
    [UIView animateWithDuration:kAnimateInterval animations:^{
        [self setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    }completion:^(BOOL finished) {
//        [self.delegate MenuItemStateChangedToShown:YES];
    }];
    return ;
}

-(void)hideMenuItem {
    [UIView animateWithDuration:kAnimateInterval animations:^{
        [self setFrame:CGRectMake(0-self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    } completion:^(BOOL finished) {
//        [self.delegate MenuItemStateChangedToShown:NO];
    }];
    return ;
}

@end
