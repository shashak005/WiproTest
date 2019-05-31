
//
//  WiproTest
//
//  Created by Shashank on 30/05/19.
//  Copyright © 2019 Shashank. All rights reserved.
//


import UIKit
import SVProgressHUD

class ServiceLayer: NSObject {

// MARK: ServiceLayer GET Calls
func performRequestWithServiceNameForGet(serviceURL: String, success successBlock: @escaping (([CanadaDataModal],String) -> Void), failure failureBlock: @escaping ((String) -> Void)) {
    
    SVProgressHUD.show(withStatus: "Fetching data from URL")
    var request = URLRequest(url: URL(string: serviceURL)!)
    request.httpMethod = get
    request.httpBody = try? JSONSerialization.data(withJSONObject: [:], options: [])
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
        do {
            if data != nil{
            let dataResponse = String(data: data!, encoding: .isoLatin1)
            let dataObject: Data? = dataResponse?.data(using: .utf8)
            if let json = try JSONSerialization.jsonObject(with: dataObject!) as? [String:Any]
            {
                if let rowValue = json[rowsstr] as? [[String:Any]] {
                    var canadaDataModal = [CanadaDataModal]()
                    for data in rowValue {
                        canadaDataModal.append(CanadaDataModal.init(data: data))
                    }
                    SVProgressHUD.dismiss()
                    if let title = json[titlestr] as? String {
                    successBlock(canadaDataModal, title)
                    }
                }
            }
                SVProgressHUD.dismiss()
            }
            else{
                SVProgressHUD.dismiss()
                failureBlock("Response Error.")

            }
        } catch {
            SVProgressHUD.dismiss()
            failureBlock("Response Error.")
        }
    })

    task.resume()
}
    
}
