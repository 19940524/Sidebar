//
//  BBSidebar.h
//  SidebarDemo
//
//  Created by 红鹊豆 on 2018/3/28.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define SideBarManage [BBSidebar sharedManage]

@interface BBSidebar : NSObject

+ (instancetype)sharedManage;

/**
 标题字体
 */
@property (nonatomic, strong) UIFont *font;

/**
 标题颜色
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 显示
 */
- (void)show;

/**
 隐藏
 */
- (void)hide;

/**
 设置列表标题与图标
 @param list
 
 @[
    @[@"标题",@"图片"],@[@"标题",@"图片"]
  ]
 或
 @[
    @[@[@"标题",@"图片"]],
    @[@[@"标题",@"图片"],@[@"标题",@"图片"]]
  ]
 */
- (void)setListData:(NSArray *)list call:(void(^)(NSIndexPath *indexPath))block;

@end
