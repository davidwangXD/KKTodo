//
//  CardModel.m
//  KKTodo
//
//  Created by David Wang on 2019/2/19.
//  Copyright © 2019 David Wang. All rights reserved.
//

#import "CardModel.h"


@implementation CardModel


- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.title = title;
        self.tasks = [NSMutableArray new];
    }
    return self;
}

#pragma mark - NSCoding

static NSString * const titleKey = @"CardModelTitle";
static NSString * const tasksKey = @"CardModelTasks";

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:titleKey];
    [aCoder encodeObject:self.tasks forKey:tasksKey];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:titleKey];
        self.tasks = [aDecoder decodeObjectForKey:tasksKey];
    }
    return self;
}


@end
