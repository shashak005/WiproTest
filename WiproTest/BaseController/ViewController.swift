//
//  ViewController.swift
//  WiproTest
//
//  Created by Shashank on 30/05/19.
//  Copyright © 2019 Shashank. All rights reserved.
//

import UIKit

import SDWebImage

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var canadaTableView: UITableView!
    var dataArray  = [[String:Any]]()
    var canadaDataModal  = [CanadaDataModal]()
    var navigationtitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        canadaTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight), style: .grouped)
        
        canadaTableView.register(CanadaTableViewCell.self, forCellReuseIdentifier: myCellStr)
        canadaTableView.dataSource = self
        canadaTableView.sectionHeaderHeight = 1
        canadaTableView.delegate = self
        self.view.addSubview(canadaTableView)
        fetchDataFromUrl()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    //**************************************************
    // MARK: FETCH DATA FROM URL
    //**************************************************

    
    func fetchDataFromUrl() {
        ServiceLayer().performRequestWithServiceNameForGet(serviceURL: "\(baseUrl)", success: { (response,titlestr) in
            self.canadaDataModal = response
            self.navigationtitle = titlestr
            
            DispatchQueue.main.async {
                self.canadaTableView.reloadData()
            }
            print(response)
        }) { (errorString) in
            
            
            let alert = UIAlertController(title: "Network failure", message: "Please check your internet connection.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.navigationController?.popViewController(animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //**************************************************
    // MARK: UITableViewDelegate
    //**************************************************
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if canadaDataModal[indexPath.row].descriptionValue != "" {
            let heightOFText = calculateHeight(inString: canadaDataModal[indexPath.row].descriptionValue)
            if heightOFText < 18{
                return heightOFText + 90
                
            }
            
            return heightOFText + 50
        }
        return 110
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }

    
    //**************************************************
    // MARK: UITableViewDataSource
    //**************************************************

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myCellStr, for: indexPath as IndexPath) as? CanadaTableViewCell
        let displayWidth: CGFloat = self.view.frame.width
        let heightOFText = calculateHeight(inString: canadaDataModal[indexPath.row].descriptionValue)
        if canadaDataModal[indexPath.row].descriptionValue != "" {
            cell!.labelDescription.frame = CGRect(x: 90, y: 25, width: displayWidth - 100, height: heightOFText + 30)
        }
            
        else{
            cell!.labelDescription.frame = CGRect(x: 90, y: 25, width: displayWidth - 100, height: 80)
            
        }
        
        
        if canadaDataModal[indexPath.row].title != "" {
            cell?.labelTitle.text = canadaDataModal[indexPath.row].title
        }
        else{
            cell?.labelTitle.text = "No titile available for this item."
        }
        
        if canadaDataModal[indexPath.row].descriptionValue != "" {
            cell?.labelDescription.text = canadaDataModal[indexPath.row].descriptionValue
        }
        else{
            cell?.labelDescription.text = "No description available for this item."
        }
        let imageUrl = URL(string: canadaDataModal[indexPath.row].imageUrl)
        cell?.imageCanada.sd_setImage(with: imageUrl , placeholderImage: UIImage.init(named: noImage))
        self.title = navigationtitle
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if canadaDataModal.count != 0 {
            return canadaDataModal.count
        }
        return 0
    }

    
    //**************************************************
    // MARK: CALCULATE HEIGHT OF TEXT
    //**************************************************

    
    func calculateHeight(inString:String) -> CGFloat
    {
        let messageString = inString
        let attributes : [NSAttributedString.Key : Any] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.systemFont(ofSize: 15.0)]
        let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes)
        
        let rect : CGRect = attributedString.boundingRect(with: CGSize(width: 222.0, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        let requredSize:CGRect = rect
        return requredSize.height
    }
    
    
    
    
}


