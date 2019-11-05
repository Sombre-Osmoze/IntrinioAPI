//
//  IntrinioAPI.swift
//  IntrinioAPI
//
//  Created by Marcus Florentin on 28/10/2019.
//

import Foundation
import Logging

#if canImport(Combine)
import Combine
#endif

#if canImport(os)
import os.signpost
#endif

public class IntrinioAPI: NSObject {

	public init(api key: String) {

		super.init()
	}

	// MARK: - Errors

	public struct ErrorAPI: Error {

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

	#if canImport(os)
	private let logging = OSLog(subsystem: "IntrinioAPI", category: "Request")
	#endif


}
