//
//  APIManager.swift
//  NikeMVSO
//
//  Created by Павел Бондарева on 30.11.2024.
//

import Foundation

class APIManager {
    static let sharedInstance = APIManager()
    
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
                let decoder = JSONDecoder ()
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
