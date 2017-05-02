//
//  main.m
//  sampleDelegate
//
//  Created by Chandrasekhar Pasumarthi on 05/06/15.
//  Copyright (c) 2015 chandu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "two.h"
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        NSLog(@"Hello, World!");
        two *obj = [[two alloc]init];
        [obj initMethod];
        
    }
    return 0;
}

