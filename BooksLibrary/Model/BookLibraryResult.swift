//
//  BookLibraryResult.swift
//  BooksLibrary
//
//  Created by Fatma Mohamed on 15/09/2021.
//

import Foundation


struct BookLibraryResult: Codable {

    let start: Int
    let numFound: Int
    let docs: [Book]

    private enum CodingKeys: String, CodingKey {
        case start
        case numFound = "num_found"
        case docs
    }
}



struct Book: Codable, Equatable {

    let title: String?
    let authorName: [String]?
    let key: String?
    let coverI: Int?
    let isbn: [String]?

    private enum CodingKeys: String, CodingKey {
        case key
        case title
        case authorName = "author_name"
        case coverI = "cover_i"
        case isbn
    }

    public static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.key == rhs.key &&
            lhs.title == rhs.title &&
            lhs.authorName == rhs.authorName &&
            lhs.coverI == rhs.coverI &&
            lhs.isbn == rhs.isbn
    }
}
