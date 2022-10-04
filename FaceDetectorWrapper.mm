//
//  FaceDetectorWrapper.m
//  Face Blurrer
//
//  Created by Hassan Jamil on 2022-02-27.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FaceDetectorWrapper.h"
#import "FaceDetector.hpp"
#import "opencv2/opencv.hpp"


FaceDetector fd = FaceDetector();

@implementation FaceDetectorWrapper

-(int) testFn {
    return fd.testFn();
}
-(UIImage) greyScale

@end
