//
//  RegistBaseViewController.h
//  WantBuyCar
//
//  Created by 王落凡 on 15/5/14.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "RegistModel.h"
#import "CLAlertView.h"

typedef enum {
    RegistType_Buyer,RegistType_Saler
}RegistType;

@interface RegistBaseViewController : UIViewController

-(void)addControlsWithArray:(NSArray*)contentArray yOrigin:(CGFloat)yOrigin;
-(RegistErrorType)registUserWithDictionary:(NSDictionary*)userInfoDict userType:(RegistType)userType;
-(void)completeRegistBtnClicked:(UIButton*)sender;
-(NSString*)formatErrorInfo:(RegistErrorType)errorType;

@property(nonatomic,strong) CLAlertView* alertView;
@property(nonatomic,strong) NSMutableArray* registItemArray;

@end
