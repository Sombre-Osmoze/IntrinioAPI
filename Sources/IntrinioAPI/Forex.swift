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

	/// The currency that is used as the reference is called quote currency and the currency that is quoted in relation is called the base currency.
	/// - note: in the pair code “EURGBP” with a price of 0.88, one Euro (base currency) can be exchanged for 0.88 British Pounds (quote currency).
	public struct Pair : ResponseAPI {

		/// The common code of the currency pair.
		public let code : String

		/// The ISO 4217 currency code of the base currency.
		public let base : Code

		/// The ISO 4217 currency code of the quote currency.
		public let quote : Code

		enum CodingKeys: String, CodingKey {
			case code = "code"
			case base = "base_currency"
			case quote = "quote_currency"
		}
	}

}
