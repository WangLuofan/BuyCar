//
//  ChatTableViewController.m
//  要买车
//
//  Created by 王落凡 on 15/5/5.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "ChatTabView.h"
#import "ConstantDef.h"
#import "ChatTableViewCell.h"
#import "ChatTableViewController.h"
#import "EMSDKFull.h"

@interface ChatTableViewController ()<UITableViewDataSource,UITableViewDelegate,ChatTabViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,EMChatManagerDelegate> {
    ChatTabView* chatTabView;
    NSMutableArray* chatTableViewCellArray;
    EMConversation* emConversation;
}

@end

@implementation ChatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"聊天界面"];
    
    self.chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kChatTabHeight) style:UITableViewStylePlain];
    [self.chatTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.chatTableView setDelegate:self];
    [self.chatTableView setDataSource:self];
    [self.chatTableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchesBackGround)]];
    [self.view addSubview:self.chatTableView];
    
    chatTabView = [[ChatTabView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kChatTabHeight, kScreenWidth, kChatTabHeight)];
    [chatTabView setDelegate:self];
    [self.view addSubview:chatTabView];
    
    if(chatTableViewCellArray == nil)
        chatTableViewCellArray=[[NSMutableArray alloc] init];
    [chatTableViewCellArray removeAllObjects];
    
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    if (![[EaseMob sharedInstance].chatManager isAutoLoginEnabled]) {
        [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
    }
    
    EMError* __autoreleasing error = nil;
    NSString* userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
    NSString* password = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
    [[EaseMob sharedInstance].chatManager registerNewAccount:userName password:password error:&error];
    if([[EaseMob sharedInstance].chatManager loginWithUsername:userName password:password error:nil])
        NSLog(@"登陆成功");
}

-(void)decodeChatInfo {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"TestChat" ofType:@"plist"];
    
    NSArray* contentArr=[[NSArray alloc] initWithContentsOfFile:filePath];
    for(int i=0;i!=contentArr.count;++i) {
        BOOL bDirFrom = [contentArr[i][@"direction"] isEqualToString:@"from"];
        ChatTableViewCell* cell = [[ChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bDirFrom?@"ChatFromCellIdentifier":@"ChatToCellIdentifier" chatDirection:bDirFrom?CHAT_TYPE_FROM:CHAT_TYPE_TO];
        [cell setMessageDateWithString:contentArr[i][@"date"]];
        [cell setMessageContentWithType:MESSAGE_TYPE_TEXT contents:contentArr[i][@"message"]];
        
        [chatTableViewCellArray addObject:cell];
    }
    return ;
}

-(void)touchesBackGround {
    [chatTabView resignFirstResponder];
    return ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return chatTableViewCellArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatTableViewCell* cell = (ChatTableViewCell*)chatTableViewCellArray[indexPath.row];
    [cell.headerImage setImage:[UIImage imageNamed:@"liaottx"]];
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatTableViewCell* cell = (ChatTableViewCell*)chatTableViewCellArray[indexPath.row];
    return [cell cellHeight];
}

#pragma mark - ChatTabViewDelegate
-(void)tabView:(ChatTabView *)tabView message:(NSString *)message {
    [self sendMessageByType:MESSAGE_TYPE_TEXT contents:message];
    return ;
}

-(void)sendMessageByType:(MessageType)messageType contents:(id)message{
    if([message isKindOfClass:[NSString class]]) {
        if([message isEqualToString:@""])
        {
            [self.chatTableView setContentOffset:CGPointMake(0, self.chatTableView.contentSize.height-self.chatTableView.bounds.size.height) animated:YES];
            return ;
        }
    }
    
    ChatTableViewCell* cell = [[ChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatToCellIdentifier" chatDirection:CHAT_TYPE_TO];
    [cell.headerImage setImage:[UIImage imageNamed:@"liaottx"]];
    
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    [cell setMessageDateWithString:[fmt stringFromDate:[NSDate date]]];
    EMMessage* emMessage = (EMMessage*)[cell setMessageContentWithType:messageType contents:message];
    
    [chatTableViewCellArray addObject:cell];
    [self.chatTableView reloadData];
    
    //表格滚动到最底部
    if(self.chatTableView.contentSize.height>=self.chatTableView.frame.size.height)
        [self.chatTableView setContentOffset:CGPointMake(0, self.chatTableView.contentSize.height-self.chatTableView.bounds.size.height) animated:YES];
    
    if(emConversation==nil) {
        emConversation = [[EaseMob sharedInstance].chatManager conversationForChatter:@"wangluofan" isGroup:YES];
    }
    [[EaseMob sharedInstance].chatManager sendMessage:emMessage progress:nil error:nil];
    return ;
}

-(void)chooseImageButtonPressed {
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:imagePicker animated:YES completion:^{
        }];
    }
    return ;
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        [self sendMessageByType:MESSAGE_TYPE_IMAGE contents:info[UIImagePickerControllerOriginalImage]];
    }];
    return ;
}

-(void)didReceiveMessage:(EMMessage *)message {
    ChatTableViewCell* cell = [[ChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatToCellIdentifier" chatDirection:CHAT_TYPE_FROM];
    [cell.headerImage setImage:[UIImage imageNamed:@"liaottx"]];
    
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    [cell setMessageDateWithString:[fmt stringFromDate:[NSDate date]]];
    
    id<IEMMessageBody> msgBody = message.messageBodies.firstObject;
    switch (msgBody.messageBodyType) {
        case eMessageBodyType_Text:
        {
            // 收到的文字消息
            NSString *txt = ((EMTextMessageBody *)msgBody).text;
            [cell setMessageContentWithType:MESSAGE_TYPE_TEXT contents:txt];
        }
            break;
        case eMessageBodyType_Image:
        {
            // 得到一个图片消息body
            EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
            [cell setMessageContentWithType:MESSAGE_TYPE_IMAGE contents:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:body.remotePath]]]];
        }
            break;
        default:
            break;
    }
    
    [chatTableViewCellArray addObject:cell];
    [self.chatTableView reloadData];
    
    return ;
}

-(void)dealloc {
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

@end