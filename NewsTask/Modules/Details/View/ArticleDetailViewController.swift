//
//  ArticleDetailViewController.swift
//  NewsTask
//
//  Created by Mohamed Kotb Saied Kotb on 02/11/2024.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
    
    @IBOutlet weak var svaeBtn: UIButton!
    @IBOutlet weak var detailsView: UIView!
    
    
    @IBOutlet weak var labelView: UIView!
    
    var article: Article?
    var favoriteViewModel: FavoriteViewModel?
    weak var delegate: ArticleDetailDelegate?
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleAuthor: UILabel!
    @IBOutlet weak var articleDesc: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteViewModel = FavoriteViewModel()
        detailsView.layer.cornerRadius = 15
        
        labelView.layer.cornerRadius = 15
        
        articleImage.layer.cornerRadius = 15
        
        svaeBtn.layer.cornerRadius = 15
        articleTitle.text = article?.title
        articleAuthor.text = article?.author
        articleDesc.text = article?.description
        
        if let imageUrl = URL(string: article?.urlToImage ?? "") {
            articleImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholderImage"))
        } else {
            articleImage.image = UIImage(named: "placeholderImage")
        }
    }
    
    
    @IBAction func saveArticle(_ sender: Any) {
        if let article = article {
            if favoriteViewModel?.isArticleFavorite(article) == true {
                
                let alert = UIAlertController(title: "Already Added", message: "This article is already in your favorites.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            } else {
               
                favoriteViewModel?.saveArticle(article)
                self.dismiss(animated: true) {
                    self.delegate?.didSaveArticle()
                    
                }
            }
        }
    }

}



