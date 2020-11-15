//
//  Endpoints.swift
//  IntrinioAPI
//
//  Created by Marcus Florentin on 28/10/2019.
//

import Foundation

public struct Endpoints {

	private let base : URL

	public init(domain: String) {
		base = URL(string: "https://\(domain)")!
	}

	// MARK: - Endpoint

	public enum Endpoint {
		public enum Forex: String {
			case currencies = "currencies"
			case pairs = "pairs"
			case price = "prices"
		}
	}

	public func forex(_ endpoint: Endpoint.Forex) -> URL {
		let components = URLComponents(string: "/forex/\(endpoint.rawValue)")!

		return components.url(relativeTo: base)!
	}

	public func forex(_ endpoint: Endpoint.Forex, pair: Currency.Pair, timeFrame: Timeframe,
			   param: Set<URLQueryItem>? = nil) -> URL {

		var path : String = "/forex/\(endpoint.rawValue)"

		if endpoint == .price {
			path += "/\(pair.code)/\(timeFrame.rawValue)"
		}
		var components = URLComponents(string: path)!

		if let parameters = param {
			components.queryItems = parameters.sorted(by: { $0.name < $1.name })
		}

		return components.url(relativeTo: base)!
	}

}

// MARK: - URL Query Item

fileprivate let hoursFormatter : DateFormatter = {
	let format = DateFormatter()
	// Intrinio API date local
	format.locale = .init(identifier: "en_US")
	format.dateStyle = .none
	format.timeStyle = .short

	return format
}()

fileprivate let dateFormatter : DateFormatter = {
	let format = DateFormatter()
	// Intrinio API date local
	format.locale = .init(identifier: "en_US")
	format.dateStyle = .short
	format.dateFormat = "YYYY/DD/MM"
	format.timeStyle = .none

	return format
}()

public extension URLQueryItem {

	init(timezone: String) {
		self = .init(name: "timezone", value: timezone)
	}

	init(page size: Int) {
		self = .init(name: "page_size", value: size.description)
	}

	init(next page: String) {
		self = .init(name: "next_page", value: page)
	}

	// MARK: Time

	init(start: Date) {
		self = .init(name: "start_date", value: dateFormatter.string(from: start))
	}

	init(startTime: Date) {
		self = .init(name: "start_time", value: hoursFormatter.string(from: startTime))
	}

	init(end: Date) {
		self = .init(name: "end_date", value: dateFormatter.string(from: end))
	}

	init(endTime: Date) {
		self = .init(name: "end_time", value: hoursFormatter.string(from: endTime))
	}
}
