//
//  FxView.swift
//  FxUI
//
//  Created by blakerogers on 7/2/19.
//  Copyright © 2019 blakerogers. All rights reserved.
//

import UIKit

indirect enum FxView {
    case container(View)
    case button(View)
    case label(View)
    case table(ListModel)
    case collection(ListModel)
    var kind: FxUIView {
        switch self {
        case .button:
            return FxUIButton()
        case .container:
            return FxUIViews()
        case .label:
            return FxUILabel()
        default:
            return FxUIViews()
        }
    }
    /// Searches all views with a specific tag
    ///
    /// - Parameter seed: Int. If seed is 0 return current FxView
    /// - Returns: FxUIView
    func element(_ seed: Int) -> FxUIView? {
        let view = self.render()
        if seed == 0 {
            return view
        } else {
            return view.viewWithSeed(seed)
        }
    }
    /// Collection of all views with a FxView
    var views: View? {
        switch self {
        case .container(let views), .button(let views), .label(let views):
            return views
        default: return nil
        }
    }
    /// Composes to views together
    ///
    /// - Parameters:
    ///   - views: View
    ///   - view: View
    /// - Returns: FxView
    func appendView(views: @escaping View, view: @escaping View) -> FxView {
        switch self {
        case .container:
            return .container(views >>> view)
        case .button:
            return .button(views >>> view)
        case .label:
            return .label(views >>> view)
        default: return self
        }
    }
    /// Add background to view of whichever kind and return view
    ///
    /// - Parameter color: UIColor
    /// - Returns: FxView
    func background(_ color: UIColor) -> FxView {
        guard let views = self.views else {
            //TODO: insert a View
            return self
        }
        return self.appendView(views: views, view: { view in view.backgroundColor(color); return view})
    }
    /// Update and add a frame to a view
    ///
    /// - Parameter frame: Frame
    /// - Returns: FxView
    func frame(_ frame: Frame) -> FxView {
        guard let views = self.views else {
            //TODO: insert a View
            return self
        }
        return self.appendView(views: views, view: { view in view.setFrame(frame); return view})
    }
    /// Align a view to frame of its parent or another view
    ///
    /// - Parameters:
    ///   - seed: Int
    ///   - alignments: Array of Alignments
    /// - Returns: FxView
    func align(in seed: Int, _ alignments: Alignment...) -> FxView {
        guard let views = self.views else {
            //TODO: insert a View
            return self
        }
        return self.appendView(views: views, view: { view in
            view.reactiveAlignment = {
                guard let parentSibling = view.parent()?.viewWithSeed(seed) else {return}
                alignments.forEach { alignment in
                    view.setFrame(alignment.apply(relativeFrame: parentSibling.frame(), current: view.frame()).frame())
                }
            }
            return view
        })
    }
    /// Provide text or title to a view
    ///
    /// - Parameter text: String
    /// - Returns: FxView
    func text(_ text: String) -> FxView {
        guard let views = self.views else {
            //TODO: insert a View
            return self
        }
        return self.appendView(views: views, view: { view in (view as? UILabel)?.text = text; return view})
    }
    /// Provide attributed text or title to a view
    ///
    /// - Parameter attributedTitle: NSAttributedString
    /// - Returns: FxView
    func textAttribute(_ attributedTitle: NSAttributedString) -> FxView {
        guard let views = self.views else {
            //TODO: insert a View
            return self
        }
        return self.appendView(views: views, view: { view in
            (view as? UILabel)?.attributedText = attributedTitle
            (view as? UIButton)?.setAttributedTitle(attributedTitle, for: .normal)
            return view
        })
    }
    /// Provide a text or tint color to a view
    ///
    /// - Parameter color: UIColor
    /// - Returns: FxView
    func color(_ color: UIColor) -> FxView {
        guard let views = self.views else {
            //TODO: insert a View
            return self
        }
        return self.appendView(views: views, view: { view in
            (view as? UILabel)?.textColor = color
            (view as? UIButton)?.tintColor = color
            return view
        })
    }
    /// Set the title of a view if its a uibutton
    ///
    /// - Parameter title: String
    /// - Returns: FxView
    func title(_ title: String) -> FxView {
        guard let views = self.views else {
            //TODO: insert a View
            return self
        }
        return self.appendView(views: views, view: { view in (view as? UIButton)?.setTitle(title, for: .normal); return view})
    }
    /// Set an tap gesture action to a particular view
    ///
    /// - Parameter action: Action
    /// - Returns: FxView
    func setTapAction(_ action: Action) -> FxView {
        guard let views = self.views else {
            //TODO: insert a View
            return self
        }
        return self.appendView(views: views, view: { view in
            //TODO: add tap gesture
            return view
        })
    }
    /// Set button action directly to a button type of fxview
    ///
    /// - Parameter action: Action
    /// - Returns: FxView
    func setButtonAction(_ action: Action) -> FxView {
        guard let views = self.views else {
            //TODO: insert a View
            return self
        }
        return self.appendView(views: views, view: { view in
            //TODO: add ux action
            return view
        })
    }
    /// Creates a list type of view with a model
    ///
    /// - Parameter model: ListModel
    /// - Returns: FxView
    func model(_ model: ListModel) -> FxView {
        return self
    }
    /// Adds a child view to a view
    ///
    /// - Parameter child: FxView
    /// - Returns: FxView
    func child(_ child: FxView) -> FxView {
        guard let views = self.views else {
            //TODO: insert a View
            return self
        }
        return self.appendView(views: views, view: { view in view.addChild(child.render()); return view})
    }
    /// Renders the entirety of a fxView and its children
    ///
    /// - Returns: FxUIView
    func render() -> FxUIView {
        guard let views = self.views else {
            //TODO: insert a View
            return FxUIViews()
        }
        return views(self.kind)
    }
}
extension FxView {
    static var seed:(Int) -> View = { tag in
        return {  view in
            (view as? UIView)?.tag = tag
            return view
        }
    }
}
