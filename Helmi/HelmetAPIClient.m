//
//  HelmetAPIClient.m
//  Helmi
//
//  Created by markus on 21.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "HelmetAPIClient.h"

#import <ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>
#import <AFHTTPRequestOperationManager+RACSupport.h>

@interface HelmetAPIClient () {
    AFHTTPRequestOperationManager *_manager;
}
@property (strong, nonatomic, readonly) NSString *user;
@property (strong, nonatomic, readonly) NSString *password;
@end

@implementation HelmetAPIClient

- (RACSignal *)executeLogIn:(NSString *)libraryCardNumber pinCode:(NSString *)pinCode
{
    [self setUserName:libraryCardNumber andPassword:pinCode];
    
    RACSignal *login = [[self manager] rac_GET:[self loginUrl] parameters:nil];
    login = [[login logAll] replayLazily];
    return login;
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
