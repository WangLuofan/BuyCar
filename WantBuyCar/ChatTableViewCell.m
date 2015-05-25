//
//  ChatTableViewCell.m
//  要买车
//
//  Created by 王落凡 on 15/5/6.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "CLButton.h"
#import "ConstantDef.h"
#import "ChatTableViewCell.h"
#import "EMSDKFull.h"

@interface ChatTableViewCell () {
    CLButton* dateButton;
    CLButton* chatButton;
    UIImage* chatImage;
    
    ChatDirectionType chatDirectionType;
}

@end

@implementation ChatTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier chatDirection:(ChatDirectionType)chatDirection {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        chatDirectionType = chatDirection;
        
        //时间标签
        dateButton = [CLButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:dateButton];
        
        switch (chatDirection) {
            case CHAT_TYPE_FROM:
            {
                //头像
                self.headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, kChatDateLabelHeight + 20, 30, 30)];
                [self addSubview:self.headerImage];
                chatImage = [UIImage imageNamed:@"chatfrom"];
                
                //聊天气泡
                chatButton = [CLButton buttonWithType:UIButtonTypeCustom];
                [chatButton setTitleEdgeInsets:UIEdgeInsetsMake(kChatTopMargin, kChatLeftMargin, kChatTopMargin, kChatRightMargin)];
                [chatButton setFrame:CGRectMake(self.headerImage.frame.size.width + 10, self.headerImage.frame.origin.y - 5, self.frame.size.width - 70, 0)];
                [self addSubview:chatButton];
            }
                break;
                
            case CHAT_TYPE_TO:
            {
                self.headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 35, kChatDateLabelHeight + 20, 30, 30)];
                [self addSubview:self.headerImage];
                
                chatImage = [UIImage imageNamed:@"chatto"];
                
                //聊天气泡
                chatButton = [CLButton buttonWithType:UIButtonTypeCustom];
                [chatButton setTitleEdgeInsets:UIEdgeInsetsMake(kChatTopMargin, kChatRightMargin, kChatTopMargin, kChatLeftMargin)];
                [chatButton setFrame:CGRectMake(0, self.headerImage.frame.origin.y, self.frame.size.width - 70, 0)];
                [self addSubview:chatButton];
            }
                break;
                
            default:
                break;
        }
    }
    
    [chatButton.titleLabel setNumberOfLines:0];
    [chatButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [chatButton addTarget:self action:@selector(chatButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return self;
}

#pragma mark - 设置消息发送(接收)时间
-(void)setMessageDateWithString:(NSString *)dateString {
    [dateButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [dateButton setTitle:dateString forState:UIControlStateNormal];
    CGSize contentSize = [dateString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}];
    [dateButton setFrame:CGRectMake(0, 0, contentSize.width + 10, kChatDateLabelHeight)];
    [dateButton setCenter:CGPointMake(self.frame.size.width/2, dateButton.center.y+5)];
    [dateButton setBackgroundColor:[UIColor grayColor]];
    [dateButton.layer setCornerRadius:10.0f];
    [dateButton.layer setMasksToBounds:YES];
    return ;
}

#pragma mark - 设置消息内容
-(id)setMessageContentWithType:(MessageType)messageType contents:(id)contents {
    id ChatBody = nil;
    switch (messageType) {
            //文字类型
        case MESSAGE_TYPE_TEXT:
        {
            NSString* message = (NSString*)contents;
            [chatButton setTitle:message forState:UIControlStateNormal];
            CGSize contentSize = [message boundingRectWithSize:CGSizeMake(chatButton.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]} context:nil].size;
            if(chatDirectionType==CHAT_TYPE_FROM)
                [chatButton setFrame:CGRectMake(chatButton.frame.origin.x, chatButton.frame.origin.y, contentSize.width+kChatLeftMargin+kChatRightMargin, contentSize.height+kChatTopMargin)];
            else
                [chatButton setFrame:CGRectMake(self.frame.size.width-contentSize.width-70, chatButton.frame.origin.y, contentSize.width+kChatLeftMargin+kChatRightMargin, contentSize.height+kChatTopMargin*2)];
            [chatButton setImage:nil forState:UIControlStateNormal];
            
            EMChatText* txtChat = [[EMChatText alloc] initWithText:message];
            EMTextMessageBody* body = [[EMTextMessageBody alloc] initWithChatObject:txtChat];
            ChatBody = [[EMMessage alloc] initWithReceiver:@"wangluofan" bodies:@[body]];
        }
            break;
            
            //图片类型
        case MESSAGE_TYPE_IMAGE:
        {
            UIImage* message = (UIImage*)contents;
            [chatButton setImage:message forState:UIControlStateNormal];
            if(chatDirectionType==CHAT_TYPE_FROM)
                [chatButton setFrame:CGRectMake(chatButton.frame.origin.x, chatButton.frame.origin.y, self.frame.size.width - 50,self.frame.size.width - 50)];
            else
                [chatButton setFrame:CGRectMake(self.frame.size.width - 240, chatButton.frame.origin.y, 200,200)];
            
            [chatButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
            [chatButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 20)];
            [chatButton setImage:message forState:UIControlStateNormal];
            
            [self.headerImage setCenter:CGPointMake(self.headerImage.center.x, self.headerImage.center.y + 20)];
            
            EMChatImage* imageChat = [[EMChatImage alloc] initWithUIImage:message displayName:@"image"];
            EMImageMessageBody* body = [[EMImageMessageBody alloc] initWithChatObject:imageChat];
            ChatBody = [[EMMessage alloc] initWithReceiver:@"wangluofan" bodies:@[body]];
        }
            break;
            
        default:
            break;
    }
    
    [chatButton setBackgroundImage:[chatImage resizableImageWithCapInsets:UIEdgeInsetsMake(80, 70, 81, 71)] forState:UIControlStateNormal];
    ((EMMessage*)ChatBody).isGroup = NO;
    
    return ChatBody;
}

-(CGFloat)cellHeight {
    return chatButton.frame.origin.y + chatButton.frame.size.height + 10;
}

-(void)chatButtonPressed:(UIButton*)sender {
    return ;
}

@end
