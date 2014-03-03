//
//  LoanTableDataSource.h
//  Helmi
//
//  Created by markus on 3.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^LoanTableViewCellConfigureBlock)(id cell, id item);

@interface LoanTableDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithItems:(NSArray *)data
              reuseIdentifier:(NSString *)reuseIdentifier
       cellConfigurationBlock:(LoanTableViewCellConfigureBlock)block;

@end
