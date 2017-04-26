//
//  NSString+Substring.h
//  textFieldAndtextView
//
//  Created by 范云飞 on 2017/4/26.
//  Copyright © 2017年 范云飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Substring)


/**
 *  根据长度截取字符串
 *  该方法是为了防止出现表情被截取一半的情况
 *
 *  @param maxLength 最大长度
 *
 *  @return 截取后的字符串
 */
- (NSString *)substringWithLength:(NSUInteger)maxLength;

/**
 *  根据最大长度截取新追加的字符串
 *  该方法是为了防止出现表情被截取一半的情况
 *
 *  @param newString 追加字符串
 *  @param maxLength 最大长度
 *
 *  @return 追加字符串截取后的长度
 */
- (NSInteger)lengthOfAppendString:(NSString *)newString maxLength:(NSInteger)maxLength;




@end
