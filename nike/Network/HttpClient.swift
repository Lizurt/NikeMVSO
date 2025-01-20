//
//  HttpClient.swift
//  nike
//
//  Created by Pasha on 19.01.2025.
//

import Foundation

final class HttpClient {
    
    static let sharedInstance = HttpClient()
    
    private init() {}
    
    func get<T: Decodable>(withUrl: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: withUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let strongData = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(T.self, from: strongData)
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        })
        task.resume()
    }
}
