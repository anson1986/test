//
//  KMCarouseContentCell.m
//  KuMi
//
//  Created by Mac on 2020/8/17.
//  Copyright © 2020 foods. All rights reserved.
//

#import "KMCarouseContentCell.h"

@interface KMCarouseContentCell ()

@property (nonatomic, strong) UIImageView *advImgView;

@end

@implementation KMCarouseContentCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
//        [self setupSubviews];
//        self.backgroundColor = [UIColor orangeColor];
        [self advImgView];
    }

    return self;
}

- (UIImageView *)advImgView {
    if (!_advImgView) {
        _advImgView = [UIImageView new];
        _advImgView.contentMode = UIViewContentModeScaleAspectFill;
        _advImgView.layer.masksToBounds = YES;
        [self addSubview:_advImgView];
        
        [_advImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _advImgView;
}

- (void)setImgName:(NSString *)imgName {
    _imgName = imgName;
    self.advImgView.image = [UIImage imageNamed:imgName];
}

@end
