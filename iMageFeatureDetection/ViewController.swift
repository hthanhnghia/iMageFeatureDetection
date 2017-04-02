//
//  ViewController.swift
//  iMageFeatureDetection
//
//  Created by Ho Thanh Nghia on 25/3/17.
//  Copyright © 2017 NghiaHo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    let openCVWrapper = OpenCVWrapper()
    let visualThreshold = 800
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    @IBOutlet var previewView: UIView!
    @IBOutlet var visualCue: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visualCue.image = UIImage(named:"circle")
        visualCue.isHidden = true
        startCameraSession()
    }
    
    // setup and run a camera session (AVCaptureSession)
    func startCameraSession() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        
        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            captureSession.addInput(input)
        }
        catch {
            print("can't access camera")
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer?.frame = previewView.bounds
        previewView.layer.addSublayer(previewLayer)
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable : Int(kCVPixelFormatType_32BGRA)]
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sample buffer delegate", attributes: []))
        
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }
        
        captureSession.startRunning()
    }
    
    // passing the camera output to the OpenCv module for processing
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!)
    {
        let uiImage = sampleBuffer.uiImage
        let numberOfCorners = Int(self.openCVWrapper.getNumberOfCorners(uiImage))
        DispatchQueue.main.async {
            // make visual cue visible/invisible based on the number of corners detected
            self.visualCue.isHidden = (numberOfCorners < self.visualThreshold)
        }
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
}
