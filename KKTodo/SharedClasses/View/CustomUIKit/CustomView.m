//
//  CustomView.m
//  KKTodo
//
//  Created by David Wang on 2019/2/18.
//  Copyright © 2019 David Wang. All rights reserved.
//

#import "CustomView.h"

@interface CustomView ()

@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@property (strong ,nonatomic) IBInspectable UIColor *borderColor;

@property (strong ,nonatomic) IBInspectable UIColor *shadowColor;
@property (assign, nonatomic) IBInspectable CGFloat shadowRadius;
@property (assign, nonatomic) IBInspectable CGFloat shadowOpacity;
@property (assign, nonatomic) IBInspectable CGSize shadowOffset;

@property (strong, nonatomic) UIView *baseShadowView;

@end

@implementation CustomView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self baseViewSetupUI];
}

- (void)baseViewSetupUI {
    if (self.cornerRadius > 0) {
        self.layer.cornerRadius = self.cornerRadius;
        self.layer.masksToBounds = YES;
    }
    if (self.borderWidth > 0) {
        self.layer.borderWidth = self.borderWidth;
        self.layer.borderColor = self.borderColor.CGColor;
    }
    if (self.shadowOpacity > 0) {
        [self baseViewSetupShadow];
    }
}

- (void)baseViewSetupShadow {
    if (self.baseShadowView) {
        [self.baseShadowView removeFromSuperview];
        self.baseShadowView = nil;
    }
    self.baseShadowView = [[UIView alloc] initWithFrame:self.frame];
    [self.baseShadowView setBackgroundColor:self.backgroundColor];
    
    [self.baseShadowView.layer setCornerRadius:self.layer.cornerRadius];
    [self.baseShadowView.layer setMasksToBounds:NO];
    [self.baseShadowView.layer setShadowColor:self.shadowColor.CGColor];
    [self.baseShadowView.layer setShadowRadius:self.shadowRadius];
    [self.baseShadowView.layer setShadowOpacity:self.shadowOpacity];
    [self.baseShadowView.layer setShadowOffset:self.shadowOffset];
    
    [self.superview insertSubview:self.baseShadowView belowSubview:self];
    
    self.baseShadowView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.baseShadowView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.baseShadowView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.baseShadowView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.baseShadowView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    [self.superview addConstraints:@[top,bottom,leading,trailing]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.baseShadowView setFrame:self.frame];
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    [self.baseShadowView setHidden:hidden];
}

- (void)setAlpha:(CGFloat)alpha {
    [super setAlpha:alpha];
    [self.baseShadowView setAlpha:alpha];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self.baseShadowView setFrame:frame];
}

- (void)setTransform:(CGAffineTransform)transform {
    [super setTransform:transform];
    [self.baseShadowView setTransform:transform];
}

@end
