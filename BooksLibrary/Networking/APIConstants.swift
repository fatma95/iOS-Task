//
//  Constants.swift
//  BooksLibrary
//
//  Created by Fatma Mohamed on 15/09/2021.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    static func getBooks(query: String) -> Endpoint {
        return Endpoint(path: APIConstants.APIPath.searchBooks, queryItems: [
        URLQueryItem(name: "q", value: query)])
    }
    
    static func getCoverImg(isbn: String, size: String) -> URL? {
        return URL(string: "\(APIConstants.APIPath.coverImg)\(isbn)-\(size).jpg")
    }
    
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}


struct APIConstants {
    
    struct APIPath {
        static let searchBooks = "http://openlibrary.org/search.json?q="
        static let coverImg = "http://covers.openlibrary.org/b/isbn/"
    }
    
}
