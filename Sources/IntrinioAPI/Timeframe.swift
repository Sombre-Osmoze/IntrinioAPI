//
//  Timeframe.swift
//  IntrinioAPI
//
//  Created by Marcus Florentin on 05/11/2019.
//

import Foundation

public enum Timeframe: String, Codable {
	case m1 = "m1"
	case m5 = "m5"
	case m15 = "m15"
	case m30 = "m30"
	case H1 = "H1"
	case H2 = "H2"
	case H3 = "H3"
	case H4 = "H4"
	case H6 = "H6"
	case H8 = "H8"
	case D1 = "D1"
	case W1 = "W1"
	case M1 = "M1"
}

public typealias TimeValues = Set<TimeValue>

public enum TimeValue {
	case hour
	case date
}
