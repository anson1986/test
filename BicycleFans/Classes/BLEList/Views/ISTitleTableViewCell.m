//
//  ISTitleTableViewCell.m
//  IslandFans
//
//  Created by Mac on 2020/8/27.
//  Copyright © 2020 traval. All rights reserved.
//

#import "ISTitleTableViewCell.h"

@interface ISTitleTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ISTitleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self titleLabel];
        self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        [self addSubview:self.activityIndicator];
        //设置小菊花颜色
        self.activityIndicator.color = [UIColor blackColor];
        //刚进入这个界面会显示控件。并且停止旋转也会显示，只是没有在转动而已。
        self.activityIndicator.hidesWhenStopped = NO;
        
        [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(40);
            make.left.equalTo(self.titleLabel.mas_right).offset(5);
        }];
        
        [self.activityIndicator startAnimating];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"设备搜索中";
        _titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self);
        }];
    }
    return _titleLabel;
}

@end
