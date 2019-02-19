//
//  TaskModel.m
//  KKTodo
//
//  Created by David Wang on 2019/2/19.
//  Copyright © 2019 David Wang. All rights reserved.
//

#import "TaskModel.h"

@implementation TaskModel

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}

#pragma mark - NSCoding

static NSString * const titleKey = @"TaskModelTitle";

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:titleKey];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:titleKey];
    }
    return self;
}

@end
