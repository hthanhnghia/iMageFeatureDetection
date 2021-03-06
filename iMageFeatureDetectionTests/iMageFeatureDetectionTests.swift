//
//  iMageFeatureDetectionTests.swift
//  iMageFeatureDetectionTests
//
//  Created by Ho Thanh Nghia on 25/3/17.
//  Copyright © 2017 NghiaHo. All rights reserved.
//

import XCTest
@testable import iMageFeatureDetection

class iMageFeatureDetectionTests: XCTestCase {
    
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewController = storyboard.instantiateInitialViewController() as! ViewController
        
        self.viewController.loadView()
        self.viewController.viewDidLoad()
        
        XCTAssertNotNil(viewController.view)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewControllerIsComposedOfPreviewView() {
        XCTAssertNotNil(self.viewController.visualCue, "ViewController does not consist of visualCue")
    }
    
    func testViewControllerIsComposedOfVisualCue() {
        XCTAssertNotNil(self.viewController.visualCue, "ViewController does not consist of visualCue")
    }
    
    func testViewControllerInitializesVisualCue() {
        XCTAssert(self.viewController.visualCue.image == UIImage(named:"circle"), "ViewController under test does not initialize the loading of the visualCue image correctly")
        XCTAssert(self.viewController.visualCue.isHidden == true, "ViewController under test does not initialize the visibility state of the visualCue correctly")
    }

    
}
