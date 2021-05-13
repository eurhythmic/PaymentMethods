//
//  ListResult.swift
//  PaymentMethods
//
//  Created by RnD on 5/11/21.
//

import Foundation

// MARK: - ListResult
struct ListResult: Codable {
    let links: ListResultLinks
    let timestamp, operation, resultCode, resultInfo: String
    let returnCode: ReturnCode
    let status, interaction: Interaction
    let identification: Identification
    let networks: Networks
    let operationType: OperationType
    let style: Style
    let payment: Payment
    let integrationType: String
}

// MARK: - Identification
struct Identification: Codable {
    let longID, shortID, transactionID: String

    enum CodingKeys: String, CodingKey {
        case longID = "longId"
        case shortID = "shortId"
        case transactionID = "transactionId"
    }
}

// MARK: - Interaction
struct Interaction: Codable {
    let code, reason: String
}

// MARK: - ListResultLinks
struct ListResultLinks: Codable {
    let linksSelf: String
    let lang: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case lang
    }
}

// MARK: - Networks
struct Networks: Codable {
    let applicable: [Applicable]
}

// MARK: - Applicable
struct Applicable: Codable {
    let code, label, method, grouping: String
    let registration, recurrence: Recurrence
    let redirect: Bool
    let links: ApplicableLinks
    let selected: Bool
    let inputElements: [InputElement]?
    let operationType: OperationType
    let contractData: ContractData?
}

// MARK: - ContractData
struct ContractData: Codable {
    let pageEnvironment, javascriptIntegration, pageButtonLocale: String

    enum CodingKeys: String, CodingKey {
        case pageEnvironment = "PAGE_ENVIRONMENT"
        case javascriptIntegration = "JAVASCRIPT_INTEGRATION"
        case pageButtonLocale = "PAGE_BUTTON_LOCALE"
    }
}

// MARK: - InputElement
struct InputElement: Codable {
    let name: Name
    let type: TypeEnum
}

enum Name: String, Codable {
    case bic = "bic"
    case expiryMonth = "expiryMonth"
    case expiryYear = "expiryYear"
    case holderName = "holderName"
    case iban = "iban"
    case number = "number"
    case verificationCode = "verificationCode"
}

enum TypeEnum: String, Codable {
    case integer = "integer"
    case numeric = "numeric"
    case string = "string"
}

// MARK: - ApplicableLinks
struct ApplicableLinks: Codable {
    let logo: String
    let linksSelf: String
    let lang: String
    let operation, validation: String

    enum CodingKeys: String, CodingKey {
        case logo
        case linksSelf = "self"
        case lang, operation, validation
    }
}

enum OperationType: String, Codable {
    case charge = "CHARGE"
}

enum Recurrence: String, Codable {
    case none = "NONE"
    case recurrenceOPTIONAL = "OPTIONAL"
}

// MARK: - Payment
struct Payment: Codable {
    let reference: String
    let amount: Int
    let currency: String
}

// MARK: - ReturnCode
struct ReturnCode: Codable {
    let name, source: String
}

// MARK: - Style
struct Style: Codable {
    let language: String
}
