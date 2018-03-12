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
        self.backgroundColor = [UIColor blackColor];
        [self instanceSource];
        [self addSubview:self.itemTableView];
        [self.itemTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellFlag];
    }
    return self;
}

- (void)instanceSource {
    //初始化Source
    
    //暂时先用代码手动创建，以后用个plist文件夹存储
    PAOItemsModel *cameraItem = [PAOItemsModel new];
    cameraItem.itemName = @"摄像机";
    cameraItem.itemImage = nil;
    
    PAOItemsModel *imageLibItem = [PAOItemsModel new];
    imageLibItem.itemName = @"相册";
    imageLibItem.itemImage = nil;
    [self.itemSource addObject:@{@"图片获取":@[cameraItem,imageLibItem]}];
    
    //滤镜
    PAOItemsModel *filterModel = [PAOItemsModel new];
    filterModel.itemName = @"滤镜";
    [self.itemSource addObject:@{@"滤镜":@[filterModel]}];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.itemSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.itemSource[section] allValues][0] count];
//    return [self.itemSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //先用系统的，以后改成定制的
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    PAOItemsModel *model = [self.itemSource[indexPath.section] allValues][0][indexPath.row];
    cell.textLabel.text = model.itemName;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:model.itemImage];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     PAOItemsModel *model = [self.itemSource[indexPath.section] allValues][0][indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(itemDidSelcted:)]) {
        [self.delegate itemDidSelcted:model];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
#pragma mark - lazy
- (UITableView *)itemTableView {
    
    if (!_itemTableView) {
        
        _itemTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _itemTableView.showsHorizontalScrollIndicator = NO;
        _itemTableView.rowHeight = 100.;
        _itemTableView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
        _itemTableView.delegate = self;
        _itemTableView.dataSource = self;
    }
    return _itemTableView;
}

- (NSMutableArray *)itemSource {
    
    if (!_itemSource) {
        _itemSource = [NSMutableArray array];
    }
    return _itemSource;
}
@end
