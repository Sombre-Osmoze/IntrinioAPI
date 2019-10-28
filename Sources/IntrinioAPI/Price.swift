//
//  Price.swift
//  IntrinioAPI
//
//  Created by Marcus Florentin on 28/10/2019.
//

import Foundation


public struct Price: ResponseAPI {

	public typealias Value = String

	/// The timestamp of the beginning of the timeframe.
	/// The open prices would be at this time, while close prices would be at this time plus the timeframe.
	public let occured : Date

	/// Total ticks.
	public let ticks : Int

	// MARK: - Bid

	/// Open bid.
	public let openBid : Value

	/// High bid.
	public let highBid : Value

	/// Low bid.
	public let lowBid : Value

	/// Close bid.
	public let closeBid : Value


	// MARK: - Ask

	/// Open ask.
	public let openAsk : Value

	/// High ask.
	public let highAsk : Value

	/// Low ask.
	public let lowAsk : Value

	/// Close ask.
	public let closeAsk : Value

	enum CodingKeys: String, CodingKey {
		case occured = "occurred_at"
		case ticks = "total_ticks"
		case openBid = "open_bid"
		case highBid = "high_bid"
		case lowBid = "low_bid"
		case closeBid = "close_bid"
		case openAsk = "open_ask"
		case highAsk = "high_ask"
		case lowAsk = "low_ask"
		case closeAsk = "close_ask"

	}
}
