//
//  ImageExtension.swift
//  WiproTest
//
//  Created by Shashank on 30/05/19.
//  Copyright © 2019 Shashank. All rights reserved.
//

import UIKit

extension String {
    func whiteSpacesRemoved() -> String {
        return self.filter { $0 != Character(" ") }
    }
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
