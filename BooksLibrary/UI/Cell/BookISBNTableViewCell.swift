//
//  BookISBNTableViewCell.swift
//  BooksLibrary
//
//  Created by Fatma Mohamed on 17/09/2021.
//

import UIKit

class BookISBNTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var isbnNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
