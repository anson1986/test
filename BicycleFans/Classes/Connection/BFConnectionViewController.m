//
//  BFConnectionViewController.m
//  BicycleFans
//
//  Created by Mac on 2020/9/12.
//  Copyright © 2020 sport. All rights reserved.
//

#import "BFConnectionViewController.h"
#import "SVProgressHUD.h"
#import "BLListViewController.h"

@interface BFConnectionViewController ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation BFConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"连接方式";
    self.view.backgroundColor = MainColor;
    [self setupSubViews];
}

- (void)setupSubViews {
    
    UIImageView *iconImgView = [UIImageView new];
    iconImgView.image = [UIImage imageNamed:self.imgName];
    iconImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:iconImgView];
    
    [iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(35);
        make.right.equalTo(self.view).offset(-35);
        make.top.equalTo(self.view).offset(120);
        make.height.mas_offset(150);
    }];
    
    UIButton *bleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bleBtn setTitle:@"蓝牙" forState:UIControlStateNormal];
    [bleBtn addTarget:self action:@selector(clickBleButton:) forControlEvents:UIControlEventTouchUpInside];
    bleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    bleBtn.backgroundColor = RGBACOLOR(80,122,135, 1);
    bleBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    bleBtn.layer.borderWidth = 3;
    bleBtn.layer.cornerRadius = 80/2;
    [self.view addSubview:bleBtn];
    
    [bleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(80);
        make.centerY.equalTo(self.view);
        make.right.equalTo(self.view.mas_centerX).offset(-35);
    }];
    
    UIButton *wifiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wifiBtn setTitle:@"Wifi" forState:UIControlStateNormal];
    wifiBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    wifiBtn.backgroundColor = RGBACOLOR(80,122,135, 1);
    [wifiBtn addTarget:self action:@selector(clickWifiButton:) forControlEvents:UIControlEventTouchUpInside];
    wifiBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    wifiBtn.layer.borderWidth = 3;
    wifiBtn.layer.cornerRadius = 80/2;
    [self.view addSubview:wifiBtn];
    
    [wifiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(80);
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view.mas_centerX).offset(35);
    }];
}

- (void)clickBleButton:(UIButton *)sender {
    BLListViewController *listVC = [[BLListViewController alloc] init];
    [self.navigationController pushViewController:listVC animated:YES];
}

- (void)clickWifiButton:(UIButton *)sender {
    [SVProgressHUD showSuccessWithStatus:@"程序员奋力开发中，敬请期待哦！"];
}

@end
