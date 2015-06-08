//
//  one.h
//  sampleDelegate
//
//  Created by Chandrasekhar Pasumarthi on 06/06/15.
//  Copyright (c) 2015 chandu. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol sampleDelegate
-(void) display;
@end
@interface one : NSObject

@property(nonatomic, assign) id delegate;
-(void)sayHello;
@end
