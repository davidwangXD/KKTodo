//
//  CustomLabel.m
//  KKTodo
//
//  Created by David Wang on 2019/2/18.
//  Copyright © 2019 David Wang. All rights reserved.
//

#import "CustomLabel.h"

@interface CustomLabel ()

@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@property (strong ,nonatomic) IBInspectable UIColor *borderColor;

@end

@implementation CustomLabel


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
}

@end
