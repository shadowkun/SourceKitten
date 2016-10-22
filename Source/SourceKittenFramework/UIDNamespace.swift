//
//  UIDNamespace.swift
//  SourceKitten
//
//  Created by Norio Nomura on 10/22/16.
//  Copyright © 2016 SourceKitten. All rights reserved.
//

import Foundation

// MARK: - UIDNamespace
public protocol UIDNamespace: CustomStringConvertible, ExpressibleByStringLiteral, Equatable {
    var uid: UID { get }
    init(uid: UID)
}

extension UIDNamespace {
    internal static func leaf(_ name: String) -> Self {
        return Self.init(uid: UID(name))
    }

    // CustomStringConvertible
    public var description: String {
        return uid.description
    }

    // ExpressibleByStringLiteral
    public init(stringLiteral value: String) {
        self.init(uid: UID(value))
    }
    public init(unicodeScalarLiteral value: String) {
        self.init(uid: UID(value))
    }
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(uid: UID(value))
    }

    // Equatable
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.uid == rhs.uid
    }
}

public func ==<T>(lhs: T, rhs: UID) -> Bool
    where T: UIDNamespace {
        return lhs.uid == rhs
}

public func ==<T>(lhs: UID, rhs: T) -> Bool
    where T: UIDNamespace {
        return rhs == lhs
}

public func ==<T>(lhs: T, rhs: UID?) -> Bool
    where T: UIDNamespace {
        return rhs == lhs.uid
}

public func ==<T>(lhs: UID?, rhs: T) -> Bool
    where T: UIDNamespace {
        return lhs.map { rhs == $0 } ?? false
}
