//
//  AppDelegate.m
//  BicycleFans
//
//  Created by bifen on 2020/7/4.
//  Copyright © 2020 sport. All rights reserved.
//

#import "AppDelegate.h"
#import "BFADViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    sleep(3.0f);
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    BFADViewController *vc = [BFADViewController new];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
