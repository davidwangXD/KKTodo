//
//  CustomTextView.m
//  KKTodo
//
//  Created by David Wang on 2019/2/18.
//  Copyright © 2019 David Wang. All rights reserved.
//

#import "CustomTextView.h"

@interface CustomTextView () <UITextViewDelegate>

@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@property (strong ,nonatomic) IBInspectable UIColor *borderColor;

@property (assign, nonatomic) IBInspectable UIEdgeInsets containerInset;
@property (assign, nonatomic) IBInspectable CGFloat leftInset;
@property (assign, nonatomic) IBInspectable CGFloat topInset;
@property (assign, nonatomic) IBInspectable CGFloat fragmentPadding;
@property (assign, nonatomic) IBInspectable BOOL enableDrag;

@property (strong, nonatomic) IBInspectable NSString *placeholder;
@property (strong, nonatomic) IBInspectable UIColor *placeholderColor;

@end

@implementation CustomTextView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        self.cornerRadius = 0;
        self.borderWidth = 0;
        self.borderColor = nil;
        self.containerInset = UIEdgeInsetsZero;
        self.fragmentPadding = 0;
        self.enableDrag = NO;
        self.placeholder = nil;
        self.placeholderColor = nil;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI {
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
    self.textContainerInset = UIEdgeInsetsMake(self.topInset, self.leftInset, self.topInset, self.leftInset);
    self.textContainer.lineFragmentPadding = self.fragmentPadding;
    if (@available(iOS 11.0, *)) {
        self.textDragInteraction.enabled = self.enableDrag;
    }
    self.linkTextAttributes = @{};
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

#pragma mark - Placeholder
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)textDidChange:(NSNotification *)notification {
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.placeholder.length == 0 || self.hasText) {
        return;
    }
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    rect.origin.x = self.leftInset;
    rect.origin.y = self.topInset;
    rect.size.width -= 2 * rect.origin.x;
    rect.size.height -= 2 * rect.origin.y;
    [self.placeholder drawInRect:rect withAttributes:attrs];
}

@end
