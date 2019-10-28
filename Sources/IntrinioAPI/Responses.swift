//
//  Responses.swift
//  IntrinioAPI
//
//  Created by Marcus Florentin on 28/10/2019.
//

import Foundation

// MARK: - Codable

let decoder : JSONDecoder = JSONDecoder()

public protocol ResponseAPI : Codable {

}

// MARK: - Forex


// MARK: Currency

/// All Returns currencies for which prices are available.
public struct Currencies : ResponseAPI {

	/// The currency list.
	public let currencies : [Currency]

}
