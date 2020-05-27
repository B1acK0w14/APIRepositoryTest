//
//  APIRepositoryTestTests.swift
//  APIRepositoryTestTests
//
//  Created by David Andres Penagos Sanchez on 27/05/20.
//  Copyright © 2020 David Andres Penagos Sanchez. All rights reserved.
//

import XCTest
@testable import APIRepositoryTest

class APIRepositoryTestTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCallGitAPISuccessReturnsNameLocation() {
        //given
        guard let gitURL = URL(string: "https://api.github.com/users/b1ack0w14") else {return}
        let promise = expectation(description: "Simple Request")
        
        //when
        URLSession.shared.dataTask(with: gitURL) { (data, response, error) in
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                if let result = json as? NSDictionary {
                    //then
                    XCTAssertTrue(result["name"] as! String == "David Penagos")
                    XCTAssertTrue(result["location"] as! String == "Colombia")
                    promise.fulfill()
                }
            } catch let error {
                print("Error: ", error)
            }
        }.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCallGitAPIFailureReturn() {
        //given
        guard let gitURL = URL(string: "https://api.github.com/users/b1ack0w1") else {return}
        let promise = expectation(description: "Incorrect URL")
        
        //when
        URLSession.shared.dataTask(with: gitURL) { (data, response, error) in
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                if let result = json as? NSDictionary {
                    //then
                    XCTAssertTrue(result["message"] as! String == "Not Found")
                    promise.fulfill()
                }
            } catch let error {
                print("Error: ", error)
            }
        }.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
}
