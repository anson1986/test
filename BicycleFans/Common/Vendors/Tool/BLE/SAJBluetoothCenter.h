//
//  SAJBluetoothCenter.h
//  SAJ
//
//  Created by anson on 2017/11/9.
//  Copyright © 2017年 Guangzhou Sanjing Electric CO., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "SAJBLEPort.h"

typedef void (^SucceedCallback)(NSString *dataStr);

typedef void (^FaileCallBack)(NSString *error_msg);

//选择蓝牙
@protocol SAJBluetoothCenterDelegate <NSObject>

@optional
//发现设备
- (void)didFoundPortWithList:(NSMutableArray *)array;

//连接设备
- (void)connectPortSucceed;

//蓝牙不可用
- (void)unOpenBluetooth;

//蓝牙可用
- (void)bluetoothCanUse;

//断开蓝牙
- (void)bluetoothHasBeenDisconnect;

@end

@interface SAJBluetoothCenter : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic, weak) id<SAJBluetoothCenterDelegate>delegate;

@property (nonatomic, strong) CBCentralManager *CBCenter;

@property (nonatomic, strong) NSMutableArray *portsArray;

@property (nonatomic, assign) BOOL isOnLine;//在线，离线

//蓝牙回调
@property (nonatomic) SucceedCallback succeedCallBack;

@property (nonatomic) FaileCallBack failedCallBack;

//已连接的外部设备
@property (nonatomic, strong) CBPeripheral *peripheral;

+ (instancetype)shareInstance;

//搜索蓝牙
- (void)startPerialScan;

//结束搜索
- (void)stopPerialScan;

//数组清零
- (void)clearListData;

//连接蓝牙
- (void)connectPeripheral:(CBPeripheral *)peripheral;

//断开蓝牙
- (void)disconnectPeripheral;

//结束timer
- (void)invalidCountDownTimer;

//Check CRC
- (uint16_t)checkCRC:(uint8_t*)pchMsg wDataLen:(uint16_t)wDataLen;

//数据读取
- (void)readDataWithCommand:(NSString *)command didFinishSucceedCallback:(SucceedCallback)succeed failedCallBack:(FaileCallBack)faile;

//写数据
- (void)writeCommand:(NSString *)command writeDatas:(NSArray *)datas didFinishSucceedCallback:(SucceedCallback)succeed failedCallBack:(FaileCallBack)faile;

- (void)startConnectCountDown;

@end
