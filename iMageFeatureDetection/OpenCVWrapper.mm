//
//  OpenCVWrapper.m
//  iMageFeatureDetection
//
//  Created by Ho Thanh Nghia on 25/3/17.
//  Copyright © 2017 NghiaHo. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import "OpenCVFeatureDetection.hpp"
#import "opencv2/imgcodecs/ios.h"
#import "OpenCVWrapper.h"
using namespace cv;

@implementation OpenCVWrapper
- (int) getNumberOfCorners:(UIImage*) uiImage {
    Mat frame;
    UIImageToMat(uiImage, frame);
    int numberOfCorners = OpenCVFeatureDetection::getNumberOfCorners(frame);
    return numberOfCorners;
}
@end
