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


		XCTAssertNoThrow(try decoder.decode(Currencies.self, from: data), "Can't decode currencies list")
	}
	

	static var allTests = [
		("Currencies Decoding", testCurrenciesDecoding),
	]
}

// MARK: - Testing Data

let forexFolder : URL = {
	var url = testFolder
	url.appendPathComponent("Forex", isDirectory: true)
	return url
}()
