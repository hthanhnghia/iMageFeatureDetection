//
//  CMSampleBuffer+UIImage.swift
//  iMageFeatureDetection
//
//  Created by Ho Thanh Nghia on 30/3/17.
//  Copyright © 2017 NghiaHo. All rights reserved.
//

import Foundation
import UIKit

// extend CMSampleBuffer class, creating an optional UIImage variable
extension CMSampleBuffer {
    var uiImage: UIImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(self) else { return nil }
        
        CVPixelBufferLockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let baseAddress = CVPixelBufferGetBaseAddress(imageBuffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer)
        let width = CVPixelBufferGetWidth(imageBuffer)
        let height = CVPixelBufferGetHeight(imageBuffer)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
        guard let context = CGContext(data: baseAddress,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: 8,
                                      bytesPerRow: bytesPerRow,
                                      space: colorSpace,
                                      bitmapInfo: bitmapInfo.rawValue) else { return nil }
        guard let cgImage = context.makeImage() else { return nil }
        
        CVPixelBufferUnlockBaseAddress(imageBuffer,CVPixelBufferLockFlags(rawValue: 0));
        
        return UIImage(cgImage: cgImage)
    }
}

