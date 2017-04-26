//
//  NSString+Emoji.h
//  textFieldAndtextView
//
//  Created by 范云飞 on 2017/4/26.
//  Copyright © 2017年 范云飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Emoji)
- (BOOL)isIncludingEmoji;

- (instancetype)stringByRemovingEmoji;
@end
