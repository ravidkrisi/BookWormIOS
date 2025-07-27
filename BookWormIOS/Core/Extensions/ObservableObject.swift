//
//  ObservableObject.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 24/06/2025.
//

import Foundation
import Combine

extension ObservableObject {
    
    
    /// bind a publisher to keypath
    /// - Parameters:
    ///   - publisher: publihser
    ///   - keyPath: keypath
    ///   - cancellables: set of cancellables
    func bind<T>(
        _ publisher: AnyPublisher<T, Error>?,
        to keyPath: ReferenceWritableKeyPath<Self, T?>,
        storeIn cancellables: inout Set<AnyCancellable>
    ) {
        publisher?
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] value in
                self?[keyPath: keyPath] = value
            })
            .store(in: &cancellables)
    }
}

