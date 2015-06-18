//
//  NSString+DES.m
//  UMC
//
//  Created by 悦讯科技  on 13-7-23.
//  Copyright (c) 2013年 shihui. All rights reserved.
//

#define KEY @"8345dfas"

#import "NSString+IDEA.h"

#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (IDEA)

// 字符串加密
- (NSString *)stringWithStrToIDEA {
    if (self == nil || [self isEqualToString:@"null"] || [self isEqualToString:@""] || (NSNull *)self == [NSNull null]) {
        return @"";
    }
    return [self encryptUseIDEA:self key:KEY];
}

// 字符串解密
- (NSString *)stringWithIDEAToStr {
    if (self == nil || [self isEqualToString:@"null"] || [self isEqualToString:@""] || (NSNull *)self == [NSNull null]) {
        return @"";
    }
    return [self decryptUseIDEA:self key:KEY];
}

#pragma mark -

// des加密
-(NSString *) encryptUseIDEA:(NSString *)clearText key:(NSString *)key
{
    NSString *ciphertext = nil;
    NSData *textData = [clearText dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [key UTF8String], kCCKeySizeDES,
                                          nil,
                                          [textData bytes]  , [textData length],
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [self data2HexStr:data];
    }else{
        DMLog(@"DES加密失败");
    }
    return ciphertext;
}

// des解密
-(NSString *) decryptUseIDEA:(NSString *)plainText key:(NSString *)key
{
    NSString *cleartext = nil;
    NSData *textData = [self hexStr2Data:plainText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [key UTF8String], kCCKeySizeDES,
                                          nil,
                                          [textData bytes]  , [textData length],
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
#if ! __has_feature(objc_arc)
        cleartext = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]autorelease];
#else
        cleartext = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
#endif
    }else{
        DMLog(@"DES解密失败");
    }
    return cleartext;
}

#pragma makr -

- (NSString *)data2HexStr:(NSData *)data {
    NSString *str = @"0123456789ABCDEF";
    
    NSMutableString *retStr = [NSMutableString string];
    const Byte *bs = [data bytes];
    int bit;
    for (int i = 0; i < data.length; i++) {
        bit = (bs[i] & 0x0f0) >> 4;
        [retStr appendString:[str substringWithRange:NSMakeRange(bit, 1)]];
        bit = bs[i] & 0x0f;
        [retStr appendString:[str substringWithRange:NSMakeRange(bit, 1)]];
    }
    return retStr;
}

- (NSData *)hexStr2Data:(NSString *)string {
    NSString *str = @"0123456789ABCDEF";
    string = [string uppercaseString];
    Byte *bytes = (Byte *)[[NSMutableData dataWithCapacity:string.length/2]bytes];
    NSInteger n;
    for (int i = 0; i < string.length/2; i++) {
        n = [str rangeOfString:[string substringWithRange:NSMakeRange(2*i, 1)]].location << 4;
        n += [str rangeOfString:[string substringWithRange:NSMakeRange(2*i+1, 1)]].location;
        bytes[i] = (Byte) (n & 0xff);
    }
    return [NSData dataWithBytes:bytes length:string.length/2];
}

@end
