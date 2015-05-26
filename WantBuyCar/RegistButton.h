//
//  RegistButton.h
//  要买车
//
//  Created by 王落凡 on 15/4/27.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    RegistButtonType_Entry,RegistButtonType_Upload
}RegistButtonType;

@interface RegistButton : UIButton

@property(nonatomic,copy) UIImage* headerImage;
-(void)setRegistButtonType:(RegistButtonType)buttonType;

@end
