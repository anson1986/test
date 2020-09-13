//
//  BFBaseViewController.m
//  BicycleFans
//
//  Created by bifen on 2020/7/6.
//  Copyright © 2020 sport. All rights reserved.
//

#import "BFBaseViewController.h"

@interface BFBaseViewController ()

@end

@implementation BFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:@"back_white"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
     self.p_backBtn = backButton;
     [backButton setBackgroundColor:[UIColor clearColor]];
     if (image) {
         [backButton setImage:image forState:UIControlStateNormal];
         [backButton setImage:image forState:UIControlStateHighlighted];
     } else {
         backButton.titleLabel.font = KM_PingFangRegular_Font(16);
         [backButton setTitle:nil forState:UIControlStateNormal];
         if (!nil) {
             [backButton setTitleColor:KM_RGBColor(30, 30, 30) forState:UIControlStateNormal];
         }
     }
     [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
     backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
     self.navigationItem.leftBarButtonItem.style = UIBarButtonItemStylePlain;
}

- (void)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
