//
//  ReusableIdentifier.swift
//  TheTool
//
//  Created by Pavel Gnatyuk on 12/03/2019.
//  Copyright © 2019 Pavel Gnatyuk. All rights reserved.
//

import Foundation

public protocol ReusableIdentifier: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension ReusableIdentifier {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}
