//
//  IntrinioAPI.swift
//  IntrinioAPI
//
//  Created by Marcus Florentin on 28/10/2019.
//

import Foundation
import Logging

class IntrinioAPI {

	init(api key: String) {
		
	}

	// MARK: - Errors

	enum APIError: Error {

		enum StatusCode: Int, Error {
			case unauthorized = 401
			case forbidden = 403
			case notFound = 404
			case tooManyRequest = 429
			case internalServerError = 500
			case serviceUnavailable = 503
		}

	}



	// MARK: - Logs

	private let logger = Logger(label: "IntrinioAPI")




}
