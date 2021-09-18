//
//  BookDetailsViewController.swift
//  BooksLibrary
//
//  Created by Fatma Mohamed on 15/09/2021.
//

import UIKit

class BookDetailsViewController: UIViewController {
    
    

    @IBOutlet weak var bookAuthor: UIButton!
    @IBOutlet weak var bookTitle: UIButton!
    @IBOutlet weak var isbnTableView: UITableView!
    
    
    private let viewModel: BookDetailsViewModel

    
    init?(coder: NSCoder, viewModel: BookDetailsViewModel) {
           self.viewModel = viewModel
           super.init(coder: coder)
       }

       required init?(coder: NSCoder) {
           fatalError("You must create this view controller with a user.")
       }

    
    
    @IBAction func showTitles(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = mainStoryboard.instantiateViewController(withIdentifier: "Main") as! ViewController
        if let title = bookTitle.title(for: .normal) {
            secondViewController.bookTitle.value = title
        }
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    
    @IBAction func showAuthors(_ sender: Any) {
        //Open VC again with authors query
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = mainStoryboard.instantiateViewController(withIdentifier: "Main") as! ViewController
        if let author = bookAuthor.title(for: .normal) {
            secondViewController.bookAuthor.value = author
        }
        self.navigationController?.pushViewController(secondViewController, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookAuthor.setTitle(self.viewModel.author, for: .normal)
        bookTitle.setTitle(self.viewModel.title, for: .normal)
    }

}

extension BookDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.isbn.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ISBNCell", for: indexPath) as! BookISBNTableViewCell
        let imageEndPoint = Endpoint.getCoverImg(isbn: self.viewModel.isbn[indexPath.row], size: "S")
        cell.coverImage.loadImage(endPoint: imageEndPoint)
        cell.isbnNo.text = self.viewModel.isbn[indexPath.row]
        return cell
    }
}

