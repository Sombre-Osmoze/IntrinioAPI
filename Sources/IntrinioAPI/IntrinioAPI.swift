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
		let configuation = URLSessionConfiguration.default
		// Adding api key to all request
		configuation.httpAdditionalHeaders = ["Authorization" : key]
		session = .init(configuration: configuation)

		super.init()
	}

	// MARK: - Request

	private let endpoints = Endpoints()

	/// This function will check the callback of a DataTaskRequest.
	private func verify(_ response: URLResponse?, _ data: Data?, _ error: Error?) throws -> (URLResponse, Data) {

		// If a error occurred throw it
		if let error = error {
			throw error
		}

		// Checking if the request have a response and data
		guard let anwser = response else { throw ErrorAPI.Response.noResponse }

		guard let data = data else { throw ErrorAPI.Response.noData }

		return (anwser, data)
	}

	private func verify<T: ResponseAPI>(response: URLResponse, data: Data, for type: T.Type = T.self, log: StaticString) throws -> T {

		// Checking if the response is a HTTP response
		guard let answer = response as? HTTPURLResponse else { throw ErrorAPI.Response.corrupted }

		// Verifying the status code
		switch answer.statusCode {
			// If the response is correct decrypt data
		case 200:

			// Checking if the content body is the size expected in the header
			guard data.count == Int(answer.expectedContentLength) else {
				throw ErrorAPI.Response.dataCorrupted(expected: Int(answer.expectedContentLength), data.count)
			}

			if let api = try? decoder.decode(ResponseError.self, from: data) {
				throw api
			} else {
				return try decoder.decode(T.self, from: data)
			}

			// If the response is a known unvalid one, throwing the appropriate error
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

	private let session : URLSession



	// MARK: - Forex

	/// Returns a list of forex currencies for which prices are available.
	@discardableResult public func forexCurrencies(handler: @escaping(_ result: Result<[Currency], ErrorAPI>)->Void) -> Progress {

		let url = endpoints.forex(.currencies)
		let log : StaticString = "Availables currencies request"

		#if canImport(os)
		os_signpost(.begin, log: logging, name: log)
		#endif

		let task = session.dataTask(with: url) { (unsafeData, response, error) in
			do {
				let (answer, data) = try self.verify(response, unsafeData, error)

				let values : Currencies = try self.verify(response: answer, data: data, log: log)

				#if canImport(os)
				os_signpost(.end, log: self.logging, name: log, "Fetched %d currencies", values.currencies.count)
				#endif

				handler(.success(values.currencies))
			} catch {
				handler(.failure(self.handle(error, log: log)))
			}
		}

		task.resume()
		return task.progress
	}

	@discardableResult public func forexPairs(handler: @escaping(_ result: Result<[Currency.Pair], ErrorAPI>) -> Void) -> Progress {

		let url = endpoints.forex(.pairs)
		let log : StaticString = "Possibles forex pairs request"

		#if canImport(os)
		os_signpost(.begin, log: logging, name: log)
		#endif

		let task = session.dataTask(with: url) { (unsafeData, response, error) in
			do {
				let (answer, data) = try self.verify(response, unsafeData, error)

				let values : CurrencyPairs = try self.verify(response: answer, data: data, log: log)

				#if canImport(os)
				os_signpost(.end, log: self.logging, name: log, "Fetched %d forex pairs", values.pairs.count)
				#endif

				handler(.success(values.pairs))
			} catch {
				handler(.failure(self.handle(error, log: log)))
			}
		}

		task.resume()
		return task.progress
	}

	@discardableResult public func forexPrices(for pair: Currency.Pair, time frame: Timeframe = .D1,
											   page size: Int = 100, next page: String? = nil,
											   from start: Date, to end: Date = .init(), timezone: String = "UTC", time values: TimeValues,
											   handler: @escaping(_ result: Result<[Price], ErrorAPI>)->Void) -> Progress {

		var parameters : Set<URLQueryItem> = [.init(timezone: timezone) , .init(page: size)]

		if values.contains(.hour) {
			parameters.insert(.init(startTime: start))
			parameters.insert(.init(endTime: end))
		}

		if values.contains(.date) {
			parameters.insert(.init(start: start))
			parameters.insert(.init(end: end))
		}

		let url = endpoints.forex(.price, pair: pair, timeFrame: frame, param: parameters)
		let log : StaticString = "Price history request"

		#if canImport(os)
		os_signpost(.begin, log: logging, name: log,
					"%d element of %s at %s frame in %s timezone, from %s to %s",
					size, pair.code, frame.rawValue, timezone, start.description, end.description)
		#endif

		let task = session.dataTask(with: url) { (unsafeData, response, error) in
			do {
				let (answer, data) = try self.verify(response, unsafeData, error)

				let values : CurrencyPrices = try self.verify(response: answer, data: data, log: log)

				#if canImport(os)
				os_signpost(.end, log: self.logging, name: log, "Fetched %d prices of %s", values.prices.count, values.pair.code)
				#endif

				handler(.success(values.prices))
			} catch {
				handler(.failure(self.handle(error, log: log)))
			}
		}


		task.resume()
		return task.progress
	}

	// MARK: - Errors

	private func handle(_ error: Error, log: StaticString) -> ErrorAPI {

				#if canImport(os)
				os_signpost(.end, log: logging, name: log, "Error: %s", error.localizedDescription)
				#endif

		switch error {
		case let status as ErrorAPI.StatusCode :
			return ErrorAPI(status)
		case let response as ErrorAPI.Response:
			return ErrorAPI(response)
		default:
			return ErrorAPI(error)
		}

	}

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
			case dataCorrupted(expected: Int, Int)
			case invalid(code: StatusCode, error: ResponseError)
		}

		public let localizedDescription: String

		fileprivate init(_ error: Error) {
			// TODO: Handle errors
			localizedDescription = error.localizedDescription
		}

		fileprivate init(_ error: StatusCode) {
			// TODO: Handle errors
			localizedDescription = "The request made with the server failed for multiple reason."
		}

		fileprivate init(_ error: Response) {
			localizedDescription = "The request made with the server was corruped."
		}

	}



	// MARK: - Logs

	private let logger = Logger(label: "IntrinioAPI")

	#if canImport(os)
	private let logging = OSLog(subsystem: "IntrinioAPI", category: "Request")
	#endif


}
