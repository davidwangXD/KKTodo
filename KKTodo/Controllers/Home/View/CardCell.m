//
//  CardCell.m
//  KKTodo
//
//  Created by David Wang on 2019/2/18.
//  Copyright © 2019 David Wang. All rights reserved.
//

#import "CardCell.h"
#import "CardModel.h"

@interface CardCell ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (nonatomic, weak) IBOutlet CustomLabel *cardTitleLabel;
@property (nonatomic, weak) IBOutlet CustomTextField *cardTitleTextField;

@property (nonatomic, weak) id<CardCellDelegate> delegate;
@property (nonatomic, strong) CardModel *card;

@end

@implementation CardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI {
    [self.cardTitleLabel addGestureRecognizer:({
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cardTitlePress:)];
    })];
    self.cardTitleLabel.userInteractionEnabled = YES;
    __weak typeof(self) weakSelf = self;
    self.cardTitleTextField.textFieldDidEndEditingBlock = ^{
        weakSelf.cardTitleTextField.hidden = YES;
        if (weakSelf.cardTitleTextField.text.length && [weakSelf.delegate respondsToSelector:@selector(cardCellDidRenameCard:withTitle:)]) {
            [weakSelf.delegate cardCellDidRenameCard:weakSelf.card withTitle:weakSelf.cardTitleTextField.text];
        }
    };
    [self addGestureRecognizer:({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing:)];
        tap.cancelsTouchesInView = NO;
        tap;
    })];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
}

- (void)setupWithCard:(CardModel *)card index:(NSInteger)index delegate:(id<CardCellDelegate>)delegate {
    self.card = card;
    self.delegate = delegate;
    self.cardTitleLabel.text = self.card.title;
    self.tableView.tag = index;
    [self updateTableView];
}

- (void)updateTableView {
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    CGFloat height = self.tableView.contentSize.height;
    CGFloat maxHeight = self.bounds.size.height - 44.0 - [self.tableView.superview convertRect:self.tableView.frame toView:self].origin.y - 15.0;
    self.tableViewHeight.constant = height < maxHeight ? height : maxHeight;
    self.tableView.scrollEnabled = !(height < maxHeight);
    [self.tableView.superview layoutIfNeeded];
}

#pragma mark - Actions
- (IBAction)addTaskButtonPress:(UIButton *)sender {
    [self endEditing:NO];
    if ([self.delegate respondsToSelector:@selector(cardCellDidPressAddTaskWithCard:)]) {
        [self.delegate cardCellDidPressAddTaskWithCard:self.card];
    }
}

- (IBAction)optionButtonPress:(UIButton *)sender {
    [self endEditing:NO];
    if ([self.delegate respondsToSelector:@selector(cardCellDidPressOptionWithCard:)]) {
        [self.delegate cardCellDidPressOptionWithCard:self.card];
    }
}

- (IBAction)cardTitlePress:(id)sender {
    self.cardTitleTextField.text = self.cardTitleLabel.text;
    self.cardTitleTextField.hidden = NO;
    [self.cardTitleTextField becomeFirstResponder];
}

@end
