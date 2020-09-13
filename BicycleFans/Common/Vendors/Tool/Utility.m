//
// Utility.m
//  SAJ
//
//  Created by user on 2017/9/15.
//  Copyright © 2017年 Guangzhou Sanjing Electric CO., Ltd. All rights reserved.
//

#import "Utility.h"
#import <AVFoundation/AVFoundation.h>

@implementation Utility

+ (UIView *)showNoDataViewAtView:(UIView *)view WithTitle:(NSString *)title
{
    UIView *noDataView = [UIView new];
    noDataView.backgroundColor = KM_HEXColor(0xF0F0F0);
    [view addSubview:noDataView];
    
    [noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    UILabel *noDataLabel = [UILabel new];
    noDataLabel.text = title;
    noDataLabel.textColor = KM_HEXColor(0x333333);
    noDataLabel.font = [UIFont systemFontOfSize:15];
    [noDataView addSubview:noDataLabel];
    
    [noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(noDataView);
    }];
    
    return noDataView;
}

+ (UIImage *)imageWithView:(UIScrollView *)view
{
    CGRect rect = view.frame;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (float)heightForString:(NSString *)string andFontSize:(CGFloat)fontSize andWidth:(CGFloat)width
{
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    CGFloat height = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size.height + 16;
    return height;
}

//10进制转16进制
+ (NSString *)getHexByDecimal:(NSInteger)decimal {
    
    NSString *hex =@"";
    NSString *letter;
    NSInteger number;
    for (int i = 0; i<9; i++)
    {
        
        number = decimal % 16;
        decimal = decimal / 16;
        switch (number) {
                
            case 10:
                letter =@"A"; break;
            case 11:
                letter =@"B"; break;
            case 12:
                letter =@"C"; break;
            case 13:
                letter =@"D"; break;
            case 14:
                letter =@"E"; break;
            case 15:
                letter =@"F"; break;
            default:
                letter = [NSString stringWithFormat:@"%ld", number];
        }
        
        hex = [letter stringByAppendingString:hex];
        
        if (decimal == 0) {
            
            break;
        }
    }
    
    return hex;
}

// 16进制转10进制
+ (NSNumber *)numberHexString:(NSString *)aHexString
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

+ (BOOL)iphoneX
{
    if (WindowWidth == 375 && WindowHeight == 812)
    {
        return YES;
    }
    
    return NO;
    
}


//16进制转为2进制
+ (NSString *)getBinaryByHex:(NSString *)hex {
    
    NSMutableDictionary *hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [hexDic setObject:@"0000" forKey:@"0"];
    [hexDic setObject:@"0001" forKey:@"1"];
    [hexDic setObject:@"0010" forKey:@"2"];
    [hexDic setObject:@"0011" forKey:@"3"];
    [hexDic setObject:@"0100" forKey:@"4"];
    [hexDic setObject:@"0101" forKey:@"5"];
    [hexDic setObject:@"0110" forKey:@"6"];
    [hexDic setObject:@"0111" forKey:@"7"];
    [hexDic setObject:@"1000" forKey:@"8"];
    [hexDic setObject:@"1001" forKey:@"9"];
    [hexDic setObject:@"1010" forKey:@"A"];
    [hexDic setObject:@"1011" forKey:@"B"];
    [hexDic setObject:@"1100" forKey:@"C"];
    [hexDic setObject:@"1101" forKey:@"D"];
    [hexDic setObject:@"1110" forKey:@"E"];
    [hexDic setObject:@"1111" forKey:@"F"];
    
    NSString *binary = @"";
    for (int i=0; i<[hex length]; i++) {
        
        NSString *key = [hex substringWithRange:NSMakeRange(i, 1)];
        NSString *value = [hexDic objectForKey:key.uppercaseString];
        if (value) {
            
            binary = [binary stringByAppendingString:value];
        }
    }
    return binary;
}

//error


+ (NSString *)getBaudIndex:(NSString *)key
{
    NSDictionary *dict = @{
                           @"115200":@"00",
                           @"57600":@"01",
                           @"38400":@"02",
                           @"19200":@"03",
                           @"9600":@"04",
                           @"4800":@"05",
                           @"2400":@"06",
                           @"1200":@"07",
                           };
    
    return [dict objectForKey:key];
}



+ (NSString *)getHexByBinary:(NSString *)binary {
    
    NSMutableDictionary *binaryDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [binaryDic setObject:@"0" forKey:@"0000"];
    [binaryDic setObject:@"1" forKey:@"0001"];
    [binaryDic setObject:@"2" forKey:@"0010"];
    [binaryDic setObject:@"3" forKey:@"0011"];
    [binaryDic setObject:@"4" forKey:@"0100"];
    [binaryDic setObject:@"5" forKey:@"0101"];
    [binaryDic setObject:@"6" forKey:@"0110"];
    [binaryDic setObject:@"7" forKey:@"0111"];
    [binaryDic setObject:@"8" forKey:@"1000"];
    [binaryDic setObject:@"9" forKey:@"1001"];
    [binaryDic setObject:@"A" forKey:@"1010"];
    [binaryDic setObject:@"B" forKey:@"1011"];
    [binaryDic setObject:@"C" forKey:@"1100"];
    [binaryDic setObject:@"D" forKey:@"1101"];
    [binaryDic setObject:@"E" forKey:@"1110"];
    [binaryDic setObject:@"F" forKey:@"1111"];
    
    if (binary.length % 4 != 0) {
        
        NSMutableString *mStr = [[NSMutableString alloc]init];;
        for (int i = 0; i < 4 - binary.length % 4; i++) {
            
            [mStr appendString:@"0"];
        }
        binary = [mStr stringByAppendingString:binary];
    }
    NSString *hex = @"";
    for (int i=0; i<binary.length; i+=4) {
        
        NSString *key = [binary substringWithRange:NSMakeRange(i, 4)];
        NSString *value = [binaryDic objectForKey:key];
        if (value) {
            
            hex = [hex stringByAppendingString:value];
        }
    }
    return hex;
}



+ (NSString *)getStandardWithHex:(NSString *)hex
{
    if (hex.length == 4)
    {
        NSString *standarHex = [hex substringWithRange:NSMakeRange(2, 2)];
        NSInteger standarKey = [[Utility numberHexString:standarHex] integerValue];
        
        NSString *standarPath = [[NSBundle mainBundle] pathForResource:@"Safty_standard" ofType:@"plist"];
        NSDictionary *standarDict = [NSDictionary dictionaryWithContentsOfFile:standarPath];
        NSString *standar = [standarDict objectForKey:[NSString stringWithFormat:@"%zd",standarKey]] ;
        return standar;
    }
    
    return @"";
}

+ (NSString *)getNationStandarArrayWithHex:(NSString *)hex
{
    NSString *nationPath = [[NSBundle mainBundle] pathForResource:@"Safty_nation" ofType:@"plist"];
    NSDictionary *nationDict = [NSDictionary dictionaryWithContentsOfFile:nationPath];
    
    NSString *standarPath = [[NSBundle mainBundle] pathForResource:@"Safty_standard" ofType:@"plist"];
    NSDictionary *standarDict = [NSDictionary dictionaryWithContentsOfFile:standarPath];
    
    if (hex.length == 4)
    {
        NSString *nationHex = [hex substringWithRange:NSMakeRange(0, 2)];
        NSInteger nationKey = [[Utility numberHexString:nationHex] integerValue];
        NSString *nation = [nationDict objectForKey:[NSString stringWithFormat:@"%zd",nationKey]];
        
        NSString *standarHex = [hex substringWithRange:NSMakeRange(2, 2)];
        NSInteger standarKey = [[Utility numberHexString:standarHex] integerValue];
        NSString *standar = [standarDict objectForKey:[NSString stringWithFormat:@"%zd",standarKey]] ;
        return [NSString stringWithFormat:@"%@(%@)",nation,standar];
    }
    
    return @"";
}

+(NSString *)getAppVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_buidVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    return app_buidVersion;
}

+ (BOOL)isAppHasCameraPermission
{
    NSString *mediaType = AVMediaTypeVideo;
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"打开相机失败"
//                                                            message:KOpenCameraFailStr
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"确定"
//                                                  otherButtonTitles:nil];
//        [alertView show];
        return NO;
    }
    return YES;
}

+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size
{
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}

+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    if (image.size.width <= newSize.width && image.size.height <= newSize.height)
    {
        return image;
    }
    
    newSize.height = image.size.height*(newSize.width/image.size.width);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}

//金钱每三位加一个逗号
+ (NSString *)countNumAndChangeformat:(NSString *)num
{
    if([num rangeOfString:@"."].location !=NSNotFound)  {
        NSString *losttotal = [NSString stringWithFormat:@"%.2f",[num floatValue]];//小数点后只保留两位
        NSArray *array = [losttotal componentsSeparatedByString:@"."];
        //小数点前:array[0]
        //小数点后:array[1]
        int count = 0;
        num = array[0];
        long long int a = num.longLongValue;
        while (a != 0)
        {
            count++;
            a /= 10;
        }
        NSMutableString *string = [NSMutableString stringWithString:num];
        NSMutableString *newstring = [NSMutableString string];
        while (count > 3) {
            count -= 3;
            NSRange rang = NSMakeRange(string.length - 3, 3);
            NSString *str = [string substringWithRange:rang];
            [newstring insertString:str atIndex:0];
            [newstring insertString:@"," atIndex:0];
            [string deleteCharactersInRange:rang];
        }
        [newstring insertString:string atIndex:0];
        NSMutableString *newString = [NSMutableString string];
        newString =[NSMutableString stringWithFormat:@"%@.%@",newstring,array[1]];
        return newString;
    }else {
        int count = 0;
        long long int a = num.longLongValue;
        while (a != 0)
        {
            count++;
            a /= 10;
        }
        NSMutableString *string = [NSMutableString stringWithString:num];
        NSMutableString *newstring = [NSMutableString string];
        while (count > 3) {
            count -= 3;
            NSRange rang = NSMakeRange(string.length - 3, 3);
            NSString *str = [string substringWithRange:rang];
            [newstring insertString:str atIndex:0];
            [newstring insertString:@"," atIndex:0];
            [string deleteCharactersInRange:rang];
        }
        [newstring insertString:string atIndex:0];
        return newstring;
    }
}

+(BOOL) isEmptyStr:(NSString*)str
{
    if ( str == nil || [str isEqualToString:@""] || [str isEqual:[NSNull null]])
    {
        return YES;
    }
    return NO;
}



@end
