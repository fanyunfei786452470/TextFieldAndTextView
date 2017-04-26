//
//  FYFTextField.h
//  textFieldAndtextView
//
//  Created by 范云飞 on 2017/4/26.
//  Copyright © 2017年 范云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  特性：
 *  1. 最大长度字段 maxLength
 *  2. TextFiled变化的代理方法
 *      - (void)textFieldDidChanged:(UITextField *)textField;
 *  3. 限制emoji表情
 */
@protocol FYFTextFieldDelegate;

@interface FYFTextField : UITextField <UITextFieldDelegate>

/** 可输入的最大长度 */
@property (nonatomic, assign) NSInteger maxLength;

/** 是否限制emoji表情输入，默认为NO */
@property (nonatomic, assign) BOOL limitEmoji;

@property (nonatomic, assign) BOOL showEditView;



@end
