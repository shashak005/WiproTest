//
//  ApiTestCases.swift
//  WiproTestTests
//
//  Created by Shashank on 31/05/19.
//  Copyright © 2019 Shashank. All rights reserved.
//

import XCTest

class ApiTestCases: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
//        testCallURLForFetchData()
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    
    func testCallURLForFetchData() {
        //Use for things that need account
        let timeoutInterval: TimeInterval = 30
        let getUrldataExpectation = expectation(description: "LDAP Authentication")
        
        var request = URLRequest(url: URL(string: baseUrl)!)
        request.httpMethod = "GET"
        request.httpBody = try? JSONSerialization.data(withJSONObject: [:], options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let dataResponse = String(data: data!, encoding: .isoLatin1)
                let dataObject: Data? = dataResponse?.data(using: .utf8)
                if let json = try JSONSerialization.jsonObject(with: dataObject!) as? [String:Any]
                {
                    if let rowValue = json["rows"] as? [[String:Any]] {
                        print(rowValue)
                        getUrldataExpectation.fulfill()
                        XCTAssertTrue(true, "Successfully fetched the Data")
                    }
                }
//                getUrldataExpectation.fulfill()
//                XCTFail("Problem in fetching data")

            } catch {
                getUrldataExpectation.fulfill()
                XCTFail("Problem in fetching data")
            }
        })
        
        waitForExpectations(timeout: timeoutInterval, handler: { error in
            XCTAssertNil(error, "Error")
        })
        task.resume()
    }
}
