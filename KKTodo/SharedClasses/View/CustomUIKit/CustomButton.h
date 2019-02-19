//
//  CustomButton.h
//  KKTodo
//
//  Created by David Wang on 2019/2/18.
//  Copyright © 2019 David Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomButton : UIButton

- (void)setHighlightColor:(UIColor *)highlightColor;
- (void)setupUI;

@end

NS_ASSUME_NONNULL_END