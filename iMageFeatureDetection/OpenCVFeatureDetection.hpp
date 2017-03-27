//
//  OpenCVFeatureDetection.hpp
//  iMageFeatureDetection
//
//  Created by Ho Thanh Nghia on 25/3/17.
//  Copyright © 2017 NghiaHo. All rights reserved.
//

#ifndef OpenCVFeatureDetection_hpp
#define OpenCVFeatureDetection_hpp

#include <opencv2/opencv.hpp>
#include <stdio.h>

class OpenCVFeatureDetection
{
public:
    static int getNumberOfCorners(cv::Mat frame);
};


#endif /* OpenCVFeatureDetection_hpp */
