//
//  CardModel.h
//  KKTodo
//
//  Created by David Wang on 2019/2/19.
//  Copyright © 2019 David Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardModel : NSObject <NSCoding>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy, nullable) NSString *tempTask;
@property (nonatomic, strong) NSMutableArray<TaskModel *> *tasks;
- (instancetype)initWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
