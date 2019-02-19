//
//  CustomTextField.m
//  KKTodo
//
//  Created by David Wang on 2019/2/18.
//  Copyright © 2019 David Wang. All rights reserved.
//

#import "CustomTextField.h"
#import "KKTodo-Swift.h"

@interface CustomTextField () <UITextFieldDelegate>

@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@property (strong, nonatomic) IBInspectable UIColor *borderColor;

@property (strong, nonatomic) IBInspectable UIColor *placeholderColor;
@property (assign, nonatomic) IBInspectable CGFloat textInset;

@property (assign, nonatomic) IBInspectable BOOL digitOnly;
@property (assign, nonatomic) IBInspectable NSInteger maxLength;

@end

@implementation CustomTextField

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.cornerRadius = 0;
        self.borderWidth = 0;
        self.borderColor = nil;
        self.placeholderColor = nil;
        self.textInset = 0;
        self.digitOnly = NO;
        self.maxLength = 0;
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
    [self addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventValueChanged];
}

- (void)setupUI {
    if (self.placeholder.length && self.placeholderColor) {
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:self.placeholder];
        [placeholder addAttribute:NSForegroundColorAttributeName
                            value:self.placeholderColor
                            range:NSMakeRange(0, self.placeholder.length)];
        [placeholder addAttribute:NSFontAttributeName
                            value:self.font
                            range:NSMakeRange(0, self.placeholder.length)];
        self.attributedPlaceholder = placeholder;
    }
    
    if (self.cornerRadius > 0) {
        self.layer.cornerRadius = self.cornerRadius;
        self.layer.masksToBounds = YES;
    }
    if (self.borderWidth > 0) {
        self.layer.borderWidth = self.borderWidth;
        self.layer.borderColor = self.borderColor.CGColor;
    }
    if (self.delegate == nil) {
        self.delegate = self;
    }
}
// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.textInset, 0);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.textInset, 0);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidChange {
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.maxLength > 0) {
        if ((textField.text.length - range.length + string.length) <= self.maxLength) {
            if (self.digitOnly && string.length) {
                return [RegExTool validateDigits:string];
            }
            return YES;
        } else {
            return NO;
        }
    }
    if (self.digitOnly && string.length) {
        return [RegExTool validateDigits:string];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.textFieldDidEndEditingBlock) self.textFieldDidEndEditingBlock();
}

#pragma mark - Methods


@end
