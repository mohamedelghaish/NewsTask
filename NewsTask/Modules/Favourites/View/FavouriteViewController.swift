//
//  FavouriteViewController.swift
//  NewsTask
//
//  Created by Mohamed Kotb Saied Kotb on 02/11/2024.
//

import UIKit
import Combine

class FavouriteViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    var favoriteViewModel: FavoriteViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteViewModel = FavoriteViewModel()
        setupCollectionView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        favoriteViewModel?.$favoriteArticles
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ArticleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ArticleCell")
        
        let layout = UICollectionViewFlowLayout()
        
        let padding: CGFloat = 1
        let itemSpacing: CGFloat = 0.5
        let numberOfItemsInRow: CGFloat = 2.1
        
        let availableWidth = view.frame.width
        let itemWidth = availableWidth / numberOfItemsInRow
        
        
        layout.itemSize = CGSize(width: itemWidth, height: 291)
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.minimumLineSpacing = itemSpacing
        layout.minimumInteritemSpacing = itemSpacing
        
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteViewModel?.favoriteArticles.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as? ArticleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let source = Source(id: nil, name: "Unknown")
        let favoriteArticle = (favoriteViewModel?.favoriteArticles[indexPath.row])!
        let article = Article(from: favoriteArticle, source: source)   
        cell.configure(with: article)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let selectedArticle = favoriteViewModel?.favoriteArticles[indexPath.row]
        let source = Source(id: nil, name: "Unknown")
        
        let article = Article(from: selectedArticle!, source: source)
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "ArticleDetailViewController") as! ArticleDetailViewController
        detailVC.article = article
        
        detailVC.modalPresentationStyle = .pageSheet
        
        present(detailVC, animated: true)
        
        
    }
}
