//
//  Program.swift
//  Radio
//
//  Created by Christopher Lössl on 2018-05-01.
//  Copyright © 2018 Christopher Lössl. All rights reserved.
//

import Foundation

internal struct Outer {
    internal let copyright: String
    internal let programs: [Program]
}

extension Outer: Decodable {

    private enum CodingKeys: String, CodingKey {
        case copyright
        case programs
    }

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: CodingKeys.self)

        copyright = try rootContainer.decode(String.self, forKey: .copyright)
        programs = try rootContainer.decode([Program].self, forKey: .programs)
    }
}

internal struct Program {
    internal let description: String
    internal let id: Int
    internal let name: String
}

extension Program: Decodable {

    private enum ProgramCodingKeys: String, CodingKey {
        case description
        case id
        case name
    }

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: ProgramCodingKeys.self)

        description = try rootContainer.decode(String.self, forKey: .description)
        id = try rootContainer.decode(Int.self, forKey: .id)
        name = try rootContainer.decode(String.self, forKey: .name)
    }
}
