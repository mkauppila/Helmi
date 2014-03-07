//
//  LoanCell.m
//  Helmi
//
//  Created by markus on 6.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "LoanCell.h"

#import <ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>

#import "LoanableItem.h"



@implementation LoanCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setLoanableItem:(LoanableItem *)item
{
    
}

@end