//
//  BBSTableView.m
//  SidebarDemo
//
//  Created by 红鹊豆 on 2018/3/28.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

#import "BBSTableView.h"
#import "BBSidebar.h"

@interface BBSCell : UITableViewCell

@end

@implementation BBSCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font      = SideBarManage.font;
        self.textLabel.textColor = SideBarManage.textColor;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.contentView.backgroundColor = [UIColor colorWithRed:53.0 / 255.0
                                                           green:123.0 / 255.0
                                                            blue:116.0 / 255.0
                                                           alpha:1];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat imgWH = 30;
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = 44;
    
    self.imageView.frame = CGRectMake(width - 20 - imgWH, height / 2 - imgWH / 2, imgWH, imgWH);
    self.textLabel.frame = CGRectMake(15, 0, width - 15 - 20 -imgWH, height);
}

@end

@interface BBSTableView () <UITableViewDelegate, UITableViewDataSource> {
    BOOL _isGrouped;
}

@end

@implementation BBSTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        _isGrouped = NO;
        self.rowHeight = 44;
        self.delegate = self;
        self.dataSource = self;
        self.sectionHeaderHeight = 20;
        self.sectionFooterHeight = 0.001f;
        self.tableFooterView = [UIView new];
        self.backgroundColor = [UIColor blackColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_isGrouped) {
        return self.list.count;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isGrouped) {
        NSArray *data = self.list[section];
        return data.count;
    } else {
        return self.list.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    BBSCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[BBSCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
    }
    NSArray *data;
    if (_isGrouped) {
        NSArray *firstColumn = self.list[indexPath.section];
        data = firstColumn[indexPath.row];
    } else {
        data = self.list[indexPath.row];
    }
    
    if (data.count >= 2) {
        cell.textLabel.text = data[0];
        cell.imageView.image = [UIImage imageNamed:data[1]];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.clickItem) self.clickItem(indexPath);
}

- (void)setList:(NSArray *)list {
    _list = list;
    
    if (list.count == 0) { return; }
    
    NSArray *firstColumn = list[0];
    
    if (firstColumn.count && [firstColumn[0] isKindOfClass:[NSArray class]]) {
        _isGrouped = YES;
    }
    
    [self reloadData];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
