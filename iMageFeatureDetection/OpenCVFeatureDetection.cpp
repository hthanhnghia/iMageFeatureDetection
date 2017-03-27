//
//  OpenCVFeatureDetection.cpp
//  iMageFeatureDetection
//
//  Created by Ho Thanh Nghia on 25/3/17.
//  Copyright © 2017 NghiaHo. All rights reserved.
//

#include "OpenCVFeatureDetection.hpp"
#include <iostream>
#include <string>
using namespace std;
using namespace cv;

#define BLOCK_SIZE 2
#define APERTURE_SIZE 3
#define DETECTOR_PARAM 0.04

int OpenCVFeatureDetection::getNumberOfCorners(Mat &frame) {
    if(frame.empty()) {
        cerr << "Could not load image" << endl;
        return -1;
    }
    
    Mat harrisMat = OpenCVFeatureDetection::computeHarrisMat(frame);
    
    int numberOfCorners = 0;
    int thresh = 200;
    
    for( int j = 0; j < harrisMat.rows ; j++ ) {
        for( int i = 0; i < harrisMat.cols; i++ ) {
            if( (int) harrisMat.at<float>(j,i) > thresh ) {
                numberOfCorners += 1;
            }
        }
    }
    
    return numberOfCorners;
}

Mat OpenCVFeatureDetection::computeHarrisMat(Mat &frame) {
    //Preprocess the image
    Mat frameGray;
    cvtColor(frame, frameGray, CV_BGR2GRAY );
    
    Mat dst, dst_norm;
    dst = Mat::zeros( frame.size(), CV_32FC1 );
    
    /// Detecting corners
    cornerHarris(frameGray, dst, BLOCK_SIZE, APERTURE_SIZE, DETECTOR_PARAM, BORDER_DEFAULT);
    
    /// Normalizing
    normalize( dst, dst_norm, 0, 255, NORM_MINMAX, CV_32FC1, Mat() );
    return dst_norm;
}

