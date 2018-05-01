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

    internal func getProgram(_ completion: @escaping (Result<[Program]>) -> Void) {
        let task = session.dataTask(with: URL(string: Constants.url)!) { (responseData, response, error) in
            let requestResult = Result(value: responseData, error: error)
            switch requestResult {
            case .success(let data):
                let dict = RESTClient.decode(Outer.self, from: data)
                if case .success(let dict) = dict {
                    completion(.success(dict.programs))
                }
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
            return Result(value: responseObject, error: nil)
        } catch let parseError {
            print("Error: \(parseError)")
            let error = NSError(domain: "Decode", code: 1,
                                userInfo: [NSLocalizedDescriptionKey: "Decode: \(parseError)"])
            return .failure(error)
        }
    }
}
