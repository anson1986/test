//
//  UIColor+Additions.h
//  Created by Joan Martin.
//  Take a look to my repos at http://github.com/vilanovi
//
// Copyright (c) 2013 Joan Martin, vilanovi@gmail.com.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
// of the Software, and to permit persons to whom the Software is furnished to do
// so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE

#import <UIKit/UIKit.h>

@interface UIColor (Additions)
+ (UIColor *)R:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(NSInteger)a;
+ (UIColor *)R:(NSInteger)r G:(NSInteger)g B:(NSInteger)b;
+ (UIColor*)colorWithHex:(uint)hex alpha:(CGFloat)alpha;
+ (UIColor*)colorWithRGBHex:(unsigned int)rgbValue;
+ (UIColor*)colorWithRGBAHex:(unsigned int)rgbaValue;
+ (UIColor*)colorWithRGBHexString:(NSString*)rgbStrValue;
+ (UIColor*)colorWithRGBHexString:(NSString*)rgbStrValue alpha:(CGFloat)alpha;
+ (UIColor*)colorWithRGBAHexString:(NSString*)rgbaStrValue;

+ (UIColor*)colorWithRed255:(CGFloat)red green255:(CGFloat)green blue255:(CGFloat)blue alpha255:(CGFloat)alpha;

- (BOOL)getRGBHex:(unsigned int*)rgbHex;
- (BOOL)getRGBAHex:(unsigned int*)rgbaHex;
- (CGFloat)getAlpha;
- (NSString*)RGBHexString;
- (NSString*)RGBAHexString;

- (UIColor*)colorWithSaturation:(CGFloat)newSaturation;
- (UIColor*)colorWithBrightness:(CGFloat)newBrightness;

- (UIColor *)lightenColorWithValue:(CGFloat)value;
- (UIColor *)darkenColorWithValue:(CGFloat)value;
- (BOOL)isLightColor;

@end
