//
//  Responses.swift
//  IntrinioAPI
//
//  Created by Marcus Florentin on 28/10/2019.
//

import Foundation

// MARK: - Codable

let decoder : JSONDecoder = JSONDecoder()

public protocol ResponseAPI : Codable {

}

// MARK: - Forex


// MARK: Currency

/// All Returns currencies for which prices are available.
public struct Currencies : ResponseAPI {

	/// The currency list.
	public let currencies : [Currency]

}

// MARK: - Pairs

/// A list of currency pairs used to request foreign exchange (forex) market price data.
public struct CurrencyPairs : ResponseAPI {

	/// The currency pairs list.
	public let pairs : [Currency.Pair]

}
