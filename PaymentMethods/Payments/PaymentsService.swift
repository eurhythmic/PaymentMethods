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
    enum SessionError: LocalizedError {
        case clientError(statusCode: Int)
        case serverError(statusCode: Int)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case let .clientError(statusCode):
                return "Client error with status code \(statusCode)"
            case let .serverError(statusCode):
                return "Server error with status code \(statusCode)"
            case .unknown:
                return "👽 Unknown error"
            }
        }
    }
    
    public func publisher() -> AnyPublisher<Data, URLError> {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap({ data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    switch statusCode {
                    case 400...499:
                        throw SessionError.clientError(statusCode: statusCode)
                    case 500...599:
                        throw SessionError.serverError(statusCode: statusCode)
                    default:
                        throw SessionError.unknown
                    }
                }
                return data
            })
            .mapError({ $0 as? URLError ?? URLError(.unknown) })
            .eraseToAnyPublisher()
    }
}
