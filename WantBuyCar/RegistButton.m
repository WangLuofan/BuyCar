//
//  RegistButton.m
//  要买车
//
//  Created by 王落凡 on 15/4/27.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "CLAlertView.h"
#import "RegistButton.h"

#define TITLE_RATIO 0.2

@interface RegistButton ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    RegistButtonType registButtonType;
    CLAlertView* alertView;
}

@end

@implementation RegistButton

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
        self.imageReferenceURL = @"";
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self setContentMode:UIViewContentModeCenter];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setRegistButtonType:RegistButtonType_Entry];
        [self addTarget:self action:@selector(photoUploadButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

-(void)setRegistButtonType:(RegistButtonType)buttonType {
    registButtonType = buttonType;
    return ;
}

-(UIViewController*)findSuperViewController {
    for (UIView* next = self.superview; next; next = next.superview) {
        UIResponder* responder = next.nextResponder;
        if([responder isKindOfClass:[UIViewController class]]){
            return (UIViewController*)responder;
        }
    }
    return nil;
}

-(void)photoUploadButtonPressed:(UIButton*)sender {
    if(registButtonType == RegistButtonType_Entry)
        return ;
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择照片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相",@"图库", nil];
    [actionSheet showInView:self.superview];
    return ;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, contentRect.size.height*(1-TITLE_RATIO), contentRect.size.width, contentRect.size.height*TITLE_RATIO);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height*(1-TITLE_RATIO));
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIViewController* superViewController = [self findSuperViewController];
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    switch (buttonIndex) {
        case 0:
        {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
                [superViewController presentViewController:imagePicker animated:YES completion:^{
                }];
            }else{
                alertView = [[CLAlertView alloc] initWithTitle:@"错误" frame:CGRectMake(0, 0, 250, 200) message:@"摄像头不可用，请检查设备" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }
        }
            break;
            
        case 1:
        {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                [superViewController presentViewController:imagePicker animated:YES completion:^{
                }];
            }else{
                alertView = [[CLAlertView alloc] initWithTitle:@"错误" frame:CGRectMake(0, 0, 255, 255) message:@"相册资源不可用，请检查设备" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }
        }
            break;
            
        default:
            break;
    }
    return ;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage* sourceImage = (UIImage*)info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self setImage:sourceImage forState:UIControlStateNormal];
        self.imageReferenceURL = [NSString stringWithFormat:@"%@",(NSURL*)info[UIImagePickerControllerReferenceURL]];
    }];
    return ;
}

@end