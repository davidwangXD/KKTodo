//
//  TaskModel.h
//  KKTodo
//
//  Created by David Wang on 2019/2/19.
//  Copyright © 2019 David Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskModel : NSObject <NSCoding>

@property (nonatomic, copy) NSString *title;
- (instancetype)initWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
