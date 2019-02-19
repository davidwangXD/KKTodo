//
//  CustomButton.m
//  KKTodo
//
//  Created by David Wang on 2019/2/18.
//  Copyright © 2019 David Wang. All rights reserved.
//

#import "CustomButton.h"

@interface CustomButton ()

@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@property (strong ,nonatomic) IBInspectable UIColor *borderColor;

@property (strong ,nonatomic) IBInspectable UIColor *shadowColor;
@property (assign, nonatomic) IBInspectable CGFloat shadowRadius;
@property (assign, nonatomic) IBInspectable CGFloat shadowOpacity;
@property (assign, nonatomic) IBInspectable CGSize shadowOffset;

@property (strong ,nonatomic) UIColor *originalBackgroundColor;
@property (assign ,nonatomic) CGColorRef originalBorderColor;

@property (strong ,nonatomic) IBInspectable UIColor *highlightColor;
@property (assign ,nonatomic) IBInspectable CGFloat highlightContentAlpha;

@property (strong ,nonatomic) IBInspectable UIColor *selectedBackgroundColor;

@end

@implementation CustomButton

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.highlightContentAlpha = 1.0;
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
    }
    if (self.borderWidth > 0) {
        self.layer.borderWidth = self.borderWidth;
        self.layer.borderColor = self.borderColor.CGColor;
    }
    if (self.shadowColor) {
        [self.layer setShadowColor:self.shadowColor.CGColor];
    }
    if (self.shadowRadius) {
        [self.layer setShadowRadius:self.shadowRadius];
    }
    if (self.shadowOpacity) {
        [self.layer setShadowOpacity:self.shadowOpacity];
    }
    if (self.shadowOffset.width != 0 || self.shadowOffset.height != 0) {
        [self.layer setShadowOffset:self.shadowOffset];
    }
    [self setOriginalBackgroundColor:self.backgroundColor ? self.backgroundColor : [UIColor clearColor]];
    [self setOriginalBorderColor:self.layer.borderColor];
}

- (void)setHighlightColor:(UIColor *)highlightColor {
    _highlightColor = highlightColor;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted && self.highlightColor) {
        [self setBackgroundColor:self.highlightColor];
        if (self.borderWidth > 0) {
            [self.layer setBorderColor:self.highlightColor.CGColor];
        }
    } else if (!highlighted && self.highlightColor) {
        if ([self.backgroundColor isEqual:self.highlightColor]) {
            if (self.selected) {
                [self setBackgroundColor:self.selectedBackgroundColor];
            } else {
                [self setBackgroundColor:self.originalBackgroundColor];
            }
        }
        if (self.borderWidth > 0) {
            if (self.layer.borderColor == self.highlightColor.CGColor) [self.layer setBorderColor:self.originalBorderColor];
        }
    }
    
    if (highlighted && self.highlightContentAlpha) {
        [self.titleLabel setAlpha:self.highlightContentAlpha];
        [self.imageView setAlpha:self.highlightContentAlpha];
    } else if (!highlighted && self.highlightContentAlpha) {
        [self.titleLabel setAlpha:1.0];
        [self.imageView setAlpha:1.0];
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (self.selected && self.selectedBackgroundColor) {
        [self setBackgroundColor:self.selectedBackgroundColor];
    } else if (!self.selected && self.selectedBackgroundColor) {
        [self setBackgroundColor:self.originalBackgroundColor];
    }
}

@end
