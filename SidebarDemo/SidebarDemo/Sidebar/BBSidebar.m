//
//  BBSidebar.m
//  SidebarDemo
//
//  Created by 红鹊豆 on 2018/3/28.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

#import "BBSidebar.h"
#import "BBSTableView.h"

#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define NAV_HEIGHT (IS_IPHONE_X ? 88 : 64)

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface BBSidebar ()

@property (nonatomic, strong) BBSTableView *tableView;

@property (nonatomic, strong) UIWindow *window;
// 底视图
@property (nonatomic, strong) UIButton *baseView;
// 背部阴影
@property (nonatomic, strong) UIImageView *shadowView;
// 右侧阴影
@property (nonatomic, strong) UIImageView *rightShadowView;

@end

@implementation BBSidebar

static BBSidebar *sidebar = nil;
+ (instancetype)sharedManage {
    static dispatch_once_t onceTokey;
    dispatch_once(&onceTokey, ^{
        sidebar = [[self alloc] init];
    });
    return sidebar;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _shadowView = [[UIImageView alloc] init];
        _shadowView.userInteractionEnabled = YES;
        _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        _shadowView.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT);
        [self.window addSubview:self.shadowView];
        
        _baseView = [UIButton buttonWithType:UIButtonTypeCustom];
        _baseView.adjustsImageWhenHighlighted = NO;
        _baseView.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [_baseView addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchDown];
        [self.window addSubview:self.baseView];
        
        [_baseView addSubview:self.tableView];
        
        _rightShadowView = [[UIImageView alloc] init];
        _rightShadowView.backgroundColor = [UIColor redColor];
        _rightShadowView.frame = CGRectMake(SCREEN_WIDTH * 0.75, NAV_HEIGHT, 10, SCREEN_HEIGHT - NAV_HEIGHT);
//        _rightShadowView.image = [UIImage imageNamed:@""];
        [_baseView addSubview:_rightShadowView];
        
    }
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceTokey;
    dispatch_once(&onceTokey, ^{
        sidebar = [super allocWithZone:zone];
    });
    return sidebar;
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [BBSidebar sharedManage];
}

- (void)setListData:(NSArray *)list call:(void(^)(NSIndexPath *indexPath))block {
    
    self.tableView.list = list;
    self.tableView.clickItem = block;
    
    [self show];
}

- (void)show {
    _baseView.hidden   = NO;
    _shadowView.hidden = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        _baseView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:0.3 animations:^{
        _baseView.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        _baseView.hidden   = YES;
        _shadowView.hidden = YES;
    }];
    
}

#pragma mark - get
- (UIWindow *)window {
    if (!_window) {
        _window = [[UIApplication sharedApplication].delegate window];
    }
    return _window;
}

- (BBSTableView *)tableView {
    if (!_tableView) {
        _tableView = [[BBSTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH * 0.75, SCREEN_HEIGHT - NAV_HEIGHT);
    }
    return _tableView;
}

- (UIFont *)font {
    if (!_font) {
        _font = [UIFont systemFontOfSize:17];
    }
    return _font;
}

- (UIColor *)textColor {
    if (!_textColor) {
        _textColor = [UIColor whiteColor];
    }
    return _textColor;
}


@end
