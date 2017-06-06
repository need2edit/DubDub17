//
//  Constraints.swift
//  DubDub17
//
//  Created by Jake Young on 6/1/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Helper function for shortening visual format syntax.
    ///
    /// - parameter format: the visual format you want
    /// - parameter views:  the views in order of what you need to constrain (e.g. v0, v1, v2 can be provided as imageView, titleView, subtitleView)
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    /// If the `view` is nil, we take the superview.
    public func center(inView view: UIView? = nil) {
        guard let container = view ?? self.superview else { fatalError("could not locate superview or container view while centering") }
        centerXAnchor.constrainEqual(container.centerXAnchor)
        centerYAnchor.constrainEqual(container.centerYAnchor)
    }
    
}

extension UIView {
    public func constrainEqual(_ attribute: NSLayoutAttribute, to: AnyObject, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        constrainEqual(attribute, to: to, attribute, multiplier: multiplier, constant: constant)
    }
    
    public func constrainEqual(_ attribute: NSLayoutAttribute, to: AnyObject, _ toAttribute: NSLayoutAttribute, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: to, attribute: toAttribute, multiplier: multiplier, constant: constant)
            ]
        )
    }
    
    public func constrainEdges(to other: UILayoutGuide) {
        topAnchor.constrainEqual(other.topAnchor)
        bottomAnchor.constrainEqual(other.bottomAnchor)
        leadingAnchor.constrainEqual(other.leadingAnchor)
        trailingAnchor.constrainEqual(other.trailingAnchor)
    }
    
    public func constrainEdges(toMarginOf view: UIView) {
        constrainEqual(.top, to: view, .topMargin)
        constrainEqual(.leading, to: view, .leadingMargin)
        constrainEqual(.trailing, to: view, .trailingMargin)
        constrainEqual(.bottom, to: view, .bottomMargin)
    }
    
    public var debugBorder: UIColor? {
        get { return layer.borderColor.map { UIColor(cgColor: $0) } }
        set {
            layer.borderColor = newValue?.cgColor
            layer.borderWidth = newValue != nil ? 1 : 0
        }
    }
    
    public static func activateDebugBorders(_ views: [UIView]) {
        let colors: [UIColor] = [.magenta, .orange, .green, .blue, .red]
        for (view, color) in zip(views, colors.cycled()) {
            view.debugBorder = color
        }
    }
}

extension Sequence {
    public func failingFlatMap<T>(_ transform: (Self.Iterator.Element) throws -> T?) rethrows -> [T]? {
        var result: [T] = []
        for element in self {
            guard let transformed = try transform(element) else { return nil }
            result.append(transformed)
        }
        return result
    }
    
    /// Returns a sequence that repeatedly cycles through the elements of `self`.
    public func cycled() -> AnySequence<Iterator.Element> {
        return AnySequence { _ -> AnyIterator<Iterator.Element> in
            var iterator = self.makeIterator()
            return AnyIterator {
                if let next = iterator.next() {
                    return next
                } else {
                    iterator = self.makeIterator()
                    return iterator.next()
                }
            }
        }
    }
}

extension NSLayoutAnchor {
    func constrainEqual(_ anchor: NSLayoutAnchor<AnchorType>, constant: CGFloat = 0) {
        let constraint = self.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = true
    }
}
