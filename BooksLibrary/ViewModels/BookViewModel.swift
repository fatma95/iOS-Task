//
//  BookViewModel.swift
//  BooksLibrary
//
//  Created by Fatma Mohamed on 15/09/2021.
//

import Foundation



enum CustomError: String {
    case apiError = "Something went wrong"
}


struct BookViewModel {
    
    var bookTitle: Observable<String> = Observable("")
    var bookAuthor: Observable<String> = Observable("")
    
    
    init(title: String? = nil, author: String? = nil) {
        self.bookTitle.value = title
        self.bookAuthor.value = author
    }
    
    var bookViewModels: Observable<[BookTableViewCellModel]> = Observable([])

    
    private var service =  APIService()
    
        
    func validateSearch(search: String) -> Bool {
        search.trimmingCharacters(in: .whitespaces).isEmpty ? false : true
    }
    
    
    
    func getBooksData(searchQuery: String, completion: @escaping (BookLibraryResult?, CustomError?) -> ()) {
        let searchQuery = searchQuery.replacingOccurrences(of: " ", with: "+")
        let urlStr = "\(APIConstants.APIPath.searchBooks)"+searchQuery
        guard let url = URL(string: urlStr) else { return }
        service.getData(url: url, completion: {  (result: BookLibraryResult? ,error) in
            if let _ = error {
                completion(nil, .apiError)
            } else {
                completion(result, nil)
            }
        })
    }
}

