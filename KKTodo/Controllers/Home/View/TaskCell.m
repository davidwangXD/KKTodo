//
//  TaskCell.m
//  KKTodo
//
//  Created by David Wang on 2019/2/18.
//  Copyright © 2019 David Wang. All rights reserved.
//

#import "TaskCell.h"
#import "TaskModel.h"

@interface TaskCell ()

@property (nonatomic, weak) IBOutlet CustomLabel *titleLabel;
@property (nonatomic, strong) TaskModel *task;

@end

@implementation TaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupWithTask:(TaskModel *)task {
    self.task = task;
    self.titleLabel.text = task.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}

@end
