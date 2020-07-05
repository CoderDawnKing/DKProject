//
//  NSString+DKCategory.h
//  GardenManager
//
//  Created by 王 on 2019/6/26.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (DKCategory)


///计算文本的宽度或高度
-(CGSize)boundingRectSizeWithFont:(UIFont *)font size:(CGSize)size;

/**
 正则匹配所有字符串中的·设置属性
 */
- (NSMutableAttributedString *)regularMatchWithAttributes:(NSDictionary<NSAttributedStringKey, id> *)attr;

/**
 正则匹配所有字符串中的某段字符设置属性

 @param regularMatch 正则表达式
 @param attr 属性
 @return 可变带属性字符串
 */
- (NSMutableAttributedString *)regularMatch:(NSString *)regularMatch withAttributes:(NSDictionary<NSAttributedStringKey, id> *)attr;

///md5加密
- (NSString *)md5Encryption;

///随机字符串
- (NSString *)getRandomStringWithNum:(NSInteger)num;

//匹配 1-100 整数
- (BOOL)regularMatchStringWithNumber;
//匹配\t数字加小数点\t
- (BOOL)regularMatchStringWithNumberDot;
//匹配图片 url 是否限制大小 是的话去除限制 返回原图
- (NSString *)regularMatchStringWithImageUrl;

- (NSString *)regularMatchGetNumber;
///匹配字符串是否 url
- (BOOL)regularMatchStringWithUrl;

- (NSString *)URLEncodeString;

- (NSString *)unicodeString;

-(NSString *)utf8ToUnicode;
/// 截取某 2 个字符串中间的字符串
- (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString;
/// 截取字符串，若小于 length 则不截取
- (NSString *)subStringWithLength:(NSInteger)length;
///计算文本的宽度或高度
-(CGSize)boundingRectWithFont:(UIFont *)font size:(CGSize)size;
- (NSArray *)arrayOfCheckStringWithURL;
- (NSArray *)arrayOfCheckStringWithRegular:(NSString *)regular;

///保留数字
- (NSString *)keepNumber;
///保留小数点和数字
- (NSString *)keepDecimalNumber;
///保留 formatter 中的字符串
- (NSString *)keepStringWithFormatter:(NSString *)formatter;

@end

NS_ASSUME_NONNULL_END
