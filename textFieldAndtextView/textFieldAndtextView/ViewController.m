//
//  ViewController.m
//  textFieldAndtextView
//
//  Created by 范云飞 on 2017/4/26.
//  Copyright © 2017年 范云飞. All rights reserved.
//

#import "ViewController.h"
#import "FYFTextField.h"
#import "FYFTextView.h"

@interface ViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) FYFTextField *textField;
@property (nonatomic, strong) FYFTextView *textView;

@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *textViewCountLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:self.textField];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.countLabel];
    [self.view addSubview:self.textViewCountLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




#pragma mark - UITextFieldDelegate
- (void)textFieldDidChanged:(UITextField *)textField {
    NSLog(@"textField.text = %@", textField.text);
    self.countLabel.text = @(textField.text.length).stringValue;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"textView.text = %@", textView.text);
    self.textViewCountLabel.text = @(textView.text.length).stringValue;
}

#pragma mark - getter
- (FYFTextField *)textField {
    if (!_textField) {
        _textField = [[FYFTextField alloc] initWithFrame:CGRectMake(20, 60, CGRectGetWidth(self.view.frame) - 40, 36)];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.maxLength = 10;
        _textField.limitEmoji = YES;
        _textField.keyboardType = UIKeyboardTypeDefault;
        _textField.delegate = self;
    }
    return _textField;
}

- (FYFTextView *)textView {
    if (!_textView) {
        _textView = [[FYFTextView alloc]initWithFrame:CGRectMake(20, 150, CGRectGetWidth(self.view.frame) - 40, 100)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.maxLength = 10;
        _textView.limitEmoji = YES;
        _textView.delegate = self;
        _textView.placeholder = @"请输入旅行介绍";
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.textColor = [UIColor darkGrayColor];
    }
    return _textView;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 120, CGRectGetMaxY(self.textField.frame) + 4, 100, 20)];
        _countLabel.font = [UIFont systemFontOfSize:15];
        _countLabel.textColor = [UIColor darkGrayColor];
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.text = @"0";
    }
    return _countLabel;
}

- (UILabel *)textViewCountLabel {
    if (!_textViewCountLabel) {
        _textViewCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 120, CGRectGetMaxY(self.textView.frame) + 4, 100, 20)];
        _textViewCountLabel.font = [UIFont systemFontOfSize:15];
        _textViewCountLabel.textColor = [UIColor darkGrayColor];
        _textViewCountLabel.textAlignment = NSTextAlignmentRight;
        _textViewCountLabel.text = @"0";
    }
    return _textViewCountLabel;
}



@end
