//
//  TaskCell.h
//  KKTodo
//
//  Created by David Wang on 2019/2/18.
//  Copyright © 2019 David Wang. All rights reserved.
//

#import "BaseTableViewCell.h"
@class TaskModel;

NS_ASSUME_NONNULL_BEGIN

@interface TaskCell : BaseTableViewCell

- (void)setupWithTask:(TaskModel *)task;

@end

NS_ASSUME_NONNULL_END
