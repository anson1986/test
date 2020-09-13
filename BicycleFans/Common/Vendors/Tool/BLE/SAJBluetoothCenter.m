//
//  SAJBluetoothCenter.m
//  SAJ
//
//  Created by anson on 2017/11/9.
//  Copyright © 2017年 Guangzhou Sanjing Electric CO., Ltd. All rights reserved.
//

#import "SAJBluetoothCenter.h"
#import "Utility.h"
#define ServiceUUID  @"1002"

@interface SAJBluetoothCenter ()

@property (nonatomic, strong) CBCharacteristic *charater;

@property (nonatomic, assign) BOOL isTransferring;//蓝牙中传输中

@property (nonatomic, strong) NSMutableString *receiveDataStr;

@property (nonatomic, assign) NSInteger registerCount;//寄存器个数

@property (nonatomic, copy) NSString *writeCommandMark;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) int index;

@end

@implementation SAJBluetoothCenter

+ (instancetype)shareInstance
{
    static SAJBluetoothCenter *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
        instance.portsArray = [[NSMutableArray alloc] init];
        [instance setupBlutooth];
    });
    return instance;
}

- (NSMutableString *)receiveDataStr
{
    if (!_receiveDataStr)
    {
        _receiveDataStr = [[NSMutableString alloc] init];
    }
    return _receiveDataStr;
}

- (void)setupBlutooth
{
    self.CBCenter = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

#pragma mark -- CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state)
    {
        case CBCentralManagerStateUnknown:
            break;
        case CBCentralManagerStateResetting:
            break;
        case CBCentralManagerStateUnsupported:
            if ([self.delegate respondsToSelector:@selector(unOpenBluetooth)])
            {
                [self.delegate unOpenBluetooth];
            }

            break;
        case CBCentralManagerStateUnauthorized:
            break;
        case CBCentralManagerStatePoweredOff:
            if ([self.delegate respondsToSelector:@selector(unOpenBluetooth)])
            {
                [self.delegate unOpenBluetooth];
            }
            break;
        case CBCentralManagerStatePoweredOn:
            if ([self.delegate respondsToSelector:@selector(bluetoothCanUse)])
            {
                [self.delegate bluetoothCanUse];
            }
            break;
        default:
            break;
    }
}

//发现设备
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    
    NSLog(@"deviceName:%@",peripheral.name);
    
    //如果有返回值，则是数组里面已经存在的
    SAJBLEPort *port = [self getPortMatchWithPeriperal:peripheral];
    if (port != nil)
    {//数组已经存在此port
        NSLog(@"数组有port");
    }
    else
    {//数组还没有这个port,筛选出saj
        if (peripheral.name.length > 0)
        {
//            //saj机器SN条码规则
//            NSString *single =  @"^1\\d{3}\\w{13}$";
//            NSPredicate *siglePred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", single];
//            NSString *thirdGrid = @"^2\\d{3}\\w{13}$";
//            NSPredicate *thirdPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", thirdGrid];
//            NSString *singleStorge = @"^4\\d{3}\\w{13}$";
//            NSPredicate *storgePred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", singleStorge];
//
//            //正泰
//            NSString *zt_1 =  @"^101\\d{3}\\w{7}$";
//            NSPredicate *zt_1Pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zt_1];
//            NSString *zt_2 =  @"^101\\d{3}\\w{7}R$";
//            NSPredicate *zt_2Pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zt_2];
//            NSString *zt_3 =  @"^101\\d{3}\\w{7}D$";
//            NSPredicate *zt_3Pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zt_3];
//            NSString *zt_4 =  @"^101\\d{3}\\w{7}DR$";
//            NSPredicate *zt_4Pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zt_4];
//
//            //中民
//            NSString *zm =  @"^02S\\d{5}\\w{12}$";
//            NSPredicate *zmPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zm];
//
//            if([siglePred evaluateWithObject:peripheral.name]||[thirdPred evaluateWithObject:peripheral.name]||[storgePred evaluateWithObject:peripheral.name]||[zt_1Pred evaluateWithObject:peripheral.name]||[zt_2Pred evaluateWithObject:peripheral.name]||[zt_3Pred evaluateWithObject:peripheral.name]||[zt_4Pred evaluateWithObject:peripheral.name]||[zmPred evaluateWithObject:peripheral.name])
//            {
                NSString * identityName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
            if ([identityName containsString:@"DTU"] || [peripheral.name containsString:@"DTU"]||[identityName containsString:@"JZN"]||[peripheral.name containsString:@"JZN"])
            {
                SAJBLEPort *port = [[SAJBLEPort alloc] init];
                port.peripheral = peripheral;
                port.name = identityName;
                NSString *portName = port.name;
                
                NSString *prefixName;
                if (portName.length > 0)
                {
                    prefixName = [portName substringWithRange:NSMakeRange(0,1)];
                }
                
                if ([prefixName isEqualToString:@"1"])
                {
                    [self.portsArray insertObject:port atIndex:0];
                }
                else
                {
                    [self.portsArray addObject:port];
                }
                
                [self refreshBluetoothList];
            }
//            }
        }
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"连接成功");
    self.peripheral = peripheral;
    
    NSLog(@"peripheral:%@",peripheral.identifier.UUIDString);
    
    //在线
    self.isOnLine = YES;
    
    self.peripheral.delegate = self;
    
    [peripheral discoverServices:nil];
    
    if ([self.delegate respondsToSelector:@selector(connectPortSucceed)])
    {
        [self.delegate connectPortSucceed];
    }
}

- (void)startConnectCountDown
{
    _index = 25;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countdown) userInfo:nil repeats:YES];
     [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)countdown
{
    _index--;
    if(_index != 0)
    {
        NSLog(@"index:%zd",_index);
    }
    else
    {
//        [SAJProgressHud hidden];
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)invalidCountDownTimer
{
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark -- CBPeripheralDelegate
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    CBService *service;
    if (peripheral.services != nil && [peripheral.services isKindOfClass:[NSArray class]]&&peripheral.services.count > 0)
    {
        service = [peripheral.services objectAtIndex:0];
    }
    
    NSLog(@"service.charater:%zd",service.characteristics.count);
    if (peripheral.services.count)
    {
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

//发现特征,读写的时候需要用到特征
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    CBCharacteristic *charater = service.characteristics[0];
    NSLog(@"取得charater");
    self.charater = charater;
    NSLog(@"__charater__%@",self.charater);
    self.peripheral.delegate = self;
    //接收类似短连接 request -> response的数据（指令错误提示ff）
    [self.peripheral readValueForCharacteristic:self.charater];
    //接收设备主动传来的数据（当前硬件主要用这种形式）
    [self.peripheral setNotifyValue:YES forCharacteristic:self.charater];
}

//数据回调
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSString *dataStr = [NSString stringWithFormat:@"%s",[characteristic.value.description UTF8String]];
    /**
        一:数据的初步处理
     */
    
    NSString *delSpaceStr = [dataStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *delLeftArrow = [delSpaceStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
    NSString *finalStr = [delLeftArrow stringByReplacingOccurrencesOfString:@">" withString:@""];
    NSLog(@"__finalStr__:%@",finalStr);
    
    /**
        二:设备报错的情况
     */
    
    //报错1:确保不是ff,ff是硬件那边check crc失败后我跟他约定返回的，登录成功后苹果corebluetooth框架给硬件那边发送了一个非crc验证的数据
    if (![finalStr isEqualToString:@"ff"])
    {
        [self.receiveDataStr appendString:finalStr];
    }
    
    //报错2
    NSString *prefixStr;
    if (finalStr.length > 4)
    {
        prefixStr = [finalStr substringToIndex:4];
    }
    
    //读_报错
    if ([prefixStr isEqualToString:@"0183"])
    {
        if (self.failedCallBack)
        {
            if (finalStr.length >=6)
            {
                NSString *errorCode = [finalStr substringWithRange:NSMakeRange(4, 2)];
                NSString *error_msg = [self getErrorMsgWithErrorCode:errorCode];
                NSLog(@"__error_msg__%@",error_msg);
                self.failedCallBack(error_msg);
            }
        };
        
        //把所有的值都复原
        self.receiveDataStr = nil;
        self.registerCount = 0;
        
        //报错直接走failed，不走succeed
        return;
    }
    
    //写_报错
    if ([prefixStr isEqualToString:@"0190"])
    {
        if (self.failedCallBack)
        {
            if (finalStr.length >= 6)
            {
                NSString *errorCode = [finalStr substringWithRange:NSMakeRange(4, 2)];
                NSString *error_msg = [self getErrorMsgWithErrorCode:errorCode];
                NSLog(@"__error_msg__%@",error_msg);
                self.failedCallBack(error_msg);
            }
        }
        
        //不走succeed
        return;
    }
    
    /**
        三:设备正常运行
     */
    
    /**
        以下开始为写
     */
    if ([prefixStr isEqualToString:@"0110"])
    {
        //check CrC,正确都是返回16位
        if (finalStr.length == 16)
        {
            uint8_t buffer[8];
            
            for (int i = 0; i < 6; i ++)
            {
                buffer[i] = [self getInt:self.writeCommandMark formLoc:i*2 length:2];
            }
            
            uint16_t  crcResult = CalculateCRC16(buffer, 6);
            
            buffer[6] = (crcResult >> 0) & 0xff;
            buffer[7] = (crcResult >> 8) & 0xff;
            
            NSString *lastStr = [finalStr substringFromIndex:finalStr.length - 2];
            uint16_t back = [[Utility numberHexString:lastStr] intValue];
            uint16_t font = [[Utility numberHexString:[finalStr substringWithRange:NSMakeRange(finalStr.length - 4, 2)]] intValue];
            
            
            if ((back = buffer[6]) && (font = buffer[7]) )
            {
                if (self.succeedCallBack)
                {
                    self.succeedCallBack(finalStr);
                }
            }
        }
        
        return;
    }
    
    /**
        以下开始为读
     */
    //1.判断最后一个包
    NSInteger byteCount = 10 + self.registerCount * 4;
    //1.1 知道操作寄存器的个数，那么返回的总数已被确定
    if (self.receiveDataStr.length == byteCount && ![finalStr isEqualToString:@"ff"])
    {
        //完成数据传输
        self.isTransferring = NO;
    }
    
    if (self.isTransferring == NO)
    {
        //返回成功后回调，和http访问接口的回调方式一样
        if (self.succeedCallBack)
        {
            self.succeedCallBack([self.receiveDataStr copy]);
        }
        
        //容器清零
        self.receiveDataStr = nil;
    }
}

//开了
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"+value:%@",characteristic.value);
    NSString *characterValue = [NSString stringWithFormat:@"%@",characteristic.value];
    if(![characterValue isEqualToString:@"<ff>"])
    {
        [self.CBCenter cancelPeripheralConnection:self.peripheral];
    }
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"断开连接");
    self.isOnLine = NO;
    
    if (self.portsArray)
    {
        [self.portsArray removeAllObjects];
        self.portsArray = nil;
        self.portsArray = [[NSMutableArray alloc] init];
    }
    
    if ([self.delegate respondsToSelector:@selector(bluetoothHasBeenDisconnect)])
    {
        [self.delegate bluetoothHasBeenDisconnect];
    }
}

#pragma mark -- Method
//开始扫描蓝牙
- (void)startPerialScan
{
    NSLog(@"Start scanning");
    //是否弹窗提示
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber  numberWithBool:YES], CBCentralManagerScanOptionAllowDuplicatesKey, nil];
    [self.CBCenter scanForPeripheralsWithServices:nil options:options];
}

//判断数组里面是否有port，数组已有则返回port，没有则返回nil
- (SAJBLEPort *)getPortMatchWithPeriperal:(CBPeripheral *)periperal
{
    for (SAJBLEPort *port in self.portsArray)
    {
        if (port.peripheral == periperal)
        {
            return port;
        }
    }
    
    return nil;
}

//停止扫描
- (void)stopPerialScan
{
    [self.CBCenter stopScan];
}

//连接蓝牙
- (void)connectPeripheral:(CBPeripheral *)peripheral
{
    [self stopPerialScan];
    
    [self.CBCenter connectPeripheral:peripheral options:nil];
}

//断开蓝牙
- (void)disconnectPeripheral
{
    [self.CBCenter cancelPeripheralConnection:self.peripheral];
}

//刷新列表
- (void)refreshBluetoothList
{
    if ([self.delegate respondsToSelector:@selector(didFoundPortWithList:)])
    {
        [self.delegate didFoundPortWithList:self.portsArray];
    }
}

//check CRC
- (uint16_t)checkCRC:(uint8_t *)pchMsg wDataLen:(uint16_t)wDataLen
{
    uint16_t  crcResult = CalculateCRC16(pchMsg, wDataLen);
    
    return crcResult;
}

//数据读取
- (void)readDataWithCommand:(NSString *)command didFinishSucceedCallback:(SucceedCallback)succeed failedCallBack:(FaileCallBack)faile
{
    //获取操作寄存器个数
    NSString *registerCountStr = [command substringFromIndex:command.length - 4];
    self.registerCount = [[self numberHexString:registerCountStr] integerValue];
    
    self.succeedCallBack = succeed;
    
    self.failedCallBack = faile;
    
    uint8_t buffer[20];
    
    for (int i = 0; i < 6; i ++)
    {
        buffer[i] = [self getInt:command formLoc:i*2 length:2];
    }
    
    uint16_t  crcResult = CalculateCRC16(buffer, 6);

    buffer[6] = (crcResult >> 0) & 0xff;
    buffer[7] = (crcResult >> 8) & 0xff;
    
    //状态设置为传输中
    self.isTransferring = YES;
    
    //确保之前放数据的容器清零
    self.receiveDataStr = nil;
    
    if (self.peripheral.services.count)
    {
        [self.peripheral writeValue:[NSData dataWithBytes:buffer length:8] forCharacteristic:self.charater type:CBCharacteristicWriteWithResponse];
    }
}

//数据写入
- (void)writeCommand:(NSString *)command writeDatas:(NSArray *)datas didFinishSucceedCallback:(SucceedCallback)succeed failedCallBack:(FaileCallBack)faile
{
    self.writeCommandMark = command;
    
    self.succeedCallBack = succeed;
    
    self.failedCallBack = faile;
    
    NSInteger index = command.length/2 + datas.count*2;
    
    uint8_t buffer[index];
    for (int i = 0; i < command.length/2; i ++)
    {
        buffer[i] = [self getInt:command formLoc:i*2 length:2];
    }
    
    for (int i = 0; i < datas.count; i ++)
    {
        int data = [datas[i] intValue];
        
        for (int j = 0; j < 2; j ++)
        {
            if (j == 0)
            {
                buffer[7 + i*2 + j ] = (data >> 8) & 0xff;
            }
            else
            {
                buffer[7 + i*2 + j ] = (data >> 0) & 0xff;
            }
        }
    }
    
    uint16_t  crcResult = CalculateCRC16(buffer, index);
    buffer[index] = (crcResult >> 0) & 0xff;
    buffer[index + 1] = (crcResult >> 8) & 0xff;
    
    if (self.peripheral.services.count)
    {
        [self.peripheral writeValue:[NSData dataWithBytes:buffer length:index + 2] forCharacteristic:self.charater type:CBCharacteristicWriteWithResponse];
    }
}

- (int)getInt:(NSString *)cmd formLoc:(NSInteger)loc length:(NSInteger)len
{
    NSString *subString;
    if (cmd.length > 10)
    {
        subString = [cmd substringWithRange:NSMakeRange(loc, len)];
    }
    
    int cmdInt = [[self numberHexString:subString] intValue];
    
    return cmdInt;
}

- (NSNumber *)numberHexString:(NSString *)aHexString
{
    // 为空,直接返回.
    if (nil == aHexString)
    {
        return nil;
    }
    
    NSScanner * scanner = [NSScanner scannerWithString:aHexString];
    unsigned long long longlongValue;
    [scanner scanHexLongLong:&longlongValue];
    
    //将整数转换为NSNumber,存储到数组中,并返回.
    NSNumber * hexNumber = [NSNumber numberWithLongLong:longlongValue];
    
    return hexNumber;
}

//errorCode转error_msg
- (NSString *)getErrorMsgWithErrorCode:(NSString *)errorCode
{
    NSInteger code = [[self numberHexString:errorCode] integerValue];
    switch (code)
    {
        case 1:
            return IllegalFunctionCode;
            break;
            
        case 2:
            return IllegalRequestAddress;
            break;
            
        case 3:
            return IllegalRequestDataValue;
            break;
            
        case 4:
            return ServerFailure;
            break;
            
        case 6:
            return ServerIsBusy;
            break;
            
        case 10:
            return WrongPassword;
            break;
            
        case 11:
            return CheckingErrors;
            break;
            
        case 12:
            return InvalidParameter;
            break;
            
        case 13:
            return SystemLockdown;
            break;
            
        default:
            return @"其它错误";
            break;
    }
}

- (void)clearListData
{
    if (self.portsArray)
    {
        [self.portsArray removeAllObjects];
        self.portsArray = nil;
        self.portsArray = [[NSMutableArray alloc] init];
    }
}

#pragma mark -- Check CRC
//高位字节
const uint8_t chCRCHTalbe[] = {
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
    0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
    0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40
};

//低位字节
const uint8_t chCRCLTalbe[] = {
    0x00, 0xC0, 0xC1, 0x01, 0xC3, 0x03, 0x02, 0xC2, 0xC6, 0x06, 0x07, 0xC7,
    0x05, 0xC5, 0xC4, 0x04, 0xCC, 0x0C, 0x0D, 0xCD, 0x0F, 0xCF, 0xCE, 0x0E,
    0x0A, 0xCA, 0xCB, 0x0B, 0xC9, 0x09, 0x08, 0xC8, 0xD8, 0x18, 0x19, 0xD9,
    0x1B, 0xDB, 0xDA, 0x1A, 0x1E, 0xDE, 0xDF, 0x1F, 0xDD, 0x1D, 0x1C, 0xDC,
    0x14, 0xD4, 0xD5, 0x15, 0xD7, 0x17, 0x16, 0xD6, 0xD2, 0x12, 0x13, 0xD3,
    0x11, 0xD1, 0xD0, 0x10, 0xF0, 0x30, 0x31, 0xF1, 0x33, 0xF3, 0xF2, 0x32,
    0x36, 0xF6, 0xF7, 0x37, 0xF5, 0x35, 0x34, 0xF4, 0x3C, 0xFC, 0xFD, 0x3D,
    0xFF, 0x3F, 0x3E, 0xFE, 0xFA, 0x3A, 0x3B, 0xFB, 0x39, 0xF9, 0xF8, 0x38,
    0x28, 0xE8, 0xE9, 0x29, 0xEB, 0x2B, 0x2A, 0xEA, 0xEE, 0x2E, 0x2F, 0xEF,
    0x2D, 0xED, 0xEC, 0x2C, 0xE4, 0x24, 0x25, 0xE5, 0x27, 0xE7, 0xE6, 0x26,
    0x22, 0xE2, 0xE3, 0x23, 0xE1, 0x21, 0x20, 0xE0, 0xA0, 0x60, 0x61, 0xA1,
    0x63, 0xA3, 0xA2, 0x62, 0x66, 0xA6, 0xA7, 0x67, 0xA5, 0x65, 0x64, 0xA4,
    0x6C, 0xAC, 0xAD, 0x6D, 0xAF, 0x6F, 0x6E, 0xAE, 0xAA, 0x6A, 0x6B, 0xAB,
    0x69, 0xA9, 0xA8, 0x68, 0x78, 0xB8, 0xB9, 0x79, 0xBB, 0x7B, 0x7A, 0xBA,
    0xBE, 0x7E, 0x7F, 0xBF, 0x7D, 0xBD, 0xBC, 0x7C, 0xB4, 0x74, 0x75, 0xB5,
    0x77, 0xB7, 0xB6, 0x76, 0x72, 0xB2, 0xB3, 0x73, 0xB1, 0x71, 0x70, 0xB0,
    0x50, 0x90, 0x91, 0x51, 0x93, 0x53, 0x52, 0x92, 0x96, 0x56, 0x57, 0x97,
    0x55, 0x95, 0x94, 0x54, 0x9C, 0x5C, 0x5D, 0x9D, 0x5F, 0x9F, 0x9E, 0x5E,
    0x5A, 0x9A, 0x9B, 0x5B, 0x99, 0x59, 0x58, 0x98, 0x88, 0x48, 0x49, 0x89,
    0x4B, 0x8B, 0x8A, 0x4A, 0x4E, 0x8E, 0x8F, 0x4F, 0x8D, 0x4D, 0x4C, 0x8C,
    0x44, 0x84, 0x85, 0x45, 0x87, 0x47, 0x46, 0x86, 0x82, 0x42, 0x43, 0x83,
    0x41, 0x81, 0x80, 0x40
};

uint16_t CalculateCRC16(uint8_t* pchMsg, uint16_t wDataLen)
{
    uint8_t chCRCHi = 0xFF; 		// 高CRC字节初始化
    uint8_t chCRCLo = 0xFF; 		// 低CRC字节初始化
    uint16_t wIndex;            	// CRC循环中的索引
    
    while (wDataLen--)
    {
        // 计算CRC
        wIndex = chCRCLo ^ *pchMsg++ ;
        chCRCLo = chCRCHi ^ chCRCHTalbe[wIndex];
        chCRCHi = chCRCLTalbe[wIndex] ;
    }
    
    return ((chCRCHi << 8) | chCRCLo) ;
}


@end
