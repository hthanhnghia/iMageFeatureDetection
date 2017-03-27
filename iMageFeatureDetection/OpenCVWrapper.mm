//
//  OpenCVWrapper.m
//  iMageFeatureDetection
//
//  Created by Ho Thanh Nghia on 25/3/17.
//  Copyright © 2017 NghiaHo. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import "OpenCVFeatureDetection.hpp"
#import "OpenCVWrapper.h"
#include <iostream>
using namespace std;
using namespace cv;

@implementation OpenCVWrapper

- (int) getNumberOfCorners:(CMSampleBufferRef) sampleBuffer
{
    CVImageBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress( pixelBuffer, 0 );
    
    /*Lock the image buffer*/
    CVPixelBufferLockBaseAddress(pixelBuffer,0);
    
    /*Get information about the image*/
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(pixelBuffer);
    size_t width = CVPixelBufferGetWidth(pixelBuffer);
    size_t height = CVPixelBufferGetHeight(pixelBuffer);
    
    Mat frame(height, width, CV_8UC4, (void*)baseAddress);
    
    int result = OpenCVFeatureDetection::getNumberOfCorners(frame);
    cout << "No of corners detected: " << result << endl;
    return result;
}

@end
