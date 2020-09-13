//
//  SAJBLEPort.h
//  SAJ
//
//  Created by anson on 2017/11/10.
//  Copyright © 2017年 Guangzhou Sanjing Electric CO., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface SAJBLEPort : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) CBPeripheral *peripheral;

@end
