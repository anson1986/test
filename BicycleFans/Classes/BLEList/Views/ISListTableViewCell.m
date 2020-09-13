//
//  ISListTableViewCell.m
//  IslandFans
//
//  Created by Mac on 2020/8/27.
//  Copyright © 2020 traval. All rights reserved.
//

#import "ISListTableViewCell.h"

@interface ISListTableViewCell ()

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIImageView *arrowImgView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ISListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self lineView];
        [self titleLabel];
        [self nameLabel];
        [self arrowImgView];
        
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

#pragma mark -- getter
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [self addSubview:_lineView];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self).offset(0);
            make.height.mas_offset(0.5);
        }];
    }
    
    return _lineView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.text = @"Wbx0045498353";
        _nameLabel.textColor = [UIColor whiteColor];
        [self addSubview:_nameLabel];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.titleLabel.mas_right).offset(8);
        }];
    }
    
    return _nameLabel;
}

- (UIImageView *)arrowImgView {
    if (!_arrowImgView) {
        _arrowImgView = [UIImageView new];
        _arrowImgView.image = [UIImage imageNamed:@"rightArrow_charge"];
        [self addSubview:_arrowImgView];
        
        [_arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-20);
            make.centerY.equalTo(self);
            make.width.height.mas_offset(12);
        }];
    }
    
    return _arrowImgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"设备名称:";
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(10);
            make.width.height.mas_offset(80);
        }];
    }
    return _titleLabel;
}

@end
