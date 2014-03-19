//
//  LoanTableDataSource.m
//  Helmi
//
//  Created by markus on 3.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "HELLoanTableDataSource.h"

@interface HELLoanTableDataSource ()
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *reuseIdentifier;
@property (nonatomic, copy) LoanTableViewCellConfigureBlock cellConfigurator;
@end

@implementation HELLoanTableDataSource

- (instancetype)initWithItems:(NSArray *)items
              reuseIdentifier:(NSString *)reuseIdentifier
       cellConfigurationBlock:(LoanTableViewCellConfigureBlock)block
{
    self = [super init];
    if (self) {
        _items = items;
        _reuseIdentifier = reuseIdentifier;
        _cellConfigurator = block;
    }
    return self;
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier
                                                            forIndexPath:indexPath];
    
    id item = self.items[indexPath.row];
    self.cellConfigurator(cell, item);
    return cell;
}



@end
