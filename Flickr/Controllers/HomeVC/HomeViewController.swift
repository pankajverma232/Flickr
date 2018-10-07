//
//  ViewController.swift
//  Flickr
//
//  Created by Pankaj Verma on 06/10/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating, UITextFieldDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let  cellIdentifier = "ImageCell";
    var searchText:String = ""{
        willSet(newText) {
            flickrUrlString = FlickrUrlManager.getSearchUrlForText(text: newText)
            imageCache.deleteAllRecords()
            loadTotalPhotos()
        }
    }
    var flickrUrlString = FlickrUrlManager.defaultSearchUrl
    
    var photos: [Photo] = []{
        didSet {
            collectionView.reloadData()
        }
    }
    var limit = 24
    var totalPhotos: [Photo] = []
    var startIndex = 0
    var resultSearchController = UISearchController()
    
    lazy var imageCache:ImageCache = ImageCache()
    var photoDownloadTask:URLSessionDataTask?
    
    
    //MARK:- UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ImageCell
        cell.configure(with: photos[indexPath.row])
        return cell;
    }
    
    //MARK:- UICollectionViewDelegate
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.row == photos.count - 1 {
//            //last cell, load more...
//            copyNextRecordsFromTotalPhotos()
//            self.collectionView.reloadData()
//        }
//    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        detailsVC.photo = photos[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    //MARK:- UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        //filteredResult.removeAll(keepingCapacity: false)
       isQualifiedTextForSearch(text: searchController.searchBar.text!)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let set = NSCharacterSet.alphanumerics.inverted
        return string.rangeOfCharacter(from: set) == nil
        
    }
    func isQualifiedTextForSearch(text:String) -> Void {
        
            //minimum 3 char required to call API
        if (text.count < 2){
            return
        }
        searchText = text
    }
                
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = CustomFlowLayout()
        loadTotalPhotos()
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.hidesNavigationBarDuringPresentation = false;
            //self.definesPresentationContext = NO;
            self.navigationItem.titleView = controller.searchBar
            
            
            return controller
        })()
    }
    
    func loadTotalPhotos() -> Void {
        startIndex = 0
        guard let flickrUrl = URL(string: flickrUrlString) else { return }
        //cancell active task(if any) first since it's of no use now
        photoDownloadTask?.cancel()
        photoDownloadTask = URLSession.shared.dataTask(with: flickrUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                
                let root = try decoder.decode(Root.self, from: data)
                DispatchQueue.main.async { [unowned self] in
                    if let receivedphotos = root.subPhotos?.photos{
//                        self.totalPhotos = receivedphotos
//                        self.copyNextRecordsFromTotalPhotos()
                       
                        self.photos = receivedphotos;
                    }
                }
            } catch let err {
                print("Err", err)
            }
            }
        photoDownloadTask?.resume()
    }
    
    
    
//    func copyNextRecordsFromTotalPhotos() -> Void {
//        if startIndex >= totalPhotos.count-1 {
//            return
//        }
//        var endIndex = startIndex+limit-1
//        if(endIndex >= totalPhotos.count){
//            endIndex = totalPhotos.count - 1
//        }
//
//
//        photos.append(contentsOf: totalPhotos[startIndex...endIndex])
//        startIndex += limit
//
//
//
//
//        print("new photo count = \(photos.count)")
//        print("remaining photo count = \(totalPhotos.count)")
//    }
//
}

