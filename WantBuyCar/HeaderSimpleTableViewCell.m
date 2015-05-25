//
//  HeaderSimpleTableViewCell.m
//  要买车
//
//  Created by 王落凡 on 15/5/7.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//


#import "HeaderSimpleTableViewCell.h"

@interface HeaderSimpleTableViewCell () {
    UILabel* offerInfoLabel;
}

@end

@implementation HeaderSimpleTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 30, 30)];
        [self addSubview:self.headerImageView];
        
        self.vehicleInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, self.frame.size.width - 50, 20)];
        [self.vehicleInfoLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [self addSubview:self.vehicleInfoLabel];
        
        self.descInfoLabelArray = [[NSMutableArray alloc] init];
        
        offerInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 45, self.frame.size.width - 150, 20)];
        [offerInfoLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [offerInfoLabel setTextColor:[UIColor lightGrayColor]];
        [self addSubview:offerInfoLabel];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 100, 45, 80, 20)];
        [self.dateLabel setTextAlignment:NSTextAlignmentRight];
        [self.dateLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self.dateLabel setTextColor:[UIColor lightGrayColor]];
        [self addSubview:self.dateLabel];
    }
    
    return self;
}

-(void)addDescribeInfo:(NSString *)desc {
    CGSize descSize = [desc sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0f]}];
    
    UILabel* label = nil;
    if([self.descInfoLabelArray count]==0) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, descSize.width + 5, 20)];
    }else {
        UILabel* frontLabel = (UILabel*)self.descInfoLabelArray[self.descInfoLabelArray.count-1];
        label = [[UILabel alloc] initWithFrame:CGRectMake(frontLabel.frame.origin.x+frontLabel.frame.size.width + 5, frontLabel.frame.origin.y, descSize.width+5, frontLabel.frame.size.height)];
    }
    
    [label setText:desc];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:10.0f]];
    [label.layer setCornerRadius:5.0f];
    [label.layer setMasksToBounds:YES];
    [label setBackgroundColor:[UIColor brownColor]];
    
    if(label.frame.origin.x+label.frame.size.width > self.frame.size.width)
        @throw @"The All Describe labels' length must be less than the width of the screen";
    
    [self.descInfoLabelArray addObject:label];
    [self addSubview:label];
    
    return ;
}

-(void)addOfferInfoWithCount:(NSInteger)count price:(CGFloat)price {
    NSString* countString = [NSString stringWithFormat:@"%ld",(long)count];
    NSString* priceString = [NSString stringWithFormat:@"%.2f",price];
    
    NSMutableAttributedString* attriString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@个报价%@万起",countString,priceString]];
    [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, countString.length)];
    [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(countString.length+3, priceString.length)];
    
    [offerInfoLabel setAttributedText:attriString];
    return ;
}

@end
