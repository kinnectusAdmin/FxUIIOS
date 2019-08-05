//
//  FxUILabel.swift
//  FxUI
//
//  Created by blakerogers on 7/2/19.
//  Copyright © 2019 blakerogers. All rights reserved.
//

import UIKit

class FxUILabel: UILabel, FxUIView {
    var reactiveAlignment: AlignmentView?
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        reactiveAlignment?()
    }
}
