import XCTest
@testable import IntrinioAPI

final class IntrinioAPITests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        XCTAssertEqual(IntrinioAPI().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

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

