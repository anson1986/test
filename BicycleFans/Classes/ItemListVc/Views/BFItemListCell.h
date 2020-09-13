//
//  BFItemListCell.h
//  BicycleFans
//
//  Created by Mac on 2020/9/12.
//  Copyright © 2020 sport. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BFItemListCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
