//
//  ImageScan.m
//  qrCodeScan
//
//  Created by chanduthedev on 22/4/17.
//  Copyright © 2017 chanduthedev. All rights reserved.
//

#import "ImageScan.h"

@implementation ImageScan

+ (NSString *)decodeQRFromUIImage :(UIImage *)inputImage {
    
    NSLog(@"in  decodeQRFromUIImage .......");
    NSString *textFromQRImage = [[NSMutableString alloc] init];
    
    
    CIImage* ciImage = [[CIImage alloc] initWithCGImage:inputImage.CGImage];
    
    NSArray *qrCodeFeatures = [self getImageFeaturesFromCIDetectorType:ciImage detectorType:CIDetectorTypeQRCode];
    
    for (CIQRCodeFeature* qrCodeImageFeature in qrCodeFeatures){
        
        NSLog(@"QR image string is \"%@\"", qrCodeImageFeature.messageString);
        [qrString stringByAppendingString:qrCodeImageFeature.messageString];
    }
    
    NSLog(@"leaving  decodeQRFromUIImage .......");
    return textFromQRImage;
}

+(NSArray*) getImageFeaturesFromCIDetectorType:(CIImage *)inputCIImage detectorType:(NSString *)inputDetectorType{
    
    NSLog(@"in getImageFeaturesFromCIDetectorType .......");
    
    //if this not works, use initWithOptions method
    CIContext *ciContext = [CIContext context];
    //CIContext *ciContext = [[CIContext alloc] initWithOptions:nil];
    
    NSDictionary *ciOptions = @{ CIDetectorAccuracy : CIDetectorAccuracyHigh };
    CIDetector *ciDetector = [CIDetector detectorOfType:inputDetectorType
                                                context:ciContext
                                                options:ciOptions];
    
    NSArray *qrCodeFeatures = [ciDetector featuresInImage:inputCIImage options:ciOptions];
    
    NSLog(@"leaving getImageFeaturesFromCIDetectorType .......");
    return qrCodeFeatures;
}

@end
