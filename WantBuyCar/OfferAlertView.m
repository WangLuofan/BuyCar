//
//  OfferAlertView.m
//  要买车
//
//  Created by 王落凡 on 15/5/4.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "OfferAlertView.h"

@interface OfferAlertView()<UITextViewDelegate> {
    UILabel* placeHolderLabel;
}

@end

@implementation OfferAlertView

-(instancetype)initWithTitle:(NSString *)title frame:(CGRect)frame message:(NSString *)message delegate:(id<CLAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [super initWithTitle:title frame:frame message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    
    if(self) {
        [self customAlertViewContents];
    }
    
    return self;
}

#pragma mark - 自定义AlertView内容

-(void)customAlertViewContents {
    [super customAlertViewContents];
    
    //我要报价
    UILabel* myOffer = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 50, 20)];
    [myOffer setFont:[UIFont systemFontOfSize:12.0f]];
    [myOffer setText:@"我的报价"];
    [myOffer setTextColor:[UIColor lightGrayColor]];
    [myOffer sizeToFit];
    [myOffer setTextAlignment:NSTextAlignmentCenter];
    [self.messageView addSubview:myOffer];
    
    //报价输入框
    UITextField* offerText=[[UITextField alloc] initWithFrame:CGRectMake(20+myOffer.frame.size.width, 0, self.messageView.bounds.size.width-30-myOffer.frame.size.width, 25)];
    [offerText setFont:[UIFont systemFontOfSize:12.0f]];
    [offerText setPlaceholder:@"你的报价"];
    [offerText setBackgroundColor:[UIColor whiteColor]];
    [offerText.layer setCornerRadius:2.0f];
    [offerText.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [offerText.layer setBorderWidth:0.5f];
    __weak id weakSelf = self;
    [offerText setDelegate:weakSelf];
    offerText.layer.masksToBounds=YES;
    
    [myOffer setCenter:CGPointMake(myOffer.center.x, offerText.center.y)];
    [myOffer sizeToFit];
    [myOffer setTextAlignment:NSTextAlignmentCenter];
    [self.messageView addSubview:offerText];
    
    //我要留言
    UILabel* myMessage=[[UILabel alloc] initWithFrame:CGRectMake(10, 35, 50, 20)];
    [myMessage setFont:[UIFont systemFontOfSize:12.0f]];
    [myMessage setText:@"我的留言"];
    [myMessage setTextColor:[UIColor lightGrayColor]];
    [self.messageView addSubview:myMessage];
    
    //留言输入框
    UITextView* messageText=[[UITextView alloc]initWithFrame:CGRectMake(offerText.frame.origin.x, 35, self.messageView.bounds.size.width-30-myOffer.frame.size.width, self.messageView.bounds.size.height-10-offerText.frame.size.height)];
    [messageText setDelegate:self];
    [messageText.layer setCornerRadius:2.0f];
    [messageText.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [messageText.layer setBorderWidth:0.5f];
    messageText.layer.masksToBounds=YES;
    [self.messageView addSubview:messageText];
    
    //留言输入框PlaceHolder;
    placeHolderLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 5, 0, 0)];
    [placeHolderLabel setTextColor:[UIColor lightGrayColor]];
    [placeHolderLabel setAlpha:0.7f];
    [placeHolderLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [placeHolderLabel setText:@"说点什么吧..."];
    [placeHolderLabel sizeToFit];
    [messageText addSubview:placeHolderLabel];
    
    return ;
}

#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView {
    if(textView.text.length==0)
        [placeHolderLabel setHidden:NO];
    else
        [placeHolderLabel setHidden:YES];
    return ;
}

@end
