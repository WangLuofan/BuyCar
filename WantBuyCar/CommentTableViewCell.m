//
//  CommentTableViewCell.m
//  要买车
//
//  Created by 王落凡 on 15/5/5.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "ConstantDef.h"
#import "UserComment.h"
#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        //头像
        self.headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 40, 40)];
        [self addSubview:self.headerImage];
        
        //用户名
        self.usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 100, 20)];
        [self.usernameLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self addSubview:self.usernameLabel];

        //评论内容
        self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 25, self.frame.size.width-80, 100)];
        [self.commentLabel setNumberOfLines:0];
        [self.commentLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self.commentLabel setTextColor:[UIColor blackColor]];
        [self.commentLabel setAlpha:0.8f];
        [self addSubview:self.commentLabel];
        
        //参与人数
        self.attendLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-120, 5, 100, 20)];
        [self.attendLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self.attendLabel setTextAlignment:NSTextAlignmentRight];
        [self.attendLabel setTextColor:[UIColor lightGrayColor]];
        [self addSubview:self.attendLabel];
    }
    
    return self;
}

-(CGFloat)cellHeight {
    CGSize size = [self.commentLabel.text boundingRectWithSize:CGSizeMake(240, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]} context:nil].size;
    return size.height + 40;
}

@end
