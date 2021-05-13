//
//  PaymentsServiceDataPublisher.swift
//  PaymentMethods
//
//  Created by RnD on 5/11/21.
//

import Foundation
import Combine

public protocol PaymentsServiceDataPublisher {
    func publisher() -> AnyPublisher<Data, URLError>
}
