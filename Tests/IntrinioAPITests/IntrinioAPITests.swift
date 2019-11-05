import XCTest
@testable import IntrinioAPI

final class IntrinioAPITests: XCTestCase {

	let interaction : IntrinioAPI = IntrinioAPI(api: apiKey)

	// MARK: - Forex

	func testCurrencies() {

		let expectation = XCTestExpectation(description: "Get the total number of accounts")

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

    static var allTests = [
        ("test forex currencies", testCurrencies),
    ]
}

// MARK: - Testing Data

let apiKey : String = "Ojc5MmI3Yjc2OWJlNGRlYmZkOGM2MDIyMjg0N2RlODNh"

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

