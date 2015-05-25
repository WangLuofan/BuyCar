//
//  ImageTableViewCell.m
//  要买车
//
//  Created by 王落凡 on 15/4/29.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "ImageTableViewCell.h"
#import "ConstantDef.h"

@interface ImageTableViewCell ()<UIScrollViewDelegate> {
    NSArray* imageSourceArray;
    UIScrollView* imageScrollView;
    UIPageControl* imagePageControl;
}

@end

@implementation ImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setFrame:CGRectMake(0, 0, kScreenWidth, 180)];
    
        imageScrollView = [[UIScrollView alloc] init];
        [imageScrollView setPagingEnabled:YES];
        [imageScrollView setShowsHorizontalScrollIndicator:NO];
        [imageScrollView setShowsVerticalScrollIndicator:NO];
        [imageScrollView setDelegate:self];
        [self addSubview:imageScrollView];
        
        imagePageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
        [imagePageControl setCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height-20)];
        [self addSubview:imagePageControl];
    }
    
    return self;
}

-(void) setImageSource:(NSArray *)imageSource {
    imageSourceArray=[NSArray arrayWithArray:imageSource];
    
    [imageScrollView setFrame:CGRectMake(0, 0, self.bounds.size.width, 180)];
    
    for(int i=0;i!=imageSource.count;++i) {
        UIImage* image=[UIImage imageNamed:imageSourceArray[i]];
        UIImageView* imageView=[[UIImageView alloc] initWithImage:image];
        [imageView setFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, self.bounds.size.height)];
        [imageScrollView addSubview:imageView];
    }
    [imageScrollView setContentSize:CGSizeMake(self.bounds.size.width*imageSourceArray.count, 0)];
    [imagePageControl setNumberOfPages:imageSourceArray.count];
    
    return ;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [imagePageControl setCurrentPage:((int)scrollView.contentOffset.x/self.bounds.size.width+0.5)];
    return ;
}

@end
