//
//  BLListViewController.h
//  BicycleFans
//
//  Created by Mac on 2020/9/12.
//  Copyright © 2020 sport. All rights reserved.
//

#import "BFBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BLListViewController : BFBaseViewController

@property (nonatomic, assign) NSInteger type;

/**
    蓝牙方法
 */
- (void)setBaseviewBluetoothDelegate;

-(void)removeBaseviewBluetoothDelegate;

@end

NS_ASSUME_NONNULL_END
