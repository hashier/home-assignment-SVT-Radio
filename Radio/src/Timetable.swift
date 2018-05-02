//
//  Timetable.swift
//  Radio
//
//  Created by Christopher Lössl on 2018-05-01.
//  Copyright © 2018 Christopher Lössl. All rights reserved.
//

import Foundation

// MARK: - TimeTable
internal struct Timetable: Decodable {
    internal let copyright: String
    internal let programs: [Program]
    internal let pagination: Page
}

// MARK: - Program
internal struct Program: Decodable {
    internal let description: String
    internal let id: Int
    internal let name: String
}

// MARK: - Page
internal struct Page: Decodable {
    internal let page: Int
    internal let size: Int
    internal let total: Int

    private enum CodingKeys: String, CodingKey {
        case page
        case size
        case total = "totalhits"
    }
}
