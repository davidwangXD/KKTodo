//
//  CardCell.h
//  KKTodo
//
//  Created by David Wang on 2019/2/18.
//  Copyright © 2019 David Wang. All rights reserved.
//

#import "BaseCollectionViewCell.h"
@class CardModel;


NS_ASSUME_NONNULL_BEGIN

@protocol CardCellDelegate <NSObject>

- (void)cardCellDidPressAddTaskWithCard:(CardModel *)card;
- (void)cardCellDidPressOptionWithCard:(CardModel *)card;
- (void)cardCellDidRenameCard:(CardModel *)card withTitle:(NSString *)newTitle;

@end

@interface CardCell : BaseCollectionViewCell

- (void)setupWithCard:(CardModel *)card index:(NSInteger)index delegate:(id<CardCellDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
