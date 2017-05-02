//
//  one.m
//  sampleDelegate
//
//  Created by Chandrasekhar Pasumarthi on 06/06/15.
//  Copyright (c) 2015 chandu. All rights reserved.
//

#import "one.h"

@implementation one
@synthesize delegate;
-(void)sayHello
{
    [delegate display];
}
@end
