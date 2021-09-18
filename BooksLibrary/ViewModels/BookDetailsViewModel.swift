//
//  BookDetailsViewModel.swift
//  BooksLibrary
//
//  Created by Fatma Mohamed on 17/09/2021.
//

import Foundation


struct BookDetailsViewModel {
        
 
    private let book: Book

    init(book: Book) {
        self.book = book
    }
}

extension BookDetailsViewModel {
  
    var title: String {
        return book.title ?? ""
    }

    var author: String {
        return book.authorName?[0] ?? ""
    }
    
    var isbn: [String] {
        return book.isbn ?? []
    }

    }


