//
//  two.m
//  sampleDelegate
//
//  Created by Chandrasekhar Pasumarthi on 06/06/15.
//  Copyright (c) 2015 chandu. All rights reserved.
//

#import "two.h"

@implementation two

-(void)initMethod
{
    one *obj = [[one alloc] init];
    //this is very important, if you forget to assign self to delegate, delegates wont work
    obj.delegate = self;
    [obj sayHello];
}
-(void) display
{
    NSLog(@"Hello class two!!!");
}
@end
