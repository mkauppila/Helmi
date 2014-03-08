//
//  LoginViewModel.m
//  Helmi
//
//  Created by markus on 12.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "LoginViewModel.h"

#import <ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>

#import "HelmetAPIClient.h"

#import "User.h"
#import "LoanableItem.h"

@interface LoginViewModel ()
@property (strong, nonatomic, readonly) HelmetAPIClient *apiClient;
@end

@implementation LoginViewModel

- (instancetype)initWithAPIClient:(HelmetAPIClient *)apiClient
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
        
        self.currentUser = [[User alloc] initWithUserInfo:userInfo
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
        [items addObject:[[LoanableItem alloc] initWithIdentifier:identifier]];
    }];
    
    return items;
}

- (void)fetchInformationForLoanableItems:(NSArray *)loanableItems
{
    [loanableItems enumerateObjectsUsingBlock:^(LoanableItem *item, NSUInteger idx, BOOL *stop) {
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
