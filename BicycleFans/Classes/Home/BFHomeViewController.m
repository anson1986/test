//
//  BFHomeViewController.m
//  BicycleFans
//
//  Created by Mac on 2020/9/12.
//  Copyright © 2020 sport. All rights reserved.
//

#import "BFHomeViewController.h"
#import "SAJBLEPort.h"
#import "SAJBluetoothCenter.h"
#import "SVProgressHUD.h"

@interface BFHomeViewController ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UILabel *resutlLabel;

@end

@implementation BFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    self.title = @"遥   控";
    [self setupSubViews];
}

- (void)setupSubViews {
    UIImageView *imgView = [UIImageView new];
    imgView.image = [UIImage imageNamed:@"logo"];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.layer.masksToBounds = YES;
    [self.view addSubview:imgView];

    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.mas_offset(200);
    }];
    
    UIButton *openButton = [UIButton buttonWithType:UIButtonTypeCustom];
    openButton.backgroundColor = RGBACOLOR(80,122,135, 1);
    [openButton setTitle:@"开" forState:UIControlStateNormal];
    [openButton addTarget:self action:@selector(openClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openButton];
    
    [openButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(WindowWidth/4);
        make.height.mas_offset(45);
        make.top.equalTo(imgView.mas_bottom).offset(50);
        make.right.equalTo(self.view.mas_centerX).offset(-25);
    }];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.backgroundColor = RGBACOLOR(80,122,135, 1);
    [closeButton addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setTitle:@"关" forState:UIControlStateNormal];
    [self.view addSubview:closeButton];
    
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(WindowWidth/4);
        make.height.mas_offset(45);
        make.top.equalTo(imgView.mas_bottom).offset(50);
        make.left.equalTo(self.view.mas_centerX).offset(25);
    }];
    
    UIButton *firstClass = [UIButton buttonWithType:UIButtonTypeCustom];
    firstClass.backgroundColor = RGBACOLOR(80,122,135, 1);
    [firstClass setTitle:@"第一档" forState:UIControlStateNormal];
    [firstClass addTarget:self action:@selector(clickFirstClass:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstClass];
    
    [firstClass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(WindowWidth/4);
        make.height.mas_offset(45);
        make.top.equalTo(openButton.mas_bottom).offset(20);
        make.right.equalTo(self.view.mas_centerX).offset(-25);
    }];
    
    UIButton *secondClass = [UIButton buttonWithType:UIButtonTypeCustom];
    secondClass.backgroundColor = RGBACOLOR(80,122,135, 1);
    [secondClass addTarget:self action:@selector(clickSecondClass:) forControlEvents:UIControlEventTouchUpInside];
    [secondClass setTitle:@"第二档" forState:UIControlStateNormal];
    [self.view addSubview:secondClass];
    
    [secondClass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(WindowWidth/4);
        make.height.mas_offset(45);
        make.top.equalTo(openButton.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_centerX).offset(25);
    }];
    
    UIButton *thirdClass = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdClass.backgroundColor = RGBACOLOR(80,122,135, 1);
    [thirdClass addTarget:self action:@selector(clickThirdClass:) forControlEvents:UIControlEventTouchUpInside];
    [thirdClass setTitle:@"第三档" forState:UIControlStateNormal];
    [self.view addSubview:thirdClass];
    
    [thirdClass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(WindowWidth/4);
        make.height.mas_offset(45);
        make.top.equalTo(firstClass.mas_bottom).offset(20);
        make.right.equalTo(self.view.mas_centerX).offset(-25);
    }];
    
    UIButton *fourthClass = [UIButton buttonWithType:UIButtonTypeCustom];
    fourthClass.backgroundColor = RGBACOLOR(80,122,135, 1);
    [fourthClass addTarget:self action:@selector(clickFourthClass:) forControlEvents:UIControlEventTouchUpInside];
    [fourthClass setTitle:@"第四档" forState:UIControlStateNormal];
    [self.view addSubview:fourthClass];
    
    [fourthClass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(WindowWidth/4);
        make.height.mas_offset(45);
        make.top.equalTo(firstClass.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_centerX).offset(25);
    }];
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = RGBACOLOR(80,122,135, 1);
    [self.view addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fourthClass.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.bottom.equalTo(self.view).offset(-35);
    }];
    
    self.statusLabel = [UILabel new];
    self.statusLabel.text = [NSString stringWithFormat:@"状态:  %@",@"关"];
    self.statusLabel.font = [UIFont boldSystemFontOfSize:25];
    self.statusLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.statusLabel];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(20);
        make.centerX.equalTo(self.view);
    }];
    
    self.resutlLabel = [UILabel new];
    self.resutlLabel.font = [UIFont boldSystemFontOfSize:25];
    self.resutlLabel.numberOfLines = 0;
    self.resutlLabel.hidden = YES;
    [self.view addSubview:self.resutlLabel];
    
    [self.resutlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.statusLabel.mas_bottom).offset(15);
    }];
}

- (void)closeClick:(UIButton *)sender {
    self.statusLabel.text = [NSString stringWithFormat:@"状态:  %@",@"关"];
    [[SAJBluetoothCenter shareInstance] writeCommand:@"0x11505480" writeDatas:@[@"0"] didFinishSucceedCallback:^(NSString *dataStr) {
        
    } failedCallBack:^(NSString *error_msg) {
        
    }];
    
    [SVProgressHUD showSuccessWithStatus:@"开关状态：关"];
}

- (void)openClick:(UIButton *)sender {
    self.statusLabel.text = [NSString stringWithFormat:@"状态:  %@",@"开"];
    [[SAJBluetoothCenter shareInstance] writeCommand:@"0x11505480" writeDatas:@[@"1"] didFinishSucceedCallback:^(NSString *dataStr) {
        
    } failedCallBack:^(NSString *error_msg) {
        
    }];
    
    [SVProgressHUD showSuccessWithStatus:@"开关状态：开"];
}

- (void)clickFirstClass:(UIButton *)sender {
    [[SAJBluetoothCenter shareInstance] writeCommand:@"0x11502586" writeDatas:@[@"0"] didFinishSucceedCallback:^(NSString *dataStr) {
        
    } failedCallBack:^(NSString *error_msg) {
        
    }];
    self.resutlLabel.text = @"\n温度： 100 \n\n 时间：3分钟";
    self.resutlLabel.hidden = NO;
    [SVProgressHUD showSuccessWithStatus:@"温度：100；时间：3分钟"];
}


- (void)clickSecondClass:(UIButton *)sender {
    [[SAJBluetoothCenter shareInstance] writeCommand:@"0x1178956" writeDatas:@[@"234"] didFinishSucceedCallback:^(NSString *dataStr) {
        
    } failedCallBack:^(NSString *error_msg) {
    }];
    self.resutlLabel.text = @"\n温度： 120 \n\n 时间：5分钟";
    self.resutlLabel.hidden = NO;
    [SVProgressHUD showSuccessWithStatus:@"温度：120；时间：5分钟"];
}

- (void)clickThirdClass:(UIButton *)sender {
    [[SAJBluetoothCenter shareInstance] writeCommand:@"0x1178956" writeDatas:@[@"158"] didFinishSucceedCallback:^(NSString *dataStr) {
        
    } failedCallBack:^(NSString *error_msg) {
    }];
    self.resutlLabel.text = @"\n温度： 150 \n\n 时间：10分钟";
    self.resutlLabel.hidden = NO;
    [SVProgressHUD showSuccessWithStatus:@"温度：150；时间：10分钟"];
}

- (void)clickFourthClass:(UIButton *)sender {
    [[SAJBluetoothCenter shareInstance] writeCommand:@"0x1178956" writeDatas:@[@"345"] didFinishSucceedCallback:^(NSString *dataStr) {
        
    } failedCallBack:^(NSString *error_msg) {
    }];
    self.resutlLabel.text = @"\n温度： 200 \n\n 时间：10分钟";
    self.resutlLabel.hidden = NO;
     [SVProgressHUD showSuccessWithStatus:@"温度：200；时间：10分钟"];
}

@end
