//
//  BioinformaticsAppTests.swift
//  BioinformaticsAppTests
//
//  Created by Lizhen Shi on 7/18/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import UIKit
import XCTest
import BioinformaticsApp

class BioinformaticsAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testGlobalAlignment() {

        let s1="PLEASANTLY"
        let s2="MEANLY"
        let ga = GlobalAlignment(s1:s1, s2:s2, scorefun: BLOSUM62, gap: -5)
        let (score,align1,align2)=ga.eval()
        
        XCTAssertEqual(score,8, "Pass")
        XCTAssertEqual(align1,"PLEASANTLY", "Pass")
        XCTAssertEqual(align2,"-MEA--N-LY", "Pass")
    }
    
    func testLocalAlignment() {
        
        let s1="MEANLY"
        let s2="PENALTY"
        let ga = LocalAlignment(s1:s1, s2:s2, scorefun: PAM250, gap: -5)
        let (score,align1,align2)=ga.eval()
        
        XCTAssertEqual(score,15, "Pass")
        XCTAssertEqual(align1,"EANL-Y", "Pass")
        XCTAssertEqual(align2,"ENALTY", "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
