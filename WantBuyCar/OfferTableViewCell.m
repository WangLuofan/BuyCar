//
//  OfferTableViewCell.m
//  要买车
//
//  Created by 王落凡 on 15/5/4.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "OfferTableViewCell.h"
#import "ConstantDef.h"

@implementation OfferTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self) {
        [self setFrame:CGRectMake(0, 0, kScreenWidth, 80)];
        
        //汽车图片
        self.vehicleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 60, 60)];
        [self addSubview:self.vehicleImageView];
        
        //用户
        self.userLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 100, 20)];
        [self.userLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self.userLabel setTextColor:[UIColor lightGrayColor]];
        [self addSubview:self.userLabel];
        
        //车型信息
        self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 150, 20)];
        [self.infoLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self addSubview:self.infoLabel];
        
        //价格信息
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 50, 200, 20)];
        [self.priceLabel setTextColor:[UIColor lightGrayColor]];
        [self.priceLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self addSubview:self.priceLabel];
        
        //我要报价
        self.offerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.offerButton setFrame:CGRectMake(kScreenWidth-85, 10, 80, 20)];
        [self.offerButton setTitle:@"我要报价" forState:UIControlStateNormal];
        [self.offerButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.offerButton.titleLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [self.offerButton setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 0)];
        [self.offerButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -24, 0, 0)];
        [self.offerButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.offerButton setImage:[UIImage imageNamed:@"myOffer"] forState:UIControlStateNormal];
        [self.offerButton setImage:[UIImage imageNamed:@"myOffer_h"] forState:UIControlStateHighlighted];
        [self.offerButton addTarget:self action:@selector(offerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.offerButton];
        
        //加关注
        self.addAttentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.addAttentionButton setFrame:CGRectMake(kScreenWidth-85, 30, 80, 20)];
        [self.addAttentionButton setTitle:@"加关注" forState:UIControlStateNormal];
        [self.addAttentionButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.addAttentionButton.titleLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [self.addAttentionButton setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 0)];
        [self.addAttentionButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -24, 0, 0)];
        [self.addAttentionButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.addAttentionButton setImage:[UIImage imageNamed:@"follow"] forState:UIControlStateNormal];
        [self.addAttentionButton setImage:[UIImage imageNamed:@"follow_h"] forState:UIControlStateHighlighted];
        [self.addAttentionButton addTarget:self action:@selector(addAttentionPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.addAttentionButton];
        
        //时间
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(270, 50, 100, 20)];
        [self.dateLabel setTextColor:[UIColor lightGrayColor]];
        [self.dateLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self addSubview:self.dateLabel];
    }
    
    return self;
}

-(void)setPrice:(NSString *)priceString {
    NSMutableAttributedString* priceAttributed=[[NSMutableAttributedString alloc] initWithString:priceString];
    [priceAttributed addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, priceString.length)];
    NSMutableAttributedString* text=[[NSMutableAttributedString alloc] initWithString:@"官方指导价:"];
    [text appendAttributedString:priceAttributed];
    [self.priceLabel setAttributedText:text];
    
    return ;
}

-(void)offerButtonPressed:(UIButton*)sender {
    [self.delegate offerButtonPressed];
    return ;
}

-(void)addAttentionPressed:(UIButton*)sender {
    [self.delegate addAttentionButtonPressed];
    return ;
}

@end
