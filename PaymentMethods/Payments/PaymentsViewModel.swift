//
//  PaymentsViewModel.swift
//  PaymentMethods
//
//  Created by RnD on 5/11/21.
//

import Foundation
import Combine

class PaymentsViewModel {
    private let paymentsService = PaymentsService()
    private(set) var results = CurrentValueSubject<[Applicable], Never>([Applicable]())
    private var subscriptions = Set<AnyCancellable>()
    
    /// Retrieve payment methods from JSON
    func loadPayments() {
        paymentsService.publisher()
            .retry(1)
            .decode(type: ListResult.self, decoder: JSONDecoder())
            .map(\.networks)
            .map(\.applicable)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error: \(error)")
                }
            } receiveValue: { [unowned self] results in
                self.results.send(results)
            }
            .store(in: &subscriptions)
    }
}
