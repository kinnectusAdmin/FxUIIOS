//
//  UIViewExensions.swift
//  FxUI
//
//  Created by blakerogers on 1/1/19.
//  Copyright © 2019 blakerogers. All rights reserved.
//
//

import Foundation
import UIKit
enum ViewPosition {
    case top
    case left
    case right
    case bottom
    case topsToBottom
    case bottomsToTop
    case centerX
    case centerY
    case centerAll
}
// MARK: - Extending the UIView to contain app specific formatting
extension UIView {
    /// Creates a container view programmatically that can be styled sparsely
    ///
    /// - Parameter background: The background color with which to set the view
    /// - Parameter radius: The Corner radius with which to set the view layer
    /// - Returns: Returns a uiview that can immediately be constrained
    static func containerView(background: UIColor = UIColor.white, radius: CGFloat = 0.0, isVisible: Bool = true, willUtilizeConstraints: Bool = true) -> UIView {
        let view = UIView()
        view.layer.cornerRadius = radius
        view.alpha = isVisible ? 1.0 : 0.0
        view.backgroundColor = background
        view.translatesAutoresizingMaskIntoConstraints = willUtilizeConstraints ?  false : true
        return view
    }
    /// Constrain the a view to another views leading and trailing margins
    func constrainViewMargins(to view: UIView, leadingConstant: CGFloat = 20, trailingConstant: CGFloat = -20) {
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingConstant).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingConstant).isActive = true
    }
    /// Constrain a views bottom margin directly to anothers, set constant for offsetting
    func constrainViewToBottom(of view: UIView, constant: CGFloat) {
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant).isActive = true
    }
    /// Constrains a collection of views bottom margin directly to another, set constant for offsetting
    ///
    /// - Parameter arrangements: (CGFloat, UIView)
    func alignViews(position: ViewPosition, _ arrangements: (CGFloat, UIView)...) {
        switch position {
        case .top:
            _ = arrangements.map { arrangement in
                arrangement.1.topAnchor.constraint(equalTo: self.topAnchor, constant: arrangement.0).isActive = true
            }
        case .bottom:
            _ = arrangements.map { arrangement in
                arrangement.1.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: arrangement.0).isActive = true
            }
        case .right:
            _ = arrangements.map { arrangement in
                arrangement.1.rightAnchor.constraint(equalTo: self.rightAnchor, constant: arrangement.0).isActive = true
            }
        case .left:
            _ = arrangements.map { arrangement in
                arrangement.1.leftAnchor.constraint(equalTo: self.leftAnchor, constant: arrangement.0).isActive = true
            }
        case .topsToBottom:
            _ = arrangements.map { arrangement in
                arrangement.1.topAnchor.constraint(equalTo: self.bottomAnchor, constant: arrangement.0).isActive = true
            }
        case .bottomsToTop:
            _ = arrangements.map { arrangement in
                arrangement.1.bottomAnchor.constraint(equalTo: self.topAnchor, constant: arrangement.0).isActive = true
            }
        case .centerX:
            _ = arrangements.map { arrangement in
                arrangement.1.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: arrangement.0).isActive = true
            }
        case .centerY:
            _ = arrangements.map { arrangement in
                arrangement.1.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: arrangement.0).isActive = true
            }
        case .centerAll:
            _ = arrangements.map { arrangement in
                arrangement.1.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: arrangement.0).isActive = true
                arrangement.1.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: arrangement.0).isActive = true
            }
        }
    }
    /// Constrain a view to a height value directly, view must have translatesAutoresizingMaskIntoConstraints to false
    func constrainViewHeight(to constant: CGFloat, with priority: Float = 1000) {
        let constraint = self.heightAnchor.constraint(equalToConstant: constant)
        constraint.priority =  UILayoutPriority(priority)
        constraint.isActive = true
    }
    /// Constrain the bottom margin of a view to the top margin of another
    func constrainTopToBottom(of view: UIView, constant: CGFloat) {
        self.topAnchor.constraint(equalTo: view.bottomAnchor, constant: constant).isActive = true
    }
    /// Constrain the bottom margin of a view to the top margin of another and return constraint
    func returnConstrainTopToBottom(of view: UIView, constant: CGFloat) -> NSLayoutConstraint {
        let constraint = self.topAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    /// Constrain the top margin of a view to the top margin of another
    func constrainTopToTop(of view: UIView, constant: CGFloat) {
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
    }
    /// Constrain the top margin of a view to the mid y of another view
    func constrainTopToMid(of view: UIView, constant: CGFloat) {
        self.topAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    }
    // Constrain the top margin of a view to the mid y of another view
    func constrainMidToBottom(of view: UIView, constant: CGFloat) {
        self.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: constant).isActive = true
    }// Constrain the top margin of a view to the mid y of another view
    func constrainMidToTop(of view: UIView, constant: CGFloat) {
        self.centerYAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
    }
    /// Constrain bottom margin of  view to the top of another view
    func constrainBottomToTop(of view: UIView, constant: CGFloat) {
        self.bottomAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
    }
    /// Constrain bottom margin of  view to the bottom of another view
    func constrainBottomToBottom(of view: UIView, constant: CGFloat) {
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant).isActive = true
    }
    /// Constrain bottom margin of  view to the mid y of another view
    func constrainBottomToMid(of view: UIView, constant: CGFloat) {
        self.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    }
    /// Constrain the left margin of a view to the left margin of another view
    func constrainLeftToLeft(of view: UIView, constant: CGFloat) {
        self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant).isActive = true
    }
    /// Constrain the left margin of a view to the right margin of another view
    func constrainLeftToRight(of view: UIView, constant: CGFloat) {
        self.leftAnchor.constraint(equalTo: view.rightAnchor, constant: constant).isActive = true
    }
    /// Constrain the right margin of a view to the right margin of another view
    func constrainRightToRight(of view: UIView, constant: CGFloat) {
        self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: constant).isActive = true
    }
    /// Constrain the right margin of a view to the left margin of another view
    func constrainRightToLeft(of view: UIView, constant: CGFloat) {
        self.rightAnchor.constraint(equalTo: view.leftAnchor, constant: constant).isActive = true
    }
    /// Constrain the left margin of a view to the mid x of another view
    ///
    /// - Parameters:
    ///   - view: The view to which the constraining view will be matched
    ///   - constant: The offsetting constant which will be applied to the left anchor
    func constrainLeftToMid(of view: UIView, constant: CGFloat) {
        self.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
    }
    /// Constrain the right margin of a view to the mid x of another view
    ///
    /// - Parameters:
    ///   - view: The view to which the constraining view will be matched
    ///   - constant: The midx offsetting constant applied to the rightanchor
    func constrainRightToMid(of view: UIView, constant: CGFloat) {
        self.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
    }
    /// Constrain a view to the mid y of another
    ///
    /// - Parameters:
    ///   - view: The view to which the constraining view will be matched
    ///   - constant: The midY offsetting constant applied
    func constrainCenterYTo(view: UIView, constant: CGFloat) {
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    }
    /// Constrain the mid x view to the mid x of another view
    ///
    /// - Parameters:
    ///   - view: The view to which the constraining view will be matched
    ///   - constant: The midX offsetting constant
    func constrainCenterXTo(view: UIView, constant: CGFloat) {
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
    }
    /// Constrain a view top, left, right and bottom to those of another view
    ///
    /// - Parameters:
    ///   - view: The super view or view to which a particular view will be constrained within
    ///   - top: The top anchor constant from the superviews topanchor
    ///   - left: The left anchor constant from the superviews leftAnchor
    ///   - right: The right anchor constant from the superviews rightAnchor
    ///   - bottom: The bottom anchor constant from the superviews bottom Anchor
    func constrainSafelyInView(view: UIView, top: CGFloat? = nil, left: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil) {
        if let topConstraint = top {
            if #available(iOS 11.0, *) {
                topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraint).isActive = true
            } else {
                // Fallback on earlier versions
                topAnchor.constraint(equalTo: view.topAnchor, constant: topConstraint).isActive = true
            }
        }
        if let leftConstant = left {
            constrainLeftToLeft(of: view, constant: leftConstant)
        }
        if let rightConstant = right {
            constrainRightToRight(of: view, constant: rightConstant)
        }
        if let bottomConstant = bottom {
            if #available(iOS 11.0, *) {
                bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottomConstant).isActive = true
            } else {
                // Fallback on earlier versions
                bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomConstant).isActive = true
            }
        }
    }
    /// Constrain a view top, left, right and bottom to those of another view
    ///
    /// - Parameters:
    ///   - view: The super view or view to which a particular view will be constrained within
    ///   - top: The top anchor constant from the superviews topanchor
    ///   - left: The left anchor constant from the superviews leftAnchor
    ///   - right: The right anchor constant from the superviews rightAnchor
    ///   - bottom: The bottom anchor constant from the superviews bottom Anchor
    func constrainInView(view: UIView, top: CGFloat? = nil, left: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil) {
        if let topConstraint = top {
            topAnchor.constraint(equalTo: view.topAnchor, constant: topConstraint).isActive = true
        }
        if let leftConstant = left {
            constrainLeftToLeft(of: view, constant: leftConstant)
        }
        if let rightConstant = right {
            constrainRightToRight(of: view, constant: rightConstant)
        }
        if let bottomConstant = bottom {
            constrainViewToBottom(of: view, constant: bottomConstant)
        }
    }
    /// Constrain a view to a width value directly, view must have translatesAutoresizingMaskIntoConstraints to false
    ///
    /// - Parameter constant: The width constant to constrain the view to
    func constrainViewWidth(constant: CGFloat) {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    /// Constrain a view to a views width value directly, view must have translatesAutoresizingMaskIntoConstraints to false
    ///
    /// - Parameter constant: The width constant to constrain the view to
    func constrainViewWidthTo(view: UIView, constant: CGFloat = 0, multiplier: CGFloat = 1.0) {
        widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier, constant: constant)
    }
    /// Constrain a view to a height & width value directly, view must have translatesAutoresizingMaskIntoConstraints to false
    /// - Parameters:
    ///   - width: The width constant to constrain the view to
    ///   - height: The height constant to constrain the view to
    func constrainWidth_Height(width: CGFloat, height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    /// Add any number of views, from bottom to top subview respectively
    ///
    /// - Parameter views: An array of subviews to add to a superview
    func add(views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
