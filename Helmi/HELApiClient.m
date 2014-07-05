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

#import "HELApiClient.h"

#import <ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>
#import <AFHTTPRequestOperationManager+RACSupport.h>

#import "HELLoanableItem.h"

static NSString *const kBaseUrl = @"https://lainakortti.helmet-kirjasto.fi";

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
    return [login replayLazily];
}

- (void)setUserName:(NSString *)userName andPassword:(NSString *)password
{
    _user = userName;
    _password = password;
}

- (NSString *)loginUrl
{
    return [kBaseUrl stringByAppendingFormat:@"/patron/%@", self.user];
}

- (RACSignal *)fetchMetaInformationForLoanableItems:(NSArray *)items
{
    if ([items count] == 0) {
        return [RACSignal empty];
    }
   
    return [[[self manager] rac_GET:[self urlForMetaInformationOfLoanableItems:items]
                         parameters:nil]
            replayLazily];
}

- (NSString *)urlForMetaInformationOfLoanableItems:(NSArray *)items
{
    __block NSString *url = @"http://metadata.helmet-kirjasto.fi/search/item.json?";
    [items enumerateObjectsUsingBlock:^(HELLoanableItem *item, NSUInteger idx, BOOL *stop) {
        url = [url stringByAppendingFormat:@"query[]=%@&", [item identifier]];
    }];
    return url;
}

- (RACSignal *)fetchInformationForLoanableItem:(HELLoanableItem *)item
{
    RACSignal *fetch = [[self manager] rac_GET:[self itemInformationUrlForItem:[item identifier]]
                                    parameters:nil];
    return [fetch replayLazily];
}

- (NSString *)itemInformationUrlForItem:(NSString *)itemIdentifier
{
    return [kBaseUrl stringByAppendingFormat:@"/item/%@", itemIdentifier];
}

- (RACSignal *)renewLoan:(HELLoanableItem *)item
{
    RACSignal *renew = [[self manager] rac_POST:[self urlForRenewingLoan:[item identifier]] parameters:nil];
    return [renew replayLazily];
}

- (NSString *)urlForRenewingLoan:(NSString *)identifier
{
    return [kBaseUrl stringByAppendingFormat:@"/patron/%@/loan?item=%@", self.user, identifier];
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
