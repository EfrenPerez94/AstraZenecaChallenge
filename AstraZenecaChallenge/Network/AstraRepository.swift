//
//  AstraRepository.swift
//  AstraZenecaChallenge
//
//  Created by Efrén Pérez Bernabe on 9/5/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import Foundation

final class AstraRepository {
    
    /// Perform a request, handling errors and response.
    /// - Note: The data retrive must to be a JSON to perform the decode.
    ///
    /// - Parameters:
    ///   - _: Model to decode the data retrived.
    ///   - url: URL to perform the request.
    ///   - completion: Closure that returns a Model for the request.
    ///   - model: Model retrieve from the request.
    func execute<T: Codable>(_: T.Type,
                             url: URL,
                             completion: @escaping (_ model: Result<T, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(Result.failure(error))
                return
            }
            guard let data = data else {
                completion(Result.failure(NetworkError.dataIsNil))
                return
            }
            
            do {
                let modelData = try JSONDecoder().decode(T.self, from: data)
                completion(Result.success(modelData))
            } catch {
                completion(Result.failure(NetworkError.unableToDecode))
                return
            }
        }.resume()
        return
    }
}

/// `NetworkError` specify problems making a request.
enum NetworkError: Error {
    case dataIsNil
    case unableToDecode
}
