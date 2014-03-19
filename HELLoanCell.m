//
//  LoanCell.m
//  Helmi
//
//  Created by markus on 6.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "HELLoanCell.h"

#import <ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>

#import "HELLoanableItem.h"

@implementation HELLoanCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setLoanableItem:(HELLoanableItem *)item
{
    _loanableItem = item;
    
    @weakify(self)
    [[RACObserve(item, title) ignore:nil] subscribeNext:^(NSString *title) {
        @strongify(self);
        self.titleLabel.text = title;
    }];
}

@end
