//
//  OpenCVFeatureDetection.cpp
//  iMageFeatureDetection
//
//  Created by Ho Thanh Nghia on 25/3/17.
//  Copyright © 2017 NghiaHo. All rights reserved.
//

#include "OpenCVFeatureDetection.hpp"
#include <iostream>
using namespace std;
using namespace cv;

#define MAX_CORNERS 10000 // The maximum number of corners to return.
#define QUALITY_LEVEL 0.01 // Characterizes the minimal accepted quality of image corners.
#define MIN_DISTANCE 10 // The minimum possible Euclidean distance between the returned corners
#define BLOCKSIZE 3 // Size of the averaging block for computing derivative covariation
#define DETECTOR_PARAM 0.04 // Free parameter of Harris detector

// Apply "Shi-Tomasi Corner Detector" to calculate the number of corners in a frame
int OpenCVFeatureDetection::getNumberOfCorners(Mat& frame) {
    Mat frameGray;
    cvtColor(frame, frameGray, CV_BGR2GRAY);
    vector<Point2f> corners;
    Mat mask; // The optional region of interest.
    bool useHarrisDetector = false; // Indicates, whether to use operator or cornerMinEigenVal()
    goodFeaturesToTrack(frameGray, corners, MAX_CORNERS, QUALITY_LEVEL, MIN_DISTANCE, mask,BLOCKSIZE, useHarrisDetector, DETECTOR_PARAM);
    int numberOfCorners = (int)corners.size();
    return numberOfCorners;
}
