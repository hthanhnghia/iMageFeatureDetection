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
    let threshold = 500
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    @IBOutlet var previewView: UIView!
    @IBOutlet var cue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cue.isHidden = true
        startCameraSession()
    }
    
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
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!)
    {
        DispatchQueue.main.async {
            let uiImage = sampleBuffer.uiImage
            let numberOfCorners = Int(self.openCVWrapper.getNumberOfCorners(uiImage))
            // make visual cue visible/invisible based on the number of corners detected
            if (numberOfCorners > self.threshold) {
                self.cue.text = String(numberOfCorners)
                self.cue.isHidden = false
            }
            else {
                self.cue.isHidden = true
            }
        }
    }

    // Disable autorotate on the preview View while still allow the visual cue to rotate
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let targetRotation = coordinator.targetTransform
        let inverseRotation = targetRotation.inverted()
        
        coordinator.animate(alongsideTransition: { context in
            self.previewView.transform = self.previewView.transform.concatenating(inverseRotation)
            self.previewView.frame = self.view.bounds
            context.viewController(forKey: UITransitionContextViewControllerKey.from)
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
}
