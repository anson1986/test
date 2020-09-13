//
//  LaunchView.m
//  XGameLover
//
//  Created by bifen on 2020/7/6.
//  Copyright © 2020 sport. All rights reserved.
//

#import "LaunchView.h"

@interface LaunchView ()

@end

@implementation LaunchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
    }
    
    return self;
}

- (void)showView {
    //标题
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = self.title;
    titleLabel.textColor = self.fontColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:30];
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(200);
        make.left.right.equalTo(self).offset(0);
    }];
    
    //副标题
    UILabel *subTitleLab = [UILabel new];
    subTitleLab.text = self.subTitle;
    subTitleLab.textColor = self.fontColor;
    subTitleLab.textAlignment = NSTextAlignmentCenter;
    subTitleLab.font = [UIFont fontWithName:@"AmericanTypewriter" size:15];
    [self addSubview:subTitleLab];
    
    [subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(8);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
    }];
    
    self.backgroundColor = self.bgColor;
    CGFloat width = (WindowWidth - 50*2 - 10*3)/4;
    
    for (int i = 0; i < self.pictureArray.count; i ++) {
        UIImageView *imgView = [UIImageView new];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.image = [UIImage imageNamed:self.pictureArray[i]];
        imgView.layer.masksToBounds = YES;
        imgView.layer.cornerRadius = width/2.0f;
        imgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        imgView.layer.borderWidth = 3;
        [self addSubview:imgView];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(300 + i/4*(width + 10));
            make.left.equalTo(self).offset(50 + i%4*(width + 10));
            make.width.height.mas_offset(width);
        }];
    }
}

@end
