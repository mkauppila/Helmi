//
// Copyright (c) 2014 Markus Kauppila <markus.kauppila@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "HELLoanableItem.h"

@interface HELLoanableItem ()
@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *circulationStatus;
@property (nonatomic, strong) NSDate *dueDate;

@property (nonatomic, copy) NSString *authorFirstName;
@property (nonatomic, copy) NSString *authorLastName;
@end

@implementation HELLoanableItem

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
}

- (void)loadMetaInformationFrom:(NSDictionary *)itemInfo
{
    self.title = itemInfo[@"title"];
    self.authorFirstName = [self parseAuthorFirstName:itemInfo[@"author"]];
    self.authorLastName = [self parseAuthorLastName:itemInfo[@"author"]];
    
    // TODO: parse publisher, year
    // We need to get the dueDate, circulationStatus using the other API
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

- (NSString *)parseAuthorFirstName:(NSString *)author
{
    NSString *firstName = [[author componentsSeparatedByString:@","] firstObject];
    return [firstName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)parseAuthorLastName:(NSString *)author
{
    NSString *lastName = [[author componentsSeparatedByString:@","] lastObject];
    return [lastName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)parseCirculationStatus:(NSDictionary *)circulationInfo
{
    return circulationInfo[@"name"];
}

@end
