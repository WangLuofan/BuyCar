//
//  CLTabView.m
//  要买车
//
//  Created by 王落凡 on 15/4/28.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "CLTabView.h"
#import "CLTabItem.h"

@interface CLTabView () {
    CLTabItem* selectedTabItem;
}

@end

@implementation CLTabView

-(void)addTabItemByTitle:(NSString *)title Image:(NSString*)image SelectedImage:(NSString*)selectedImage {
    CLTabItem* tabItem=[CLTabItem buttonWithType:UIButtonTypeCustom];
    
    [tabItem setTitle:title forState:UIControlStateNormal];
    [tabItem setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [tabItem setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [tabItem setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [tabItem addTarget:self action:@selector(tabItemPressed:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:tabItem];
    
    int index=0;
    CGFloat kWidth=self.bounds.size.width/self.subviews.count;
    
    for (UIView* subView in self.subviews) {
        [subView setTag:index];
        [subView setFrame:CGRectMake((index++)*kWidth, 0, kWidth, self.bounds.size.height)];
    }
    
    if(selectedTabItem==nil)
        [self tabItemPressed:self.subviews[0]];
    
    return ;
}

-(void)tabItemPressed:(CLTabItem*)sender {
    if(selectedTabItem==sender)
        return ;
    
    [selectedTabItem setSelected:NO];
    [sender setSelected:YES];
    
    [self.delegate ChangeTabTagFrom:selectedTabItem.tag TagTo:sender.tag];
    
    selectedTabItem=sender;
    return ;
}

@end

