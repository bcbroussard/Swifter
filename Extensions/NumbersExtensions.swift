//
//  NumbersExtension.swift
//
//  Created by Rok Gregorič
//  Copyright © 2018 Rok Gregorič. All rights reserved.
//

import UIKit
import CoreGraphics

func clamp<T: Comparable>(_ value: T, min lo: T, max hi: T) -> T {
  return min(max(lo, value), hi)
}

let mainScreenScale = UIScreen.main.scale // read UIScreen.mainScreen().scale only once since is expensive and impacts scrolling performance

extension Double {
  var pixelValue: CGFloat {
    return CGFloat(self) / mainScreenScale
  }

  func formatted(to decimals: Int) -> String {
    return String(format: "%.\(decimals)f", self)
  }


  func rounded(to decimals: Int) -> Double {
    let divisor = pow(10, decimals).doubleValue
    return (self * divisor).rounded()/divisor
  }
}

extension CGFloat {
  var pixelRounded: CGFloat {
    return (self * mainScreenScale).rounded() / mainScreenScale
  }
}

extension NSNumber {
  var cgfloat: CGFloat {
    return CGFloat(truncating: self)
  }
}

extension TimeInterval {
  static var since1970: TimeInterval {
    return Date().timeIntervalSince1970
  }
}

@available(iOS 10.0, *)
extension Date {
  var internetString: String {
    return ISO8601DateFormatter.string(from: self, timeZone: .current, formatOptions: .withInternetDateTime)
  }
}

extension Int {
  var range: CountableRange<Int> {
    return (0..<self)
  }

  func times(_ block: () -> Void) {
    range.forEach { _ in block() }
  }

  func forEach(_ block: (Int) -> Void) {
    range.forEach(block)
  }

  func maps<T>(_ block: () -> T) -> [T] {
    return range.map { _ in block() }
  }

  func map<T>(_ block: (Int) -> T) -> [T] {
    return range.map(block)
  }

  var string: String {
    return "\(self)"
  }
}

extension Bool {
  var int: Int {
    return self ? 1 : 0
  }
}

extension Decimal {
  public func stringValue() -> String? {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    return formatter.string(for: self)
  }

  public init(fromString: String) {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2

    self = formatter.number(from: fromString)!.decimalValue
  }

  var doubleValue: Double {
    return (self as NSDecimalNumber).doubleValue
  }
}

func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
        case let (l?, r?): return l < r
        case (nil, _?): return true
        default: return false
    }
}

func > <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
        case let (l?, r?): return l > r
        default: return rhs < lhs
    }
}
