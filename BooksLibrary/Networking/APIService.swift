//
//  APIHandler.swift
//  BooksLibrary
//
//  Created by Fatma Mohamed on 15/09/2021.
//

import Foundation


class APIService {
    static let shared = APIService()
    
    init(urlSession: URLSession = .shared) {
            self.session = urlSession
        }

    let session: URLSession
    
    func downloadimage(url: URL, completion: @escaping(Data?, Error?) -> Void)  {
        let task = session.dataTask(with: url, completionHandler: { data, response,error in
            if error != nil {
                completion(nil, error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(nil, error)
                return
            }
            
                guard let data = data else { return }
            DispatchQueue.main.async {
                completion(data, nil)
            }
               
        })
        task.resume()
    }
    
    
    
    func getData<T: Codable>(url: URL, completion: @escaping(T?,Error?)-> Void)  {
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                completion(nil, error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(nil, error)
                return
            }
            
            //MARK:- Parse data
            do {
                guard let data = data else { return }
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(response, nil)
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
        }
        task.resume()
    }
    
    
}
