//
//  RegistItemView.h
//  要买车
//
//  Created by 王落凡 on 15/4/27.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistItemView : UIView

-(NSString*)contentText;
-(void)setLabelText:(NSString*)text TextFieldPlaceHolder:(NSString*)placeHolder isSecurity:(BOOL)isSecurity isNumpad:(BOOL)isNumpad;
-(BOOL)resignFirstResponder;

@end
