//
//  GenericExtensions.swift
//  FxUI
//
//  Created by blakerogers on 2/5/19.
//  Copyright © 2019 blakerogers. All rights reserved.
//

import UIKit
extension CGRect {
    static func frameOf(_ frame: Frame) -> CGRect {
        return CGRect(x: frame.0, y: frame.1, width: frame.2, height: frame.3)
    }
}
