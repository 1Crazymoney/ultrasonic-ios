//
//  Singleton.m
//  TestSoundPayment
//
//  Created by Chandra Pasumarthi on 30/4/19.
//  Copyright © 2019 Chandra Pasumarthi. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

static Singleton *sharedInstance = nil;
// Get the shared instance and create it if necessary.
+ (Singleton *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init
{
    self = [super init];
    
    if (self) {
        // Work your initialising magic here as you normally would
        self.str = @"initial value";
    }
    
    return self;
}
@end
