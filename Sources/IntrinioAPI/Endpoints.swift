//
//  Endpoints.swift
//  IntrinioAPI
//
//  Created by Marcus Florentin on 28/10/2019.
//

import Foundation

struct Endpoints {

	let domain : String = "api-v2.intrinio.com"

	private let base : URL = URL(string: "https://api-v2.intrinio.com")!


	// MARK: - Endpoint

	enum Endpoint {
		enum Forex: String {
			case currencies = "currencies"
			case pairs = "pairs"
			case price = "prices"
		}
	}

	func forex(_ endpoint: Endpoint.Forex, param: Set<URLQueryItem>? = nil) -> URL {
		let components = URLComponents(string: "/forex/\(endpoint.rawValue)")!

		if endpoint == .price {
			// TODO: Price Parameters
		}

		return components.url(relativeTo: base)!
	}

}
