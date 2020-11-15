import XCTest
@testable import IntrinioAPI
@testable import Intrinio

final class IntrinioAPITests: XCTestCase {

	let interaction : IntrinioAPI = IntrinioAPI(api: apiKey)

	// MARK: - Forex

	func testForexCurrencies() {

		let expectation = XCTestExpectation(description: "Get the list of the availables currencies")

		interaction.forexCurrencies { (result) in
			switch result {
			case .success(_):
				break
			case .failure(let error):
				XCTFail(error.localizedDescription)
			}
			expectation.fulfill()
		}

		wait(for: [expectation], timeout: 10)

	}

	func testForexPairs() {

		let expectation = XCTestExpectation(description: "Get the list of the give forex pairs")

		interaction.forexPairs { (result) in
			switch result {
			case .success(_):
				break
			case .failure(let error):
				XCTFail(error.localizedDescription)
			}
			expectation.fulfill()
		}

		wait(for: [expectation], timeout: 10)

	}

	func testForexPrices() {

		let expectation = XCTestExpectation(description: "Get the history prices for EURUSD")

		let pair = Currency.Pair(code: "EURUSD", base: .EUR, quote: .USD)

//		let start = Date(timeIntervalSinceNow: -7 * 24 * 3_600)

		interaction.forexPrices(for: pair, time: .H1, time: []) { result in
			switch result {
			case .success(_):
				break
			case .failure(let error):
				XCTFail(error.localizedDescription)
			}

			expectation.fulfill()
		}

		wait(for: [expectation], timeout: 10)
	}

    static var allTests = [
        ("test forex currencies", testForexCurrencies),
		("test forex pairs", testForexPairs),
		("test forex prices", testForexPrices)
    ]
}

// MARK: - Testing Data

let apiKey : String = "Ojc5MmI3Yjc2OWJlNGRlYmZkOGM2MDIyMjg0N2RlODNh"
