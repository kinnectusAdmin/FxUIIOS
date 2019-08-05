//
//  FxUIView.swift
//  FxUI
//
//  Created by blakerogers on 7/2/19.
//  Copyright © 2019 blakerogers. All rights reserved.
//

import UIKit

protocol IntentType {}
protocol AStyle {}
protocol LayoutName {}
typealias View = (FxUIView) -> FxUIView
typealias AlignmentView = () -> Void
typealias Frame = (CGFloat, CGFloat, CGFloat, CGFloat)
typealias Action = () -> Void
protocol ListModel {}

enum TextStyle {
    case text(String)
    func apply(view: UIView) {
        switch self {
        case let .text(text):
            (view as? UILabel)?.text = text
        }
    }
}
precedencegroup ViewCombinatorPreference {
    assignment: true
    associativity: left
}

infix operator >>> : ViewCombinatorPreference
func >>>(view1: @escaping View, view2: @escaping View) -> View {
    return { view in
        return view2(view1(view))
    }
}
protocol FxUIView: class {
    var reactiveAlignment: AlignmentView? { get set}
    func backgroundColor(_ color: UIColor)
    func viewWithSeed(_ seed: Int) -> FxUIView?
    func addChild(_ view: FxUIView)
    func setFrame(_ frame: Frame)
    func parent() -> FxUIView?
    func frame() -> CGRect
}
extension FxUIView where Self : UIView {
    func backgroundColor(_ color: UIColor) {
        self.backgroundColor = color
    }
    func viewWithSeed(_ seed: Int) -> FxUIView? {
        return self.viewWithTag(seed) as? FxUIView
    }
    func addChild(_ view: FxUIView) {
        self.addSubview(view as! UIView)
    }
    func setFrame(_ frame: Frame) {
        self.frame = CGRect.frameOf(frame)
    }
    func parent() -> FxUIView? {
        return superview as? FxUIView
    }
    func frame() -> CGRect {
        return self.frame
    }
}
