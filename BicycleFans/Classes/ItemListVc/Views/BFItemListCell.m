//
//  BFItemListCell.m
//  BicycleFans
//
//  Created by Mac on 2020/9/12.
//  Copyright © 2020 sport. All rights reserved.
//

#import "BFItemListCell.h"

@interface BFItemListCell ()

@property (strong, nonatomic) UIView *bgView;

@property (strong, nonatomic) UILabel *nameLabel;

@property (strong, nonatomic) UIImageView *iconImg;

@property (strong, nonatomic) UIImageView *arrowImg;

@end

@implementation BFItemListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [self setupSubViews];
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

- (void)setupSubViews {
    [self bgView];
    [self iconImg];
    [self nameLabel];
    [self arrowImg];
}

#pragma mark - getter
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = RGBACOLOR(80,122,135, 1);
        _bgView.layer.cornerRadius = 3;
        _bgView.layer.shadowOffset = CGSizeMake(0, 1);
        
//        _bgView.layer.shadowRadius = 5;
//        _bgView.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor;
//        _bgView.layer.shadowOpacity = 0.3;
        [self addSubview:_bgView];
        
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
            make.top.equalTo(self).offset(10);
            make.bottom.equalTo(self).offset(-10);
        }];
    }
    
    return _bgView;
}

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [UIImageView new];
        _iconImg.layer.cornerRadius = 65/2.0f;
        _iconImg.layer.masksToBounds = YES;        
        [self.bgView addSubview:_iconImg];
        
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(20);
            make.centerY.equalTo(self.bgView);
            make.width.height.mas_offset(65);
        }];
    }
    return _iconImg;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:_nameLabel];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImg.mas_right).offset(15);
            make.centerY.equalTo(self.iconImg);
        }];
    }
    return _nameLabel;
}

- (UIImageView *)arrowImg {
    if (!_arrowImg) {
        _arrowImg = [UIImageView new];
        _arrowImg.image = [UIImage imageNamed:@"rightArrow"];
        [self addSubview:_arrowImg];
        
        [_arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bgView.mas_right).offset(-15);
            make.centerY.equalTo(self.bgView);
            make.width.height.mas_offset(20);
        }];
    }
    return _arrowImg;
}

#pragma mark - setter
- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    
    if (self.array.count > 0) {
        self.iconImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%ld",indexPath.row + 1]];
        self.nameLabel.text = self.array[indexPath.row];
        self.nameLabel.font = [UIFont systemFontOfSize:15];
    }
}


@end
