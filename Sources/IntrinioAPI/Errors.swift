//
//  Errors.swift
//  IntrinioAPI
//
//  Created by Marcus Florentin on 28/10/2019.
//

import Foundation

// MARK: - Status Code

func log(_ error: IntrinioAPI.APIError.StatusCode) -> StaticString {
	switch error {
	case .unauthorized:
		return "User/Password API Keys are incorrect."
	case .forbidden:
		return "Not subscribed to the data feed requested."
	case .notFound:
		return "The endpoint requested does not exist."
	case .tooManyRequest:
		return "You have hit a limit.."
	case .internalServerError:
		return "A problem with the server. Try again later."
	case .serviceUnavailable:
		return "Throttle limit hit or Intrinio may be experiencing high system load."

	}

}
