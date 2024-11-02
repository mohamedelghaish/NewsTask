//
//  HomeViewController.swift
//  NewsTask
//
//  Created by Mohamed Kotb Saied Kotb on 02/11/2024.
//

import UIKit
import Combine

class HomeViewController: UIViewController, UISearchBarDelegate,ArticleDetailDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var datePicker: UIDatePicker!

    private let viewModel = HomeViewModel()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
        bindViewModel()
        viewModel.fetchArticles(query: "apple", fromDate: nil)
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
    }
    
    @objc func datePickerChanged() {
        guard let query = searchBar.text, !query.isEmpty else { return }
        let selectedDate = datePicker.date
        viewModel.fetchArticles(query: query, fromDate: selectedDate)
    }
        
    private func bindViewModel() {
        viewModel.$articles
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
        
    
    func didSaveArticle() {
        print("Delegate notified of article save")
        showSuccessAlert()
    }
        

    func showSuccessAlert() {
        let alert = UIAlertController(title: "Success", message: "Article has been added to favorites!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
        

    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ArticleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ArticleCell")
        
        let layout = UICollectionViewFlowLayout()
        
        let padding: CGFloat = 1
        let itemSpacing: CGFloat = 0.5
        let numberOfItemsInRow: CGFloat = 2.2
        
        let availableWidth = view.frame.width
        let itemWidth = availableWidth / numberOfItemsInRow
        
        
        layout.itemSize = CGSize(width: itemWidth, height: 291)
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.minimumLineSpacing = itemSpacing
        layout.minimumInteritemSpacing = itemSpacing
        
        collectionView.collectionViewLayout = layout
    }


    
    private func setupSearchBar() {
        searchBar.delegate = self
    }


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let query = searchBar.text, !query.isEmpty else { return }
        
        let selectedDate = datePicker.date
        viewModel.fetchArticles(query: query, fromDate: selectedDate)
    }
}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.articles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as? ArticleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let article = viewModel.articles[indexPath.row]
        cell.configure(with: article)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let selectedArticle = viewModel.articles[indexPath.row]
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "ArticleDetailViewController") as! ArticleDetailViewController
        //detailVC.article = selectedArticle
        
        detailVC.modalPresentationStyle = .pageSheet
        
        present(detailVC, animated: true)
        
        //detailVC.delegate = self
    }

}


protocol ArticleDetailDelegate: AnyObject {
    func didSaveArticle()
}
