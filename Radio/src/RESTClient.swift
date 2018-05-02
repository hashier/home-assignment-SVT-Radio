//
//  RESTClient.swift
//  Radio
//
//  Created by Christopher Lössl on 2018-05-01.
//  Copyright © 2018 Christopher Lössl. All rights reserved.
//

import Foundation

internal class RESTClient {

    lazy var session: URLSession = {
        return URLSession(configuration: URLSessionConfiguration.default)
    }()

    internal func getTimetable(_ completion: @escaping (Result<Timetable>) -> Void) {
        let task = session.dataTask(with: URL(string: Constants.url)!) { (responseData, response, error) in
            let requestResult = Result(value: responseData, error: error)
            switch requestResult {
            case .success(let data):
                let decodeResult = RESTClient.decode(Timetable.self, from: data)
                completion(decodeResult)
            case .failure(let msg):
                let error = NSError(domain: "Network", code: 1,
                                    userInfo: [NSLocalizedDescriptionKey: "Network: \(msg)"])
                completion(.failure(error))
            }
        }
        task.resume()
    }

}

private extension RESTClient {
    private static let jsonDecoder = JSONDecoder()

    private static func decode<T: Decodable>(_ type: T.Type, from data: Data) -> Result<T> {
        do {
            let responseObject = try jsonDecoder.decode(T.self, from: data)
            return .success(responseObject)
        } catch let parseError {
            print("Error: \(parseError)")
            let error = NSError(domain: "Decode", code: 1,
                                userInfo: [NSLocalizedDescriptionKey: "Decode: \(parseError)"])
            return .failure(error)
        }
    }
}
