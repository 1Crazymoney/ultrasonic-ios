//
//  Singleton.h
//  TestSoundPayment
//
//  Created by Chandra Pasumarthi on 30/4/19.
//  Copyright © 2019 Chandra Pasumarthi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Singleton : NSObject
    
@property (nonatomic, strong) NSString *str;

+ (id)sharedInstance;
@end

NS_ASSUME_NONNULL_END
