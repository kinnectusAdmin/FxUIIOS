//
//  ScriptView.swift
//  FxUI
//
//  Created by blakerogers on 2/11/19.
//  Copyright © 2019 blakerogers. All rights reserved.
//

import UIKit

protocol LayoutScript {
    typealias ScriptEvaluator = (String) -> Bool
    var recognizers: ScriptEvaluator {get}
    func collectionContains(_ collection: [String]) -> (String) -> Bool
}
extension LayoutScript {
    func collectionContains(_ collection: [String]) -> (String) -> Bool {
        return { input in
            return collection.contains(input)
        }
    }
}
protocol UIElement {
    var name: String { get set}
}
typealias ElementModifier = (UIElement) -> UIElement

struct Layout {
    var elements: [UIElement]
}
extension Layout {
}
indirect enum Operations: LayoutScript {
    case set
    case create
    case constrain
    case hide
    case when
    var recognizers: ScriptEvaluator {
        switch self {
        case .set: return collectionContains(["set"])
        case .create: return collectionContains(["create", "build", "make"])
        case .constrain: return collectionContains(["align", "constrain", "place", "position"])
        case .hide: return collectionContains(["hide"])
        case .when: return collectionContains(["when"])
        }
    }
    static var all: [Operations] {
        return [.set, .create, .constrain, .hide, .when]
    }
    static func operation(recognizer: String) -> Operations? {
        return Operations.all.filter { $0.recognizers(recognizer)}.first
    }
}
enum Elements: LayoutScript {
    case button
    case collectionView
    case tableView
    case containerView
    case view
    case switchView
    case label
    var recognizers: ScriptEvaluator {
        switch self {
        case .button:
            return collectionContains(["button"])
        case .collectionView:
            return collectionContains(["collectionView", "collection"])
        case .tableView:
            return collectionContains(["table", "tableView", "list"])
        case .containerView:
            return collectionContains(["view", "container", "screen"])
        case .view:
            return collectionContains(["view", "container", "screen"])
        case .switchView:
            return collectionContains(["switchView", "switch"])
        case .label:
            return collectionContains(["UILabel", "label", "Label"])
        }
    }
    static var all: [Elements] {
        return [.button, .collectionView, .tableView, .containerView,.view, .switchView, .label]
    }
    static func element(recognizer: String) -> Elements? {
        return Elements.all.filter { $0.recognizers(recognizer)}.first
    }
}
enum OperationConjuction: LayoutScript {
    case of
    case to
    case forr
    case with
    case at
    var recognizers: ScriptEvaluator {
        switch self {
        case .of: return { input in return input == "of"}
        case .to: return { input in return input == "to"}
        case .forr: return { input in return input == "for"}
        case .with: return { input in return input == "with"}
        case .at: return { input in return input == "at"}
        }
    }
    static var all: [OperationConjuction] {
        return [.of, .to, .forr, .with, .at]
    }
    static func conjunction(_ recognizer: String) -> OperationConjuction? {
        return OperationConjuction.all.filter { $0.recognizers(recognizer)}.first
    }
}
enum PropertyIdentifier: LayoutScript {
    case visibility
    case background
    case text
    case radius
    case height
    case width
    var recognizers: ScriptEvaluator {
        switch self {
        case .visibility:
            return collectionContains(["alpha", "visibility","opacity"])
        case .background:
            return collectionContains(["background color", "background", "color"])
        case .text:
            return collectionContains(["title", "text"])
        case .radius:
            return collectionContains(["radius", "corner radius", "corner", "edge"])
        case .height:
            return collectionContains(["height"])
        case .width:
            return collectionContains(["width", "length"])
        }
    }
    static var all: [PropertyIdentifier] {
        return [.visibility, .background, .text, .radius, .height, .width]
    }
    static func property(_ recognizer: String) -> PropertyIdentifier? {
        return PropertyIdentifier.all.filter { $0.recognizers(recognizer)}.first
    }
}
enum Value: LayoutScript {
    case color
    case doubleDigit
    case intDigit
    case text
    var recognizers: ScriptEvaluator {
        switch self {
        case .color:
            return collectionContains(["white", "black", "blue","green", "orange", "red", "yellow"])
        case .doubleDigit:
            return { input in
                //TODO: use more complex regex evaluation
                return input.contains(".")
            }
        case .intDigit:
            //TODO: use more complex regext
            return { input in
                return Int(input) != nil
            }
        case .text:
            return  { input in
                return input.contains("'")
            }
        }
    }
}
struct Parser<Result> {
    typealias ScriptEvaluation = (String) -> LayoutScript?
    typealias ScriptComponentEvaluation = (String) -> LayoutScript?
    let parse: (String) -> (Result, String)?
}
extension Parser {
    
    func run(_ string: String) -> (Result, String)? {
        guard let (result, remainder) = parse(string) else { return nil}
        return (result, String(remainder))
    }
    static func component(_ condition: @escaping ScriptComponentEvaluation) -> Parser<LayoutScript> {
        return Parser<LayoutScript> { input in
            var allWords = input.components(separatedBy: " ")
            guard allWords.count > 0 else { return nil}
            let word = allWords.removeFirst()
            guard let element = condition(word) else { return  nil}
            return (element, String(allWords.reduce("", {"\($0) \($1)"}).dropFirst()))
        }
    }
    static func button() -> Parser<LayoutScript>? {
        let button = component { input in
            let element = Elements.element(recognizer: input)
            return element == .button ? element : nil
        }
        return button
    }
    static func label() -> Parser<LayoutScript>? {
        let label = component { input in
            let element = Elements.element(recognizer: input)
            return element == .label ? element : nil
        }
        return label
    }
    static func setOperation() -> Parser<LayoutScript>? {
        let operation = component { input in
            let operation = Operations.operation(recognizer: input)
            return operation == .set ? operation : nil
        }
        return operation
    }
    static func joinerTo() -> Parser<LayoutScript>? {
        let joiner = component { input in
            let joiner = OperationConjuction.conjunction(input)
            return joiner == .to ? joiner : nil
        }
        return joiner
    }
    static func heightProperty() -> Parser<LayoutScript>? {
        let property = component { input in
            let property = PropertyIdentifier.property(input)
            return property == .height ? property : nil
        }
        return property
    }
    static func makeLabelOperation() {
        let labelOperation = setOperation()?.followed(by: label()!).followed(by: joinerTo()!).followed(by: heightProperty()!)
        let result = labelOperation?.run("set label to height")
        print(result)
    }
}
extension Parser {
    var many: Parser<[Result]> {
        return Parser<[Result]>(parse: { input -> ([Result], String) in
            var result: [Result] = []
            var remainder = input
            while let (element, newRemainder) = self.parse(remainder) {
                result.append(element)
                remainder = newRemainder
            }
            return (result, remainder)
        })
    }
    func map<T>(_ transform: @escaping (Result) -> T) -> Parser<T> {
        return Parser<T> { input -> (T, String)? in
            guard let (result, remainder) = self.parse(input) else { return nil}
            return (transform(result), remainder)
        }
    }
    func followed<A>(by other: Parser<A>) -> Parser<(Result, A)> {
        return Parser<(Result, A)> { input in
            guard let (result1, remainder1) = self.parse(input) else { return nil}
            guard let (result2, remainder2) = other.parse(remainder1) else { return nil}
            return ((result1, result2), remainder2)
        }
    }
//    func curry<A,B,C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
//        return { a in
//            return { b in
//                return f(a, b)
//            }
//        }
//    }
}
