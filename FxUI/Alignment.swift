//
//  FxUIVIew.swift
// ŻFxUI
//
//  Created by blakerogers on 12/30/18.
//  Copyright © 2018 blakerogers. All rights reserved.
//
import UIKit

enum Alignment {
    //Positions
    case fillContainer
    case leftTopAlignment
    case leftBottomAlignment
    case leftRightAlignment
    case leftTopRightAlignment
    case leftBottomRightAlignment
    //Top Alignment
    case topToTop(dy: CGFloat)
    case topToBottom(dy: CGFloat)
    case topToMidY(dy: CGFloat)
    //Bottom Alignment
    case bottomToBottom(dy: CGFloat)
    case bottomToTop(dy: CGFloat)
    case bottomToMidY(dy: CGFloat)
    //Left Alignment
    case leftToLeft(dx: CGFloat)
    case leftToRight(dx: CGFloat)
    case leftToMidX(dx: CGFloat)
    //Right Alignment
    case rightToRight(dx: CGFloat)
    case rightToLeft(dx: CGFloat)
    case rightToMidX(dx: CGFloat)
    //Center Alignment
    case centerY(CGFloat)
    case centerX(CGFloat)
    func apply(relativeFrame: CGRect, current: CGRect = CGRect.zero) -> CGRect {
        switch self {
        case .fillContainer:
            return relativeFrame
        case .leftTopAlignment:
            return current.replacing(.x,0).replacing(.y,0)
        case .leftBottomAlignment:
            return current.replacing(.x, 0).replacing(.y, relativeFrame.height - current.height)
        case .leftRightAlignment:
            return current.replacing(.x, 0).replacing(.width, relativeFrame.width)
        case .leftTopRightAlignment:
            return current.replacing(.x, 0).replacing(.y, 0).replacing(.width, relativeFrame.width)
        case .leftBottomRightAlignment:
            return current.replacing(.x, 0).replacing(.y, relativeFrame.height - current.height).replacing(.width, relativeFrame.width)
        case .topToTop(let dy):
            return current.replacing(.y, dy)
        case .topToBottom(let dy):
            return current.replacing(.y, 0).replacing(.height, relativeFrame.height + dy)
        case .topToMidY(let dy):
            return current.replacing(.y, (relativeFrame.height*0.5)+dy)
        case .bottomToBottom(let dy):
            return current.replacing(.y, (relativeFrame.height - current.height) + dy)
        case .bottomToTop(let dy):
            return current.replacing(.y, -current.height + dy)
        case .bottomToMidY(let dy):
            return current.replacing(.y, (relativeFrame.height*0.5 - current.height) + dy)
        case .leftToLeft(let dx):
            return current.replacing(.x, dx)
        case .leftToRight(let dx):
            return current.replacing(.x, relativeFrame.width+dx)
        case .leftToMidX(let dx):
            return current.replacing(.x, relativeFrame.width*0.5+dx)
        case .rightToRight(let dx):
            return current.replacing(.x, relativeFrame.width-current.width+dx)
        case .rightToLeft(let dx):
            return current.replacing(.x, -current.width+dx)
        case .rightToMidX(let dx):
            return current.replacing(.x, (relativeFrame.width*0.5 - current.width)+dx)
        case .centerY(let dy):
            return current.replacing(.y, (relativeFrame.height*0.5 - current.height*0.5)+dy)
        case .centerX(let dx):
            return current.replacing(.x, (relativeFrame.width*0.5 - current.width*0.5)+dx)
        }
    }
}
enum RectComponent {
    case x, y, width, height
}
extension CGRect {
    typealias  RectMod = (CGRect) -> CGRect
    func replacing(_ component: RectComponent, _ value: CGFloat) -> CGRect {
        switch component {
        case .x:
            return CGRect(x: value, y: self.minY, width: self.width, height: self.height)
        case .y:
            return CGRect(x: self.minX, y: value, width: self.width, height: self.height)
        case .width:
            return CGRect(x: self.minX, y: self.minY, width: value, height: self.height)
        case .height:
            return CGRect(x: self.minX, y: self.minY, width: self.width, height: value)
        }
    }
    func frame () -> Frame {
        return (self.minX, self.minY, self.width, self.height)
    }
}
