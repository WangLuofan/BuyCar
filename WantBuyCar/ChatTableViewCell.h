//
//  ChatTableViewCell.h
//  要买车
//
//  Created by 王落凡 on 15/5/6.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CHAT_TYPE_FROM,CHAT_TYPE_TO
}ChatDirectionType;

typedef enum {
    MESSAGE_TYPE_TEXT,MESSAGE_TYPE_IMAGE
}MessageType;

@interface ChatTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView* headerImage;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier chatDirection:(ChatDirectionType)chatDirection;

-(void)setMessageDateWithString:(NSString*)dateString;
-(id)setMessageContentWithType:(MessageType)messageType contents:(id)contents;
-(CGFloat)cellHeight;

@end
