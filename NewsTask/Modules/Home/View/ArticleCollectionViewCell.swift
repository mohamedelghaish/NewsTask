//
//  ArticleCollectionViewCell.swift
//  NewsTask
//
//  Created by Mohamed Kotb Saied Kotb on 02/11/2024.
//

import UIKit
import Kingfisher

class ArticleCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var cellView: UIView!
    
    
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 12.0
        articleImageView.layer.cornerRadius = 12.0
        
        labelView.layer.cornerRadius = 12.0
    }

    
    func configure(with article: Article) {
        titleLabel.text = article.title
        authorLabel.text = article.author
        descriptionLabel.text = article.description

        if let imageUrl = URL(string: article.urlToImage ?? "") {
            articleImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholderImage"))
        } else {
            articleImageView.image = UIImage(named: "placeholderImage")
        }
        
    }
    
    
    
   
}

