//
//  Loan.m
//  Helmi
//
//  Created by markus on 3.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "LoanableItem.h"

@interface LoanableItem ()
@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *circulationStatus;
@property (nonatomic, strong) NSDate *dueDate;

@property (nonatomic, copy) NSString *authorFirstName;
@property (nonatomic, copy) NSString *authorLastName;
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
    self.title = [self parseBookTitle:itemInfo[@"title identifier"]];
    self.circulationStatus = [self parseCirculationStatus:itemInfo[@"circulation status"]];
    self.dueDate = [self parseDueDateFrom:itemInfo[@"due date"]];
    
    self.authorFirstName = [self parseAuthorFirstName:itemInfo[@"title identifier"]];
    self.authorLastName = [self parseAuthorLastName:itemInfo[@"title identifier"]];
}

- (NSDate *)parseDueDateFrom:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    return [formatter dateFromString:dateString];
}

- (NSString *)parseBookTitle:(NSString *)fullTitle
{
    NSArray *components = [fullTitle componentsSeparatedByString:@"/"];
    return [[components firstObject] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)parseAuthorFirstName:(NSString *)fullTitle
{
    NSArray *components = [fullTitle componentsSeparatedByString:@"/"];
    
    NSString *fullNameString = [[components lastObject] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *nameParts = [fullNameString componentsSeparatedByString:@" "];
    
    return [nameParts firstObject];
}

- (NSString *)parseAuthorLastName:(NSString *)fullTitle
{
    NSArray *components = [fullTitle componentsSeparatedByString:@"/"];
    
    NSString *fullNameString = [[components lastObject] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *nameParts = [fullNameString componentsSeparatedByString:@" "];
    
    return [nameParts lastObject];
}

- (NSString *)parseCirculationStatus:(NSDictionary *)circulationInfo
{
    return circulationInfo[@"name"];
}

@end
