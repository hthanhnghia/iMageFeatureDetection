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

int OpenCVFeatureDetection::getNumberOfCorners(Mat frame)
{
    if(frame.empty())
    {
        cerr << "Could not load image" << std::endl;
        return -1;
    }
    
    //Preprocess the image
    Mat frameGray;
    cvtColor( frame, frameGray, CV_BGR2GRAY );
    
    Mat dst, dst_norm, dst_norm_scaled;
    dst = Mat::zeros( frame.size(), CV_32FC1 );
    
    /// Detector parameters
    int blockSize = 2;
    int apertureSize = 3;
    double k = 0.04;
    
    /// Detecting corners
    cornerHarris( frameGray, dst, blockSize, apertureSize, k, BORDER_DEFAULT );
    
    /// Normalizing
    normalize( dst, dst_norm, 0, 255, NORM_MINMAX, CV_32FC1, Mat() );
    convertScaleAbs( dst_norm, dst_norm_scaled );
    
    int numberOfCorners = 0;
    int thresh = 200;
    
    for( int j = 0; j < dst_norm.rows ; j++ )
    {
        for( int i = 0; i < dst_norm.cols; i++ )
        {
            if( (int) dst_norm.at<float>(j,i) > thresh )
            {
                numberOfCorners += 1;
            }
        }
    }
    
    return numberOfCorners;
}

