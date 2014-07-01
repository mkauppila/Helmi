//
//  SpecHelper.m
//  Helmi
//
//  Created by markus on 4.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "SpecHelper.h"

NSDictionary *LoadTestData(NSString *fileName)
{
    NSString *pathToTestData = [[NSBundle bundleWithIdentifier:@"UnitTest"]
                                pathForResource:fileName ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:pathToTestData];
    return [NSJSONSerialization JSONObjectWithData:jsonData
                                           options:NSJSONReadingMutableContainers
                                             error:NULL];
}
