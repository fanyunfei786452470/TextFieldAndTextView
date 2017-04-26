//
//  FYFTextView.m
//  textFieldAndtextView
//
//  Created by 范云飞 on 2017/4/26.
//  Copyright © 2017年 范云飞. All rights reserved.
//

#import "FYFTextView.h"

#import "NSString+Substring.h"
#import "NSString+Emoji.h"

@interface FYFTextViewSupport : NSObject <UITextViewDelegate>

@property (nonatomic, weak) id<UITextViewDelegate> delegate;

@end
@implementation FYFTextViewSupport

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    FYFTextView *t = (FYFTextView *)textView;
    if (t.text.length != 0) {
        [t.placeholderLabel removeFromSuperview];
    }
    if([self.delegate respondsToSelector:@selector(textViewShouldBeginEditing:)])
        return [self.delegate textViewShouldBeginEditing:textView];
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
    FYFTextView *t = (FYFTextView *)textView;
    if (t.text.length == 0) {
        [t addSubview:t.placeholderLabel];
    } else {
        [t.placeholderLabel removeFromSuperview];
    }
    
    if([self.delegate respondsToSelector:@selector(textViewShouldEndEditing:)])
        return [self.delegate textViewShouldEndEditing:textView];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if([self.delegate respondsToSelector:@selector(textViewDidBeginEditing:)])
        [self.delegate textViewDidBeginEditing:textView];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if([self.delegate respondsToSelector:@selector(textViewDidEndEditing:)])
        [self.delegate textViewDidEndEditing:textView];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([self.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        [self.delegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    BOOL limitEmoji = ((FYFTextView *)textView).limitEmoji;
    if (limitEmoji && [text isIncludingEmoji]) {
        return NO;
    }
    NSInteger maxLength = ((FYFTextView *)textView).maxLength;
    if (maxLength > 0) {
        //增加文字
        if (text.length > 0) {
            if (textView.text.length + text.length > maxLength) {
                NSInteger newStringLength = [textView.text lengthOfAppendString:text maxLength:maxLength];
                if (newStringLength > 0) {
                    textView.text = [NSString stringWithFormat:@"%@%@", textView.text, [text substringToIndex:newStringLength]];
                }
                return NO;
            } else {
                return YES;
            }
        } else { //减少文字
            return YES;
        }
    } else {
        return YES;
    }
    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    FYFTextView *t = (FYFTextView *)textView;
    NSInteger maxLength = t.maxLength;
    
    if (t.limitEmoji && [t.text isIncludingEmoji]) {
        t.text = [t.text stringByRemovingEmoji];
    }
    
    if (maxLength > 0) {
        if (t.markedTextRange == nil && maxLength > 0 && t.text.length > maxLength) {
            NSString *newString = [t.text substringWithLength:maxLength];
            if (newString.length != t.text.length) {
                t.text = newString;
            }
        }
    }
    
    if (t.text.length == 0) {
        [t addSubview:t.placeholderLabel];
    } else {
        [t.placeholderLabel removeFromSuperview];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.delegate textViewDidChange:t];
    }
    
}


- (void)textViewDidChangeSelection:(UITextView *)textView {
    if([self.delegate respondsToSelector:@selector(textViewDidChangeSelection:)])
        [self.delegate textViewDidChangeSelection:textView];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if([self.delegate respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)])
//        return [self.delegate textView:textView shouldInteractWithURL:URL inRange:characterRange];
        return [self.delegate textView:textView shouldInteractWithURL:URL inRange:characterRange interaction:UITextItemInteractionPreview];
    
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange {
    if([self.delegate respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)])
//        return [self.delegate textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
        return [self.delegate textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange interaction:UITextItemInteractionPreview];
    return YES;
}


-(void)setDelegate:(id<UITextViewDelegate>)dele{
    _delegate = dele;
}

@end


@interface FYFTextView()

@property (nonatomic, strong) FYFTextViewSupport *textViewSupport;


@end

@implementation FYFTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textViewSupport = [[FYFTextViewSupport alloc] init];
        [self addSubview:self.placeholderLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.placeholderLabel sizeToFit];
    self.placeholderLabel.frame = CGRectMake(8, 10, CGRectGetWidth(self.frame) - 16, CGRectGetHeight(_placeholderLabel.frame));
}


#pragma mark - setter

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.font = [UIFont systemFontOfSize:15];
        _placeholderLabel.textColor = [UIColor colorWithRed:227.f/255.f green:230.f/255.f blue:230.f/255.f alpha:1.f];
        _placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _placeholderLabel.numberOfLines = 0;
    }
    return _placeholderLabel;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    _placeholderLabel.text = _placeholder;
    [self layoutIfNeeded];
}

-(void)setDelegate:(id<UITextViewDelegate>)deleg{
    _textViewSupport.delegate = deleg;
    super.delegate = _textViewSupport;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    
    if (!text || ![text isEqualToString:@""]) {
        [self.placeholderLabel removeFromSuperview];
    }
}


@end
