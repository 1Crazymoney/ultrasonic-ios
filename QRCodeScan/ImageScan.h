//
//  ImageScan.h
//  qrCodeScan
//
//  Created by chanduthedev on 22/4/17.
//  Copyright © 2017 chanduthedev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageScan : NSObject

+ (NSString *)decodeQRFromUIImage :(UIImage *)inputImage;
+ (NSArray*) getImageFeaturesFromCIDetectorType:(CIImage *)inputCIImage detectorType:(NSString *)inputDetectorType;

@end
