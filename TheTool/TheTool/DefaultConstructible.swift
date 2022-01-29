//
//  DefaultConstructible.swift
//  TheTool
//
//  Created by Pavel Gnatyuk on 29/01/2022.
//  Copyright © 2022 Pavel Gnatyuk. All rights reserved.
//
//
// Source: https://5sw.de/2021/07/automatic-builders/
//
// Example:
//'''
//        struct Whatever: DefaultConstructible {
//            struct ChildData {
//                var foo: Int = 0
//            }
//
//            var name: String = ""
//            var age: Int = 0
//            var child = ChildData()
//
//            typealias Config = Configurator<Whatever>
//        }
//
//        let me = Whatever.Config
//            .name("Me")
//            .age(-1)
//            .child.foo(12)
//            .build()
//
//'''
//
import Foundation

@dynamicMemberLookup
public struct Configurator<T> {
    var configure: (inout T) -> Void = { _ in }

    subscript<V>(dynamicMember keyPath: WritableKeyPath<T, V>) -> Builder<V> {
        .init(configure: configure, keyPath: keyPath)
    }

    static subscript<V>(dynamicMember keyPath: WritableKeyPath<T, V>) -> Builder<V> {
        .init(configure: { _ in }, keyPath: keyPath)
    }

    @dynamicMemberLookup
    struct Builder<V> {
        var configure: (inout T) -> Void
        var keyPath: WritableKeyPath<T, V>

        func callAsFunction(_ value: V) -> Configurator {
            return .init { [configure, keyPath] object in
                configure(&object)
                object[keyPath: keyPath] = value
            }
        }

        subscript<C>(dynamicMember childKeyPath: WritableKeyPath<V, C>) -> Builder<C> {
            .init(configure: configure, keyPath: keyPath.appending(path: childKeyPath))
        }
    }

    func apply(_ value: inout T) {
        configure(&value)
    }
}

public protocol DefaultConstructible {
    init()
}

public extension Configurator where T: DefaultConstructible {
    func build() -> T {
        var result = T()
        apply(&result)
        return result
    }
}
