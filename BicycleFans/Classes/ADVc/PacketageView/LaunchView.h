//
//  LaunchView.h
//  XGameLover
//
//  Created by bifen on 2020/7/6.
//  Copyright © 2020 sport. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LaunchView : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, strong) NSMutableArray *pictureArray;

@property (nonatomic, strong) UIColor *bgColor;

@property (nonatomic, strong) UIColor *fontColor;

- (void)showView;

@end

NS_ASSUME_NONNULL_END
