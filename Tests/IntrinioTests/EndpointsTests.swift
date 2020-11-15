//
//  EndpointsTests.swift
//  IntrinioAPITests
//
//  Created by Marcus Florentin on 28/10/2019.
//


import XCTest
@testable import Intrinio

final class EndpointsTests: XCTestCase {

	static var allTests = [
		("test forex currencies", testForexCurrencies),
		("test forex pairs", testForexPairs),
		("test forex prices", testForexPrices)
	]

	let endpoints = Endpoints(domain: domain)

	// MARK: - Forex

	func testForexCurrencies() {
		let valid = URL(string: "https://\(domain)/forex/currencies")!

		XCTAssertEqual(endpoints.forex(.currencies).absoluteURL, valid,
					   "Unvalid url for currencies endpoint")
	}

	func testForexPairs() {
		let valid = URL(string: "https://\(domain)/forex/pairs")!


		XCTAssertEqual(endpoints.forex(.pairs).absoluteURL, valid,
					   "Unvalid url for pairs endpoint")
	}


	func testForexPrices() {

		let pair = Currency.Pair(code: "EURUSD", base: .EUR, quote: .USD)

		let time = Timeframe.D1

		let valid = URL(string: "https://\(domain)/forex/prices/\(pair.code)/\(time.rawValue)")!

		let url = endpoints.forex(.price, pair: pair, timeFrame: time, param: nil)

		XCTAssertEqual(url.absoluteURL, valid,
					   "Unvalid url for prices endpoint")
	}
}

fileprivate let domain = "api-v2.intrinio.com"
