//
//  Loan.m
//  Helmi
//
//  Created by markus on 3.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "LoanableItem.h"

@interface LoanableItem ()
@end

@implementation LoanableItem

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    self = [super init];
    if (self) {
        _identifier = identifier;
    }
    return self;
}

- (void)loadInformationFrom:(NSDictionary *)itemInfo
{
    _dueDate = [self parseDueDateFrom:itemInfo[@"due date"]];
    _title = [self parseBookTitle:itemInfo[@"title identifier"]];
}

- (NSString *)parseBookTitle:(NSString *)fullTitle
{
    NSArray *components = [fullTitle componentsSeparatedByString:@"/"];
    return [[components firstObject] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSDate *)parseDueDateFrom:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    return [formatter dateFromString:dateString];
}


@end
