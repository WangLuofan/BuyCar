//
//  CLSegmentedControl.m
//  要买车
//
//  Created by 王落凡 on 15/4/28.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "CLSegmentedControl.h"
#import "CLSegmentedItem.h"

@interface CLSegmentedControl () <CLSegmentedItemDelegate> {
    NSMutableArray* segmentedItemArray;
    CLSegmentedItem* selectedSegmentedItem;
    NSMutableArray* seperatorViewArray;
}

@end

@implementation CLSegmentedControl

-(instancetype)initWithFrame:(CGRect)frame style:(CLSegmentedControlStyle)style{
    self = [super initWithFrame:frame];
    
    if(self) {
        [self.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.layer setBorderWidth:0.5f];
        [self.layer setMasksToBounds:YES];
        
        segmentedItemArray = [[NSMutableArray alloc] init];
        
        if(style==CLSegmentedControlStyleRound)
            [self.layer setCornerRadius:5.0f];
    }
    
    return self;
}

-(void)addItemByTitle:(NSString *)title Image:(NSString *)image {
    CLSegmentedItem* item=[[CLSegmentedItem alloc] initWithTitle:title Image:image];
    [item setDelegate:self];
    [item setTag:(NSInteger)segmentedItemArray.count];
    [segmentedItemArray addObject:item];
    [self addSubview:item];
    
    for(int i=0;i!=segmentedItemArray.count;++i)
    {
        CLSegmentedItem* subItem = (CLSegmentedItem*)segmentedItemArray[i];
        [subItem setFrame:CGRectMake(i*self.bounds.size.width/segmentedItemArray.count, 0, self.bounds.size.width/segmentedItemArray.count-0.5f, self.bounds.size.height)];
    }
    [self addSeperatorLine];
    if(self.subviews.count>0) {
        [self.subviews[0] setSelected:YES];
        selectedSegmentedItem=self.subviews[0];
    }
    
    return;
}

//-(void)addItemsByTitle:(NSString *)title, ... {
//    
//    for (UIView* view in self.subviews)
//        [view removeFromSuperview];
//    
//    va_list argList;
//    NSString* arg;
//    [segmentedItemArray removeAllObjects];
//    [segmentedItemArray addObject:title];
//    
//    va_start(argList, title);
//    while((arg=va_arg(argList, NSString*))) {
//        [segmentedItemArray addObject:arg];
//    }
//    va_end(argList);
//    
//    CGSize itemSize=CGSizeMake(self.frame.size.width/segmentedItemArray.count, self.frame.size.height);
//    for(int i=0;i!=segmentedItemArray.count;++i) {
//        CLSegmentedItem* item = [[CLSegmentedItem alloc] initWithTitle:(NSString*)segmentedItemArray[i] Image:nil];
//        [item setFrame:CGRectMake(i*itemSize.width, 0, itemSize.width, itemSize.height)];
//        [self addSubview:item];
//    }
//    
//    return ;
//}

#pragma mark - 添加分隔线
-(void)addSeperatorLine {
    //去除所有分隔线
    for (UIView* subview in self.subviews) {
        if(![subview isKindOfClass:[CLSegmentedItem class]])
            [subview removeFromSuperview];
    }
    //重新添加所有分隔线
    for(int i=1;i!=segmentedItemArray.count;++i) {
        CLSegmentedItem* subItem=(CLSegmentedItem*)segmentedItemArray[i];
        UIView* seperator = [[UIView alloc] initWithFrame:CGRectMake(subItem.frame.origin.x-0.5, subItem.frame.origin.y, 0.5f, subItem.bounds.size.height)];
        [seperator setBackgroundColor:[UIColor orangeColor]];
        [self addSubview:seperator];
    }
    
    return ;
}

-(NSInteger)selectedItemByIndex {
    return selectedSegmentedItem.tag;
}

-(void)segmentedItem:(CLSegmentedItem *)segmentedItem{
    [selectedSegmentedItem setSelected:NO];
    [segmentedItem setSelected:YES];
    selectedSegmentedItem=segmentedItem;
    
    [self.delegate segmentedControl:self selectedItemIndex:selectedSegmentedItem.tag];
    
    return ;
}

@end