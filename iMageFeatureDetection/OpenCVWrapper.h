//
//  OpenCVWrapper.h
//  iMageFeatureDetection
//
//  Created by Ho Thanh Nghia on 25/3/17.
//  Copyright © 2017 NghiaHo. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface OpenCVWrapper : NSObject
- (int) getNumberOfCorners:(UIImage*) uiImage;
@end
