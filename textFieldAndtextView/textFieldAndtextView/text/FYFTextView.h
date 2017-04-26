//
//  FYFTextView.h
//  textFieldAndtextView
//
//  Created by 范云飞 on 2017/4/26.
//  Copyright © 2017年 范云飞. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  特性：
 *  1. 最大长度字段 maxLength
 *  2. 默认值字段 placeholder
 *  3. 限制emoji表情
 */
typedef void(^ReturnCountBlock) (NSInteger);

@interface FYFTextView : UITextView

/** 可输入的最大长度 */
@property (nonatomic, assign) NSInteger maxLength;
/** 是否限制emoji表情输入，默认为NO */
@property (nonatomic, assign) BOOL limitEmoji;

@property (nonatomic, strong) NSString  *placeholder;
@property (nonatomic, strong) UILabel   *placeholderLabel;
@property (nonatomic, copy)   ReturnCountBlock returnCountBlock;


@end
