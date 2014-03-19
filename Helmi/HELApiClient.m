//
//  HelmetAPIClient.m
//  Helmi
//
//  Created by markus on 21.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "HELApiClient.h"

#import <ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>
#import <AFHTTPRequestOperationManager+RACSupport.h>

#import "LoanableItem.h"

@interface HELApiClient () {
    AFHTTPRequestOperationManager *_manager;
}
@property (strong, nonatomic, readonly) NSString *user;
@property (strong, nonatomic, readonly) NSString *password;
@end

@implementation HELApiClient

+ (instancetype)sharedInstance
{
    static HELApiClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[HELApiClient alloc] init];
    });
    return client;
}

- (RACSignal *)executeLogIn:(NSString *)libraryCardNumber pinCode:(NSString *)pinCode
{
    [self setUserName:libraryCardNumber andPassword:pinCode];
    
    RACSignal *login = [[self manager] rac_GET:[self loginUrl] parameters:nil];
    login = [login logAll];
    return [login replayLazily];
}

- (void)setUserName:(NSString *)userName andPassword:(NSString *)password
{
    _user = userName;
    _password = password;
}

- (NSString *)loginUrl
{
    return [NSString stringWithFormat:@"https://lainakortti.helmet-kirjasto.fi/patron/%@",
            self.user];
}

- (RACSignal *)fetchInformationForLoanableItem:(LoanableItem *)item
{
    RACSignal *fetch = [[self manager] rac_GET:[self itemInformationUrlForItem:[item identifier]]
                                    parameters:nil];
    fetch = [fetch logAll];
    return [fetch replayLazily];
}

- (NSString *)itemInformationUrlForItem:(NSString *)itemIdentifier
{
    return [NSString stringWithFormat:@"https://lainakortti.helmet-kirjasto.fi/item/%@",
            itemIdentifier];
}

- (RACSignal *)renewLoan:(LoanableItem *)item
{
    RACSignal *renew = [[self manager] rac_POST:[self urlForRenewingLoan:[item identifier]] parameters:nil];
    [renew logAll];
    return [renew replayLazily];
}

- (NSString *)urlForRenewingLoan:(NSString *)identifier
{
    return [NSString stringWithFormat:@"https://lainakortti.helmet-kirjasto.fi/patron/%@/loan?item=%@", self.user, identifier];
}

- (AFHTTPRequestOperationManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer new];
        
        [_manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
        [[_manager requestSerializer] setAuthorizationHeaderFieldWithUsername:self.user
                                                                     password:self.password];

    }
    return _manager;
}

@end
