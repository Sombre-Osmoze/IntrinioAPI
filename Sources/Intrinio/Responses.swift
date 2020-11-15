//
//  Responses.swift
//  IntrinioAPI
//
//  Created by Marcus Florentin on 28/10/2019.
//

import Foundation

// MARK: - Codable

public let decoder : JSONDecoder = {
	let jsonDecoder = JSONDecoder()

	let formatter = DateFormatter()
	formatter.calendar = Calendar(identifier: .iso8601)
	formatter.locale = Locale(identifier: "en_US_POSIX")
	formatter.timeZone = TimeZone(secondsFromGMT: 0)
	formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
	jsonDecoder.dateDecodingStrategy = .formatted(formatter)

	jsonDecoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+inf",
																		negativeInfinity: "-inf",
																		nan: "NaN")

	return jsonDecoder
}()

public protocol ResponseAPI : Codable { }

// MARK: Pagging

public typealias PageToken = String

public protocol PaggingResponse : ResponseAPI {


	/// The token required to request the next page of the data.
	/// If null, no further results are available.
	var nextPage : PageToken? { get }
}

// MARK: - Errors

public struct ResponseError : ResponseAPI, Error {

	public let error : String

	public let message : String

}


// MARK: - Forex


// MARK: Currency

/// All Returns currencies for which prices are available.
public struct Currencies : ResponseAPI {

	/// The currency list.
	public let currencies : [Currency]

}

// MARK: Pairs

/// A list of currency pairs used to request foreign exchange (forex) market price data.
public struct CurrencyPairs : ResponseAPI {

	/// The currency pairs list.
	public let pairs : [Currency.Pair]

}

// MARK: Price

public struct CurrencyPrices : PaggingResponse {

	public let nextPage: PageToken?

	public let prices : [Price]

	/// The Forex currency pair for which prices were requested.
	public let pair : Currency.Pair
}
