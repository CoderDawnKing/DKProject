//
//  NSString+DKCategory.m
//  GardenManager
//
//  Created by 王 on 2019/6/26.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "NSString+DKCategory.h"
#import "NSObject+DKCategory.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (DKCategory)

//计算文本的宽度或高度
-(CGSize)boundingRectSizeWithFont:(UIFont *)font size:(CGSize)size {
    NSDictionary *attri = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    CGSize rectSize =[self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attri context:nil].size;
    return rectSize;
}

- (BOOL)regularMatchStringWithUrl {
    NSString *regex = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    return [self regularMatchStringWithRegularMatch:regex];
}

- (BOOL)regularMatchStringWithNumber {
    return [self regularMatchStringWithRegularMatch:@"^(?:[1-9][0-9]?|100)+([.])$"];
}

- (BOOL)regularMatchStringWithNumberDot {
   return [self regularMatchStringWithRegularMatch:@"^\x09+(?:[1-9][0-9]?|100)+([.])+\x09$"];
}

- (BOOL)regularMatchStringWithRegularMatch:(NSString *)regularMatch {
    if ([self dk_notEmpty]) {
        NSString *regex = regularMatch;
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        return [pred evaluateWithObject:self];
    }
    return NO;
}

- (NSString *)regularMatchGetNumber {
    NSError *error;
    NSRegularExpression *attachmentExpression = [NSRegularExpression regularExpressionWithPattern:@"(\\d*)" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [attachmentExpression matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match rangeAtIndex:1];
        NSString *matchString = [self substringWithRange:matchRange];
        NSLog(@"%@", matchString);
        if (matchString.length>0) {
            return matchString;
        }
    }
    return @"";
    
}

- (NSMutableAttributedString *)regularMatchWithAttributes:(NSDictionary<NSAttributedStringKey,id> *)attr {
    return [self regularMatch:@"(\\·*)" withAttributes:attr];
}

- (NSMutableAttributedString *)regularMatch:(NSString *)regularMatch withAttributes:(NSDictionary<NSAttributedStringKey, id> *)attr {
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self];
    NSRegularExpression *attachmentExpression = [NSRegularExpression regularExpressionWithPattern:regularMatch options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *matches = [attachmentExpression matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    for (NSTextCheckingResult *match in matches) {
        [attrString addAttributes:attr range:[match rangeAtIndex:1]];
    }
    return attrString;
}

- (NSString *)regularMatchStringWithImageUrl {
    NSString *parten = @"jpg(.*)|png(.*)|jpeg(.*)|gif(.*)|webp(.*)|bmp(.*)|pcx(.*)|tif(.*)|tga(.*)|exif(.*)|fpx(.*)|svg(.*)|psd(.*)|cdr(.*)|pcd(.*)|dxf(.*)|ufo(.*)|eps(.*)|ai(.*)|hdri(.*)|raw(.*)|wmf(.*)|flic(.*)|emf(.*)|ico(.*)";
    NSError *error = nil;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:NSRegularExpressionCaseInsensitive error:&error]; //options 根据自己需求选择
    NSArray *matches = [reg matchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    NSString *resultStr = @"";
    for (NSTextCheckingResult *match in matches) {
        NSString *matchString = [self substringWithRange:[match rangeAtIndex:0]];
        NSString *replaceString = [[matchString componentsSeparatedByString:@"_"] firstObject];
        resultStr = [self stringByReplacingOccurrencesOfString:matchString withString:replaceString];
    }
    if (resultStr) {
        return resultStr;
    }
    return self;
}

- (NSString *)md5Encryption {
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

- (NSString *)getRandomStringWithNum:(NSInteger)num
{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < num; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}

- (NSString *)URLEncodeString {
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedString = [self stringByAddingPercentEncodingWithAllowedCharacters:set];
    return encodedString;
}

- (NSString *)unicodeString {
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSPropertyListFormat format = NSPropertyListOpenStepFormat;
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:&format error:nil];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

//转化为unicode
-(NSString *)utf8ToUnicode {
    if ([self length]<=0) {
        return self;
    }
    NSString* escapedString = [self stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    NSData* data = [escapedString dataUsingEncoding:NSUTF16LittleEndianStringEncoding allowLossyConversion:YES];
    size_t bytesRead = 0;
    const char* bytes = data.bytes;
    NSMutableString* encodedString = [NSMutableString string];
    
    while (bytesRead < data.length)
    {
        uint16_t code = *((uint16_t*) &bytes[bytesRead]);
        if (code > 0x007E)
        {
            if (ispunct(code)) {
                [encodedString appendFormat:@"%C", code];
            }else if ([self isPunctuation:code]) {//一些中文标点符号
                [encodedString appendFormat:@"%C", code];
            }else if (code >= 0x4E00 && code <= 0x9FFF) {//汉字
                [encodedString appendFormat:@"%C", code];
            }else if (0xE001>= code && code <= 0xE05A) {
                [encodedString appendFormat:@"\\u%04X", code];
            } else if (0xE101 >= code && code <= 0xE15A) {
                [encodedString appendFormat:@"\\u%04X", code];
            } else if (0xE201 >= code && code <= 0xE253) {
                [encodedString appendFormat:@"\\u%04X", code];
            } else if (0xE401 >= code && code <= 0xE44C) {
                [encodedString appendFormat:@"\\u%04X", code];
            } else if (0xE501 >= code && code <= 0xE537) {
                [encodedString appendFormat:@"\\u%04X", code];
            }else{
                if (code==0xfe0f) {//
                    
                }else{
                    [encodedString appendFormat:@"%C", code];//
                }
            }
        }
        else
        {
            [encodedString appendFormat:@"%C", code];
        }
        bytesRead += sizeof(uint16_t);
    }
    
    return encodedString;
}

//判断中文标点符号
-(BOOL)isPunctuation:(unichar)ch{
    
    if (0x3000 <= ch && ch <= 0x303F) return YES;
    if (0xFF01 <= ch && ch <= 0xFF0F) return YES;
    if (0xFF1A <= ch && ch <= 0xFF20) return YES;
    if (0xFF3B <= ch && ch <= 0xFF40) return YES;
    if (0xFF5B <= ch && ch <= 0xFF5E) return YES;
    if (0xFE10 <= ch && ch <= 0xFE1F) return YES;
    
    if (0x3004 <= ch && ch <= 0x301C) return true;
    if (0x3020 <= ch && ch <= 0x303F) return true;
    
    
    if (ch == 0x40||ch == 0xa3||ch == 0xa5) return true;
    if (ch==0x20AC) return true;
    if (ch == 0x2D || ch == 0x2F) return true;
    if (0x23 <= ch && ch <= 0x26) return true;
    if (0x28 <= ch && ch <= 0x2B) return true;
    if (0x3C <= ch && ch <= 0x3E) return true;
    if (0x5B <= ch && ch <= 0x60) return true;
    if (0x7B <= ch && ch <= 0x7E) return true;
    
    if(0x2010 <= ch && ch <= 0x2017) return true;
    if(0x2020 <= ch && ch <= 0x2027) return true;
    if(0x2B00 <= ch && ch <= 0x2BFF) return true;
    if(0xFF03 <= ch && ch <= 0xFF06) return true;
    if(0xFF08 <= ch && ch <= 0xFF0B) return true;
    if(ch == 0xFF0D || ch == 0xFF0F) return true;
    if(0xFF1C <= ch && ch <= 0xFF1E) return true;
    if(ch == 0xFF20 || ch == 0xFF65) return true;
    if(0xFF3B <= ch && ch <= 0xFF40) return true;
    if(0xFF5B <= ch && ch <= 0xFF60) return true;
    if(ch == 0xFF62 || ch == 0xFF63) return true;
    if(ch == 0x0032 || ch == 0x3000) return true;
    
    
    if(0x2018 <= ch && ch <= 0x201F) return true;
    if(ch == 0xFF01 || ch == 0xFF02) return true;
    if(ch == 0xFF07 || ch == 0xFF0C) return true;
    if(ch == 0xFF1A || ch == 0xFF1B) return true;
    if(ch == 0xFF1F || ch == 0xFF61) return true;
    if(ch == 0xFF0E) return true;
    if(ch == 0xFF65) return true;
    
    return NO;
}

// 截取字符串方法封装// 截取字符串方法封装
- (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString {
    NSRange startRange = [self rangeOfString:startString];
    NSRange endRange = [self rangeOfString:endString];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    return [self substringWithRange:range];
}

- (NSString *)subStringWithLength:(NSInteger)length {
    NSString *resultString = self;
    __block NSInteger number = 1;
    __block NSInteger location = resultString.length;
    [resultString enumerateSubstringsInRange:NSMakeRange(0, resultString.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        if (number == length) {
            location = substringRange.location + substring.length;
        }
        number ++;
    }];
    if (resultString.length > location) {
        resultString = [resultString substringToIndex:location];
        resultString = [resultString stringByAppendingString:@"..."];
    }
    return resultString;
}

//计算文本的宽度或高度
-(CGSize)boundingRectWithFont:(UIFont *)font size:(CGSize)size {
    CGSize resultSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    return resultSize;
}

//- (NSArray<NSURL *> *)arrayOfCheckStringWithURL {
//    NSError *error;
//    NSDataDetector *dataDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
//    NSArray *array = [dataDetector matchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
//    NSMutableArray *arrayM = [NSMutableArray array];
//    for (NSTextCheckingResult *result in array) {
//        [arrayM addObject:result.URL];
//    }
//    return arrayM;
//}

- (NSArray *)arrayOfCheckStringWithURL {
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    return [self arrayOfCheckStringWithRegular:regulaStr];
}

- (NSArray *)arrayOfCheckStringWithRegular:(NSString *)regular {
    NSError *error;

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regular options:NSRegularExpressionCaseInsensitive error:&error];

    NSArray *arrayOfAllMatches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];

    NSMutableArray *arrayM = [NSMutableArray array];

    for (NSTextCheckingResult *match in arrayOfAllMatches){
        NSString* substringForMatch;
        substringForMatch = [self substringWithRange:match.range];
        [arrayM addObject:substringForMatch];
    }
    return arrayM;
}

- (NSString *)dk_keepNumber {
    return [self dk_keepStringWithFormatter:@"0123456789"];
}

- (NSString *)dk_keepDecimalNumber {
    return [self dk_keepStringWithFormatter:@"0123456789."];
}

- (NSString *)dk_keepStringWithFormatter:(NSString *)formatter {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:formatter] invertedSet];
    NSString *string = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return string;
}

@end
