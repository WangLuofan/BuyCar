//
//  QueryTableViewCell.m
//  要买车
//
//  Created by 王落凡 on 15/5/5.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "CommAlgorithm.h"
#import "QueryTableViewCell.h"

@implementation QueryTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self) {
        [self.textLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        self.queryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.queryButton setFrame:CGRectMake(self.frame.size.width-100, 10, 50, self.frame.size.height-20)];
        [self.queryButton.titleLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [self.queryButton setTitle:@"我要询价" forState:UIControlStateNormal];
        [self.queryButton addTarget:self action:@selector(queryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.queryButton setBackgroundImage:[CommAlgorithm createImageWithUIColor:[UIColor orangeColor]] forState:UIControlStateNormal];
        [self addSubview:self.queryButton];
    }
    
    return self;
}

-(void)queryButtonPressed:(UIButton*)sender {
    [self.delegate queryButtonPressed:sender];
    return ;
}

@end
