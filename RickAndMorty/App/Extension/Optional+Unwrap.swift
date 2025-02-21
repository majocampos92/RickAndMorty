//
//  Optional+Unwrap.swift
//  RickAndMorty
//
//  Created by Maria Campos on 4/2/25.
//

import Foundation

extension Optional {
    func unwrap<T>() -> T {
        guard let type = self as? T else { fatalError("Unable to unwrap \(T.self)") }
        return type
    }
}
