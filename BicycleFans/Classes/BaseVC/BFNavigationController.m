//
//  BFNavigationController.m
//  BicycleFans
//
//  Created by bifen on 2020/7/6.
//  Copyright © 2020 sport. All rights reserved.
//

#import "BFNavigationController.h"

@interface BFNavigationController ()

@end

@implementation BFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupNavigationStyle];
}

- (void)p_setupNavigationStyle {
    [self.navigationBar setTranslucent:NO];
    self.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.navigationBar.barTintColor = MainColor;
    self.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationBar.translucent = NO;
}

@end
