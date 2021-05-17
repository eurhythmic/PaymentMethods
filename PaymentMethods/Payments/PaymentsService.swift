//
//  PaymentsService.swift
//  PaymentMethods
//
//  Created by RnD on 5/11/21.
//

import Foundation
import Combine

public struct PaymentsService {
    private var url: URL {
        urlComponents.url!
    }
    
    private var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "raw.githubusercontent.com"
        components.path = "/optile/checkout-android/develop/shared-test/lists/listresult.json"
        
        return components
    }
}

extension PaymentsService: PaymentsServiceDataPublisher {
    public func publisher() -> AnyPublisher<Data, URLError> {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap({ data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    print("Received HTTP status code: \((response as! HTTPURLResponse).statusCode)")
                    throw URLError(.badServerResponse)
                }
                return data
            })
            .mapError({ $0 as? URLError ?? URLError(.unknown) })
            .eraseToAnyPublisher()
    }
}
