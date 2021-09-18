//
//  ViewController.swift
//  BooksLibrary
//
//  Created by Fatma Mohamed on 15/09/2021.
//

import UIKit

class ViewController: UIViewController {
          
    var bookTitle: Observable<String> = Observable("")
    var bookAuthor: Observable<String> = Observable("")

    private var dataSource: BookLibraryResult?
    private var viewModel = BookViewModel()
    @IBOutlet weak var booksTableView: UITableView!
    weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setSearchBar()
        // Do any additional setup after loading the view.
    }
  
    
     fileprivate func setActivityController() {
         let activityIndicatorView = UIActivityIndicatorView(style: .medium)
         booksTableView.backgroundView = activityIndicatorView
         booksTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
         self.activityIndicatorView = activityIndicatorView
     }
     
    fileprivate func bind() {
        viewModel.bookViewModels.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.booksTableView.reloadData()
            }
        }
                
        self.bookAuthor.bind { [weak self] author in
             if let author = author, author != "" {
                 self?.getData(queryParam: author)
                 }
            }
        self.bookTitle.bind { [weak self] title in
             if let title = title, title != "" {
                 self?.getData(queryParam: title)
                 }
            
         }
     }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getData(queryParam: String)  {
            setActivityController()
            activityIndicatorView.startAnimating()
            self.viewModel.getBooksData(searchQuery: queryParam) { [weak self] bookLibrary, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Error", message: error.rawValue)
                    }
                } else {
                    if let result = bookLibrary {
                        self?.dataSource = result
                        if result.docs.count == 0 {
                            DispatchQueue.main.async {
                            self?.showAlert(title: "Try again", message: "No results found")
                            }
                        } else {
                            self?.viewModel.bookViewModels.value = result.docs.compactMap({
                                BookTableViewCellModel(title: $0.title ?? "", authorName: $0.authorName?[0] ?? "")
                            })
                        }
                    }
                }
                DispatchQueue.main.async {
                    self?.activityIndicatorView.stopAnimating()
                }
            }
        }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bookViewModels.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
        cell.bookTitle.text = viewModel.bookViewModels.value?[indexPath.row].title
        cell.author.text = viewModel.bookViewModels.value?[indexPath.row].authorName
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let book = dataSource?.docs[indexPath.row] else { return }
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "BookDetails", bundle: nil)
        let vm = BookDetailsViewModel(book: book)
        let detailsVC : UIViewController = mainStoryboard.instantiateViewController(identifier: "BookDetailsViewController", creator: { coder in
                return BookDetailsViewController(coder: coder, viewModel: vm)
        })
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}

extension ViewController: UISearchBarDelegate {
    func setSearchBar() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        searchBar.placeholder = "Book title, Author name"
        searchBar.delegate = self
        searchBar.tintColor = UIColor.lightGray
        self.booksTableView.tableHeaderView = searchBar
    }
    
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        if let searchText = searchBar.text {
            if viewModel.validateSearch(search: searchText) {
                self.getData(queryParam: searchText)
            } else {
                showAlert(title: "Try again", message: "Please enter valid text")
            }
            }
        }
    }

