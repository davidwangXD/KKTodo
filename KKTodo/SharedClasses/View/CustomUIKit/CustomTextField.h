//
//  CustomTextField.h
//  KKTodo
//
//  Created by David Wang on 2019/2/18.
//  Copyright © 2019 David Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTextField : UITextField

@property (nullable, strong, nonatomic) void (^textFieldDidEndEditingBlock)(void);

@end

NS_ASSUME_NONNULL_END
