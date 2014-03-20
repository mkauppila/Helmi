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

#import "HELLoginViewModel.h"

#import <ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>

#import "HELApiClient.h"

#import "HELUser.h"
#import "HELLoanableItem.h"

@interface HELLoginViewModel ()
@property (strong, nonatomic, readonly) HELApiClient *apiClient;
@end

@implementation HELLoginViewModel

- (instancetype)initWithAPIClient:(HELApiClient *)apiClient
{
    self = [super init];
    if (self) {
        _apiClient = apiClient;
    }
    return self;
}

- (void)initializeForLogin
{
    self.didSucceedToLogin = NO;
    self.loginErrorMessage = @"";
}

- (RACCommand *)logInCommand
{
    @weakify(self);
    
    RACSignal *enabled = [RACSignal combineLatest:@[RACObserve(self, libraryCardNumber),
                                                    RACObserve(self, pinCode)]
                                           reduce:^(NSString *cardNumber, NSString *pinCode) {
                                               return @([self validateLibraryCardNumber:cardNumber] &&
                                                        [self validatePinCode:pinCode]);
                                           }];
    RACCommand *login = [[RACCommand alloc] initWithEnabled:enabled
                                                signalBlock:^RACSignal *(id input) {
                                                    @strongify(self);
                                                    return [self initiateLogIn];
                                                }];
    login.allowsConcurrentExecution = NO;
    return login;
}

- (BOOL)validateLibraryCardNumber:(NSString *)cardNumber
{
    return cardNumber.length > 0;
}

- (BOOL)validatePinCode:(NSString *)pinCode
{
    return pinCode.length >= 4;
}

- (RACSignal *)initiateLogIn
{
    NSLog(@"library card number: %@", self.libraryCardNumber);
    NSLog(@"pin code: %@", self.pinCode);
    

    RACSignal *s = [self.apiClient executeLogIn:self.libraryCardNumber
                                        pinCode:self.pinCode];
    
    @weakify(self);
    [s subscribeNext:^(RACTuple *response) {
        @strongify(self);
        NSLog(@"first: %@", response.first);
        NSLog(@"second: %@", response.second);
        
        NSDictionary *userInfo = response.last;
        
        NSArray *loanableItems = [self createLoanableItems:userInfo];
        [self fetchInformationForLoanableItems:loanableItems];
        
        self.currentUser = [[HELUser alloc] initWithUserInfo:userInfo
                                         andLoanableItems:loanableItems];
        NSLog(@"user: %@", self.currentUser);
        
        self.didSucceedToLogin = YES;
    } error:^(NSError *error) {
        NSLog(@"network error: %@", error);
    }];

    return s;
}

- (NSArray *)createLoanableItems:(NSDictionary *)userInfo
{
    NSDictionary *allItems = userInfo[@"items"];
    NSMutableArray *identifiers = [NSMutableArray array];
    [identifiers addObjectsFromArray:allItems[@"charged items"]];
    [identifiers addObjectsFromArray:allItems[@"overdue items"]];

    NSMutableArray *items = [NSMutableArray array];
    [identifiers enumerateObjectsUsingBlock:^(NSString *identifier, NSUInteger idx, BOOL *stop) {
        [items addObject:[[HELLoanableItem alloc] initWithIdentifier:identifier]];
    }];
    
    return items;
}

- (void)fetchInformationForLoanableItems:(NSArray *)loanableItems
{
    [loanableItems enumerateObjectsUsingBlock:^(HELLoanableItem *item, NSUInteger idx, BOOL *stop) {
        RACSignal *fetch = [self.apiClient fetchInformationForLoanableItem:item];
        
        [fetch subscribeNext:^(RACTuple *response) {
            NSLog(@"fill item: %@", [item identifier]);
            NSLog(@"with: %@", response.second);
            
            [item loadInformationFrom:response.second];
        } error:^(NSError *error) {
            NSLog(@"failed to fetch information for item: %@", [item identifier]);
        }];
    }];
}

@end