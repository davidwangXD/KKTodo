//
//  AddCardCell.m
//  KKTodo
//
//  Created by David Wang on 2019/2/18.
//  Copyright © 2019 David Wang. All rights reserved.
//

#import "AddCardCell.h"
#import "KKTodo-Swift.h"

@interface AddCardCell()

@property (nonatomic, weak) id<AddCardCellDelegate> delegate;

@end

@implementation AddCardCell

- (void)setupWithDelegate:(id<AddCardCellDelegate>)delegate {
    self.delegate = delegate;
}

- (IBAction)addCardButtonPress:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(addCardCellDidPressAddCard)]) {
        [self.delegate addCardCellDidPressAddCard];
    }
}

@end
