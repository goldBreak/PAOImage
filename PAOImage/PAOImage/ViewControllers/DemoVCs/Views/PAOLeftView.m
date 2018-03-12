//
//  PAOLeftView.m
//  PAOImage
//
//  Created by xsd on 2018/3/8.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import "PAOLeftView.h"
#import "PAOItemsModel.h"

static NSString *cellFlag = @"cellFlag";

@interface PAOLeftView()<UITableViewDelegate,UITableViewDataSource>

//item tableView
@property (nonatomic, strong) UITableView *itemTableView;
@property (nonatomic, strong) NSMutableArray *itemSource;

@end

@implementation PAOLeftView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.itemTableView];
        [self.itemTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellFlag];
    }
    return self;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.itemSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.itemSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //先用系统的，以后改成定制的
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
    
    return cell;
}


#pragma mark - lazy
- (UITableView *)itemTableView {
    
    if (!_itemTableView) {
        
        _itemTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _itemTableView.showsHorizontalScrollIndicator = NO;
        _itemTableView.rowHeight = 100.;
        _itemTableView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
    }
    return _itemTableView;
}
@end
