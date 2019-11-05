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

	// MARK: - Request

	private let endpoints = Endpoints()

	private func verify<T: ResponseAPI>(response: URLResponse, data: Data, for type: T.Type = T.self, log: StaticString) throws -> T {

		// Checking if the response is a HTTP response
		guard let answer = response as? HTTPURLResponse else { throw ErrorAPI.Response.corrupted }

		// Verifying the status code
		switch answer.statusCode {
			// If the response is correct decrypt data
		case 200:
			if let api = try? decoder.decode(ResponseError.self, from: data) {
				throw api
			} else {
				return try decoder.decode(T.self, from: data)
			}

		case 401, 402, 403, 429, 500, 503:
				#if canImport(os)
					os_signpost(.event, log: logging, name: log, "Bad request, status %d", answer.statusCode)
				#endif
				throw ErrorAPI.Response.invalid(code: ErrorAPI.StatusCode(rawValue: answer.statusCode)!,
												error: try decoder.decode(ResponseError.self, from: data))

		default:
			logger.error("Unknow status code \(answer.statusCode) for \(answer.url?.path ?? "no URL")")
			throw ErrorAPI.Response.badStatus(answer.statusCode)
		}

	}


	// MARK: - Session

	private let session : URLSession = URLSession(configuration: .default)


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

		enum Response: Error {
			case corrupted
			case noResponse
			case noData
			case badStatus(Int)
			case invalid(code: StatusCode, error: ResponseError)
		}

	}



	// MARK: - Logs

	private let logger = Logger(label: "IntrinioAPI")

	#if canImport(os)
	private let logging = OSLog(subsystem: "IntrinioAPI", category: "Request")
	#endif


}
