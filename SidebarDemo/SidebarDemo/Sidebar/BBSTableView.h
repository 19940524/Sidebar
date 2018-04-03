//
//  BBSTableView.h
//  SidebarDemo
//
//  Created by 红鹊豆 on 2018/3/28.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickItem)(NSIndexPath *indexPath);

@interface BBSTableView : UITableView

@property (nonatomic, copy) NSArray *list;

@property (nonatomic, assign) ClickItem clickItem;

@end
