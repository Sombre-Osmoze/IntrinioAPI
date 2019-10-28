//
//  ForexTests.swift
//  IntrinioAPITests
//
//  Created by Marcus Florentin on 28/10/2019.
//


import XCTest
@testable import IntrinioAPI

final class ForexTests: XCTestCase {

	// MARK: - Codable

	// MARK: Currency

	func testCurrenciesDecoding() throws {
		let data = try file(named: "currencies", ext: "json", in: forexFolder)

		// Try to decode data in the structure
		XCTAssertNoThrow(try decoder.decode(Currencies.self, from: data), "Can't decode currencies list")
	}

	// MARK: Pairs

	func testCurrencyPairsDecoding() throws {
		let data = try file(named: "currency_pairs", ext: "json", in: forexFolder)

		// Try to decode data in the structure
		XCTAssertNoThrow(try decoder.decode(CurrencyPairs.self, from: data), "Can't decode currency pairs list")
	}

	static var allTests = [
		("Currencies decoding", testCurrenciesDecoding),
		("Currency pairs decoding", testCurrencyPairsDecoding)
	]
}

// MARK: - Testing Data

let forexFolder : URL = {
	var url = testFolder
	url.appendPathComponent("Forex", isDirectory: true)
	return url
}()
