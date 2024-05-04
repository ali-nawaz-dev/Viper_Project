//
//  API Service.swift
//  VIPER_Demo
//
//  Created by Sheikh Ali on 03/05/2024.
//

import Foundation

class APIService {
    func getData(request: ApiRequestProtocol, completion: @escaping (Result<Data, ApiError>) -> Void) {
        
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body?.toJSONData()
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.network(errorMessage: error?.localizedDescription ?? "unexpected error")))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}
