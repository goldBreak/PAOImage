//
//  PAODemoViewController.m
//  PAOImage
//
//  Created by xsd on 2018/3/6.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#import "PAODemoViewController.h"
#import "UIImage+PAOImageUtils.h"

@interface PAODemoViewController ()

@property (nonatomic, strong) UIImageView *filterImageView;
@property (nonatomic, strong) UIImageView *originImageView;

@property (nonatomic, strong) UILabel *messageLable;

@end

@implementation PAODemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *testImage = [UIImage imageNamed:@"test.jpg"];
    
    [self.view addSubview:self.filterImageView];
    [self.view addSubview:self.originImageView];
    [self.view addSubview:self.messageLable];
    self.messageLable.text = @"更改颜色Filter";
    self.filterImageView.image = [testImage paintingWithColor:[UIColor colorWithRed:0.3 green:0.7 blue:0.7 alpha:1]];
    self.originImageView.image = testImage;
}


#pragma mark - lazy
- (UIImageView *)filterImageView {
    
    if (!_filterImageView) {
        _filterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.originImageView.maxY , kScreenWidth, self.originImageView.height)];
        _filterImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _filterImageView;
}

- (UIImageView *)originImageView {
    
    if (!_originImageView) {
        _originImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100 , kScreenWidth, (kScreenHeight - 100)/2.)];
        _originImageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _originImageView;
}

- (UILabel *)messageLable {
    
    if (!_messageLable) {
        
        _messageLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        _messageLable.textColor = [UIColor blackColor];
        _messageLable.backgroundColor = [UIColor whiteColor];
        _messageLable.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLable;
}

@end
