//
//  ViewController.m
//  SidebarDemo
//
//  Created by 红鹊豆 on 2018/3/28.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

#import "ViewController.h"
#import "BBSidebar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (IBAction)action:(id)sender {
    // 数据1
    NSArray *list = @[
                      @[@"title1",@"zh1"],
                      @[@"title2",@"zh2"],
                      @[@"title3",@"zh3"]
                      ];
    // 数据2
//    NSArray *list = @[
//                      @[
//                          @[@"title1",@"zh1"]
//                       ],
//                      @[
//                          @[@"title2",@"zh2"],
//                          @[@"title3",@"zh3"]
//                        ]
//                      ];
    
    [SideBarManage setListData:list call:^(NSIndexPath *indexPath) {
        NSLog(@"indexPath = %@",indexPath);
        [SideBarManage hide];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
