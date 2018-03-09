//
//  PAODemoViewController.m
//  PAOImage
//
//  Created by xsd on 2018/3/6.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import "PAODemoViewController.h"
#import "PAODemoView.h"

@interface PAODemoViewController ()

@property (nonatomic, strong) PAODemoView *demoView;

@end

@implementation PAODemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.demoView];
}



- (PAODemoView *)demoView {
    if (!_demoView) {
        _demoView = [[PAODemoView alloc] initWithFrame:self.view.frame];
    }
    return _demoView;
}
@end
