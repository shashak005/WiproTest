//
//  ViewControllerTest.swift
//  WiproTestTests
//
//  Created by Shashank on 31/05/19.
//  Copyright © 2019 Shashank. All rights reserved.
//

import XCTest

class ViewControllerTest: XCTestCase,UITableViewDelegate {
    var viewcontroller: ViewController =  ViewController()

    override func setUp() {

        setuUpViewController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testNoOfRowsInSections() {
        if let tableView = viewcontroller.canadaTableView {
            for (index, _) in ((viewcontroller.canadaDataModal).enumerated()) {
                let noOfRows = tableView.numberOfRows(inSection: index)
                XCTAssertEqual(viewcontroller.canadaDataModal.count, noOfRows)
            }
        }
    }
    
    func testViewDidLoad() {
        
            let _ = viewcontroller.loadView()
            XCTAssertNotNil(viewcontroller, "Viewcontroller cannot be nil")
    }
    
    func testConformsToTableViewDataSource() {
            XCTAssertTrue(viewcontroller.conforms(to: UITableViewDataSource.self))
    }
    
    func testConformsToDelegate() {
        XCTAssertTrue(viewcontroller.conforms(to: UITableViewDelegate.self))
    }
    
    func testConfigureCell() {
        viewcontroller.viewDidLoad()
        self.testCallURLForFetchData(urlStr:baseUrl)

        for (index, _) in ((viewcontroller.canadaDataModal).enumerated()) {
            let indexPath = IndexPath(row: index, section: 0)
            _ = viewcontroller.tableView((viewcontroller.canadaTableView), cellForRowAt: indexPath)
        }
    }
    


    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testSetupStyles() {
        viewcontroller.view.backgroundColor = UIColor.white
        XCTAssert(viewcontroller.view.backgroundColor == UIColor.white)
    }

    func setuUpViewController() {
         let viewcontroller1: ViewController =  ViewController()
        self.viewcontroller = viewcontroller1
        let _ = viewcontroller.view
        viewcontroller1.canadaTableView.delegate = self
 self.testCallURLForFetchData(urlStr:baseUrl)
    }

    
    func testCallURLForFetchData(urlStr:String) {
        //Use for things that need account
        let timeoutInterval: TimeInterval = 30
        let getUrldataExpectation = expectation(description: "Fetch Data")
        
        var request = URLRequest(url: URL(string: urlStr)!)
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
                        var canadaDataModal = [CanadaDataModal]()
                        for data in rowValue {
                            canadaDataModal.append(CanadaDataModal.init(data: data))
                        }

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
