//
//  ForexTests.swift
//  IntrinioAPITests
//
//  Created by Marcus Florentin on 28/10/2019.
//


import XCTest
@testable import Intrinio

final class ForexTests: XCTestCase {

	static var allTests = [
		("test currencies decoding", testCurrenciesDecoding),
		("test pairs decoding", testCurrencyPairsDecoding),
		("test prices decoding", testCurrencyPricesDecoding)
	]

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

	// MARK: Prices

	func testCurrencyPricesDecoding() throws {
		let data = try file(named: "currency_prices", ext: "json", in: forexFolder)

		// Try to decode data prices
		XCTAssertNoThrow(try decoder.decode(CurrencyPrices.self, from: data), "Can't decode currency prices")
	}

}

// MARK: - Testing Data

let forexFolder : URL = {
	var url = testFolder
	url.appendPathComponent("Forex", isDirectory: true)
	return url
}()

// MARK: - Testing Data

let testFolder : URL = {
	var url = URL(fileURLWithPath: #file)
	url.deleteLastPathComponent()
	url.appendPathComponent("Data", isDirectory: true)
	return url
}()

func file(named name: String, ext: String? = nil, in folder: URL = testFolder) throws -> Data {
	var url = folder.appendingPathComponent(name, isDirectory: false)

	if let ext = ext {
		url.appendPathExtension(ext)
	}

	return try Data(contentsOf: url)
}

