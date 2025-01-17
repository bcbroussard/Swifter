//
//  Environment.swift
//
//  Created by Rok Gregorič
//  Copyright © 2018 Rok Gregorič. All rights reserved.
//

import Foundation

struct Environment {
  static func value<T>(for key: String) -> T? {
    return Bundle.main.infoDictionary?[key] as? T
  }

  static var appName: String {
    return value(for: "CFBundleName") ?? ""
  }

  static var build: String {
    return value(for: "CFBundleVersion") ?? ""
  }

  static var version: String {
    return value(for: "CFBundleShortVersionString") ?? ""
  }

  static var verBuild: String {
    return "v\(version) (\(build))"
  }

  static let isProduction: Bool = {
    #if PRODUCTION
    return true
    #else
    return false
    #endif
  }()

  static let isDevelopment: Bool = {
    #if DEBUG
    return true
    #else
    return false
    #endif
  }()

  static let isTestFlight: Bool = {
    return Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
  }()

  static let isSimulator: Bool = {
    var sim = false
    #if arch(i386) || arch(x86_64)
    sim = true
    #endif
    return sim
  }()
}
