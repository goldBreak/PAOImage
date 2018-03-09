//
//  PAOLeftView.m
//  PAOImage
//
//  Created by xsd on 2018/3/8.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import "PAOLeftView.h"

@interface PAOLeftView()

//item tableView
@property (nonatomic, strong) UITableView *itemTableView;

@end

@implementation PAOLeftView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.itemTableView];
    }
    return self;
}


#pragma mark - lazy
- (UITableView *)itemTableView {
    
    if (!_itemTableView) {
        
        _itemTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _itemTableView.showsHorizontalScrollIndicator = NO;
        _itemTableView.rowHeight = 100.;
    }
    return _itemTableView;
}
@end
