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
    internal let image: String
    internal let category: String

    private enum CodingKeys: String, CodingKey {
        case description
        case id
        case name
        case image = "programimage"
        case category = "programcategory"
    }

    private enum CatCodingKeys: String, CodingKey {
        case name
    }

    init() {
        description = ""
        id = 0
        name = ""
        image = ""
        category = ""
    }

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: CodingKeys.self)
        let catContainer = try rootContainer.nestedContainer(keyedBy: CatCodingKeys.self, forKey: .category)

        description = try rootContainer.decode(String.self, forKey: .description)
        id = try rootContainer.decode(Int.self, forKey: .id)
        name = try rootContainer.decode(String.self, forKey: .name)
        image = try rootContainer.decode(String.self, forKey: .image)
        category = try catContainer.decode(String.self, forKey: .name)
    }

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
