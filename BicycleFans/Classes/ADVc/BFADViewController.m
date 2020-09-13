//
//  BFADViewController.m
//  BicycleFans
//
//  Created by Mac on 2020/9/12.
//  Copyright © 2020 sport. All rights reserved.
//

#import "BFADViewController.h"
#import "LaunchView.h"
#import "BFItemListViewController.h"
#import "BFNavigationController.h"

@interface BFADViewController ()

@property (nonatomic, strong) NSMutableArray *pictureArray;

@end

@implementation BFADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    [self p_setupBgView];
    [self showAnimation];
}

- (void)p_setupBgView {
    LaunchView *vc = [[LaunchView alloc] init];
    vc.title = @"智   能   家   具";
    vc.subTitle = @"Dream Life";
    vc.bgColor = MainColor;
    vc.fontColor = [UIColor whiteColor];
    vc.pictureArray = self.pictureArray;
    [self.view addSubview:vc];
    [vc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [vc showView];
}

- (void)showAnimation {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BFItemListViewController *vc = [[BFItemListViewController alloc] init];
        BFNavigationController *navi = [[BFNavigationController alloc] initWithRootViewController:vc];
        [UIApplication sharedApplication].keyWindow.rootViewController = navi;
    });
}

- (NSMutableArray *)pictureArray {
    if (!_pictureArray) {
        _pictureArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 8; i ++) {
            NSString *picName = [NSString stringWithFormat:@"0%ld",(long)i + 1];
            [_pictureArray addObject:picName];
        }
    }
    
    return _pictureArray;
}


@end
