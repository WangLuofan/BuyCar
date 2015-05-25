//
//  CarInfoTableViewCell.m
//  要买车
//
//  Created by 王落凡 on 15/4/29.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "CarInfoTableViewCell.h"
#import "CommAlgorithm.h"
#import "ConstantDef.h"

@implementation CarInfoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self) {
        [self setFrame:CGRectMake(0, 0, kScreenWidth, 80)];
        
        self.carImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        [self addSubview:self.carImageView];
        
        self.buyerInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 100, 20)];
        [self.buyerInfoLabel setTextColor:[UIColor grayColor]];
        [self.buyerInfoLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self addSubview:self.buyerInfoLabel];
        
        self.priceInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, self.bounds.size.width-90-50, 20)];
        [self.priceInfoLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self addSubview:self.priceInfoLabel];
        
        self.carInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, self.bounds.size.width-90-50, 20)];
        [self.carInfoLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self addSubview:self.carInfoLabel];

        self.dateTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-60, 50, 50, 20)];
        [self.dateTimeLabel setTextAlignment:NSTextAlignmentRight];
        [self.dateTimeLabel setTextColor:[UIColor grayColor]];
        [self.dateTimeLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self addSubview:self.dateTimeLabel];
        
        self.offerInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-60, 30, 50, 20)];
        [self.offerInfoLabel setTextAlignment:NSTextAlignmentRight];
        [self.offerInfoLabel setTextColor:[UIColor grayColor]];
        [self.offerInfoLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self addSubview:self.offerInfoLabel];
        
        //分隔线
        UIImageView* seperator=[[UIImageView alloc] initWithImage:[CommAlgorithm createImageWithRed:0.647 Green:0.647 Blue:0.647 Alpha:0.5f]];
        [seperator setFrame:CGRectMake(10, self.frame.size.height-0.5f, self.frame.size.width-20, 0.5f)];
        [self addSubview:seperator];
    }
    
    return self;
}

-(void)setPriceInfo:(NSString*)priceString OfferInfo:(NSString*)offerString {
    //设置价格信息
    NSMutableAttributedString* priceAttributed=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"官方指导价:%@",priceString]];
    [priceAttributed addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 6)];
    [priceAttributed addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, priceString.length)];
    [self.priceInfoLabel setAttributedText:priceAttributed];
    
    //设置报价信息
    NSMutableAttributedString* offerAttributed=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@人报价",offerString]];
    [offerAttributed addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, offerString.length)];
    [offerAttributed addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(offerString.length, offerAttributed.length-offerString.length)];
    [self.offerInfoLabel setAttributedText:offerAttributed];
    
    return ;
}

@end
