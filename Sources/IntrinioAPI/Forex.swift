//
//  Forex.swift
//  IntrinioAPI
//
//  Created by Marcus Florentin on 28/10/2019.
//

import Foundation

// MARK: - Currency

/// Forex currencies for which prices are available.
public struct Currency: ResponseAPI {

	/// The ISO 4217 currency code.
	public let code : Code

	/// The name of the currency
	public let name : String

	/// The country in which the currency is used
	public let country : String

	/// A ISO 4217 currency code
	public enum Code: String, Codable {
		/// Australian dollar.
		case AUD = "AUD"
		/// Canadian dollar.
		case CAD = "CAD"
		/// Switzerland franc.
		case CHF = "CHF"
		/// China yuan.
		case CNH = "CNH"
		/// Eurozone (*Europe*) euro.
		case EUR = "EUR"
		/// Great Britain pound
		case GBP = "GBP"
		/// Hong Kong dollar.
		case HKD = "HKD"
		/// Japan yen.
		case JPY = "JPY"
		/// Mexico peso.
		case MXN = "MXN"
		/// Norway krone.
		case NOK = "NOK"
		/// New Zealand dollar.
		case NZD = "NZD"
		/// Sweden krona.
		case SEK = "SEK"
		/// Turkey lira.
		case TRY = "TRY"
		/// United States dollar.
		case USD = "USD"
		/// South Africa rand.
		case ZAR = "ZAR"
	}

}
