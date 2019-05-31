//
//  BaseViewController.swift
//  WiproTest
//
//  Created by Shashank on 31/05/19.
//  Copyright © 2019 Shashank. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let startButton = UIButton(frame: CGRect(x: 20, y: 20, width: 200, height: 60))
        startButton.setTitle("Fetch Data", for: .normal)
        startButton.backgroundColor = .blue
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.center = self.view.center
        startButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        self.view.addSubview(startButton)
    }
        @objc func buttonTapped(sender : UIButton) {
            let nextController = ViewController()
            self.navigationController?.pushViewController(nextController, animated: true)
            
        }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
