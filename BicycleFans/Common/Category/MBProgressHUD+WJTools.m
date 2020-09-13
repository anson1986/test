//
//  MBProgressHUD+WJTools.m
//  Kevin
//
//  Created by Kevin on 13/1/14.
//  Copyright (c) 2013年 Kevin. All rights reserved.
//  封装MBProgressHUD常用方法

#import "MBProgressHUD+WJTools.h"
@interface MBProgressHUD ()

@end
@implementation MBProgressHUD (WJTools)

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.labelText = text;
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    // 设置图片
    //Edward Lam
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",icon]];//[[UIImage imageNamed:[NSString stringWithFormat:@"%@",icon]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima.toValue = @(1.5);
    anima.duration = 1.f;
    anima.repeatCount = 5;
    [imgView.layer addAnimation:anima forKey:nil];
    //
    hud.customView = imgView;//[[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.font = [UIFont systemFontOfSize:15];
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 2秒之后再消失
//    [hud hide:YES afterDelay:2.0];
    [hud hideAnimated:YES afterDelay:1.5];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

#pragma mark 显示成功信息
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
//+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view mode:(MBProgressHUDMode)mode{
////    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
////    // 快速显示一个提示信息
////    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
////    hud.labelText = message;
////    hud.mode = mode;
////    // 隐藏时候从父控件中移除
////    hud.removeFromSuperViewOnHide = YES;
////    // YES代表需要蒙版效果
////    hud.dimBackground = YES;
////    [hud hide:YES afterDelay:2.0];
//
//    return hud;
//}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message mode:(MBProgressHUDMode)mode
{
    return [self showMessage:message toView:nil mode:mode];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}


- (instancetype)customProgressHUD:(UIView *)desitinationView customedText:(NSString *)customedText {
    
    MBProgressHUD  *HUD = [[MBProgressHUD alloc] initWithView:desitinationView];
    
    [desitinationView addSubview:HUD];
    
    HUD.label.text = customedText;
    
    [HUD showAnimated:YES];
    
    return HUD;
}

@end
