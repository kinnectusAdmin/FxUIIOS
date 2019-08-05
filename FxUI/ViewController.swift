//
//  ViewController.swift
//  FxUI
//
//  Created by blakerogers on 12/30/18.
//  Copyright © 2018 blakerogers. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    let layout = FxView.container(seed(1)).background(.red).frame((0, 0, UIScreen.main.bounds.width, 300))
                    .child(FxView.label(seed(2)).background(.blue).text("Blake").color(.white).frame((0,0,50,50))   .align(in: 1, .centerX(0), .centerY(0)))
                    .child(FxView.button(seed(3)).background(.white).color(.red).title("Rogers").frame((10,10,50,50)))
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setViews()
    }
    func setViews() {
        self.view.addSubview(layout.render() as! UIView)
        print("did render")
    }
}
