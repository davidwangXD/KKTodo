//
//  AddCardCell.h
//  KKTodo
//
//  Created by David Wang on 2019/2/18.
//  Copyright © 2019 David Wang. All rights reserved.
//

#import "BaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AddCardCellDelegate <NSObject>

- (void)addCardCellDidPressAddCard;

@end

@interface AddCardCell : BaseCollectionViewCell

- (void)setupWithDelegate:(id<AddCardCellDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
