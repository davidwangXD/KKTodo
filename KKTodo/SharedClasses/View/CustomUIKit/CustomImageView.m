//
//  CustomImageView.m
//  KKTodo
//
//  Created by David Wang on 2019/2/18.
//  Copyright © 2019 David Wang. All rights reserved.
//

#import "CustomImageView.h"

@interface CustomImageView ()

@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@property (strong ,nonatomic) IBInspectable UIColor *borderColor;

@property (strong ,nonatomic) IBInspectable UIColor *shadowColor;
@property (assign, nonatomic) IBInspectable CGFloat shadowRadius;
@property (assign, nonatomic) IBInspectable CGFloat shadowOpacity;
@property (assign, nonatomic) IBInspectable CGSize shadowOffset;

@property (strong, nonatomic) UIView *baseShadowView;

@end

@implementation CustomImageView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.shadowColor = nil;
        self.shadowRadius = 0;
        self.shadowOpacity = 0;
        self.shadowOffset = CGSizeZero;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI {
    self.clipsToBounds = YES;
    if (self.cornerRadius > 0) {
        self.layer.cornerRadius = self.cornerRadius;
    }
    if (self.borderWidth > 0) {
        self.layer.borderWidth = self.borderWidth;
        self.layer.borderColor = self.borderColor.CGColor;
    }
    if (self.shadowOpacity > 0) {
        [self setupShadow];
    }
}

- (void)setupShadow {
    if (self.layer.cornerRadius > 0) {
        self.baseShadowView = [[UIView alloc] initWithFrame:self.frame];
        [self.baseShadowView setBackgroundColor:self.backgroundColor];
        
        [self.baseShadowView.layer setCornerRadius:self.layer.cornerRadius];
        [self.baseShadowView.layer setMasksToBounds:NO];
        [self.baseShadowView.layer setShadowColor:self.shadowColor.CGColor];
        [self.baseShadowView.layer setShadowRadius:self.shadowRadius];
        [self.baseShadowView.layer setShadowOpacity:self.shadowOpacity];
        [self.baseShadowView.layer setShadowOffset:self.shadowOffset];
        
        [self.superview insertSubview:self.baseShadowView belowSubview:self];
    } else {
        [self.layer setShadowColor:self.shadowColor.CGColor];
        [self.layer setShadowRadius:self.shadowRadius];
        [self.layer setShadowOpacity:self.shadowOpacity];
        [self.layer setShadowOffset:self.shadowOffset];
    }
}

#pragma mark Override
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self.baseShadowView setFrame:frame];
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    [self.baseShadowView setHidden:hidden];
}

- (void)setAlpha:(CGFloat)alpha {
    [super setAlpha:alpha];
    [self.baseShadowView setAlpha:alpha];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.baseShadowView setFrame:self.frame];
}

@end

