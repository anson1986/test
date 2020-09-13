//
// Utility.h
//  SAJ
//
//  Created by user on 2017/9/15.
//  Copyright © 2017年 Guangzhou Sanjing Electric CO., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,OrderDetailStatusType) {
    ReadyToPayType,
    HasBeenPayType,
    CompleteType,
    DealingType,
    CancelType
};

typedef NS_ENUM(NSInteger,ControllerType) {
    EdictAddrType,//编辑收货地址
    EditInvoiceType,//添加发票抬头
};

typedef NS_ENUM(NSInteger, AddrEditType) {
    EditAddress,//编辑地址
    AddNewAddress//新建地址
};

typedef NS_ENUM(NSInteger,PayStatusType)
{
    PayStatusSucceedType,//支付成功
    PayStatusFailType//支付失败
};

typedef NS_ENUM(NSInteger,FromControllerType)
{
    SAJWalletMarginType,
    SAJOrderDetailControllerType,
    SAJOrderConfirmControllerType,
    SAJOrderPayResultControllerType
};

typedef NS_ENUM(NSInteger, AlertDetailType) {
    SAJAlertDetailPendingType = 1,//待处理
    SAJAlertDetailHandlingType,//处理中
    SAJAlertDetailContactSAJType,//联系三晶
    SAJAlertDetailCloseType,//已关闭
    SAJAlertDetailCombineHandlingAndContactSAJType//合并"处理中,联系三晶" 2项
};

typedef NS_ENUM(NSInteger, ConnectInventorType) {
    ConnectInventorBluetoothType,//蓝牙
    ConnectInventorWifiType,//wifi
    ConnectInventorInternetType//云连接
};

typedef NS_ENUM(NSInteger, ConnetRootType) {
    ConnetRootMineControlType,//远程控制
    ConnetRootAllSettingType,//一键配置
};

typedef NS_ENUM(NSInteger, SaftyType) {
    SaftyNationType,//国家
    SaftyStandarType,//标准
    SaftyExpertType,//专家
};

typedef NS_ENUM(NSInteger, ADPictureType) {
    ADPictureFeedbackType = 1,//反馈页
    ADPictureLoginType = 2,//登录页
};

typedef NS_ENUM(NSInteger, UserType) {
    EngineerType = 1,//接单使用者
    CustomerType = 2,//派单使用者
};

typedef NS_ENUM(NSInteger, LocalMapUsage) {
    LocalMapUsageShare = 1,//共享运维
    LocalMapUsageWareHouse = 2,//运维库
    LocalMapUsageWorkOrder = 3,//工单地图
    LocalMapUsageCportWareHouse = 4,//C端运维库地图
    LocalMapUsageWorkLiveAudio = 5,//工单语音气泡
    LocalMapUsageWorkDetail = 6,//工单详情
    LocalMapUsageWorkPlantAddress = 7,//电站地址
};

typedef NS_ENUM(NSInteger, bindingPhone) {
    bindingPhoneIncrement = 1,//新增绑定手机
    bindingPhoneModification = 2,//修改已绑定手机
};

@interface Utility : NSObject

@property (nonatomic) OrderDetailStatusType detailType;

@property (nonatomic) ControllerType *controllerType;

@property (nonatomic) AddrEditType *editAddrType;

@property (nonatomic) PayStatusType payStatusType;

@property (nonatomic) FromControllerType fromControllerType;

@property (nonatomic) AlertDetailType alertDetailType;

//nodataView
+ (UIView *)showNoDataViewAtView:(UIView *)view WithTitle:(NSString *)title;

//scolloview转img
+ (UIImage *)imageWithView:(UIScrollView *)view;

// 计算控件高度
+ (float)heightForString:(NSString *)string andFontSize:(CGFloat)fontSize andWidth:(CGFloat)width;

// 16进制转10进制
+ (NSNumber *)numberHexString:(NSString *)aHexString;

//10进制转16进制
+ (NSString *)getHexByDecimal:(NSInteger)decimal;

//16进制转为2进制
+ (NSString *)getBinaryByHex:(NSString *)hex;

//2进制转16进制
+ (NSString *)getHexByBinary:(NSString *)binary;

//判断iPhone X
+ (BOOL)iphoneX;

//设备型号
+ (NSString *)deviceType:(NSString *)hex;

//error
+ (NSString *)errorMessage:(NSString *)key;

+ (NSString *)errorCode:(NSString *)key;

//波特率
+ (NSString *)getBaudIndex:(NSString *)key;

//功能性字
+ (NSString *)getFuntionMask:(NSString *)key;

//pv模式
+ (NSString *)getPVModel:(NSString *)key;

+ (NSString *)getStandardWithHex:(NSString *)hex;

+ (NSString *)getNationStandarArrayWithHex:(NSString *)hex;

+(NSString *)getAppVersion;

+ (BOOL)isAppHasCameraPermission;

+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;


+ (NSString *)countNumAndChangeformat:(NSString *)num;


/// 为空
+(BOOL) isEmptyStr:(NSString*)str;

@end
