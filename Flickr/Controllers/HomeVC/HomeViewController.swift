//
//  ViewController.swift
//  Flickr
//
//  Created by Pankaj Verma on 06/10/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            fetchedResultsController = FetchedResultsController(action: { [unowned self] (action) in
                FetchedResultActionHandler(collectionView: self.collectionView).handelAction(action)
            })
                
            //datasource
            self.imageDataSource = ViewDataSource(fetchedResultsController: self.fetchedResultsController)
            self.collectionView.dataSource = self.imageDataSource
                
            //delegate
            self.viewDelegate = ViewDelegate(completion: { (indexPath, action) in
                switch action{
                    case .display:
                        if indexPath.row == (self.fetchedResultsController.fetchedResultsController.fetchedObjects?.count ?? 0) - 1{
                            self.fetchedResultsController.fetchedResultsController.fetchRequest.fetchLimit += 15
                        do {
                            try self.fetchedResultsController.fetchedResultsController.performFetch() //now fetchedResultsController has data. It knows about  sections, rows and items initial data to show in view
                        } catch {
                            fatalError("Failed to initialize FetchedResultsController: \(error)")
                    }
                }
                    case .select:
                        let destination = DetailsViewController()
//                        let indexPaths = self.collectionView.indexPathsForSelectedItems
                        let selectedObject = self.fetchedResultsController.objectAtIndexPath(indexPath: indexPath) 
                        destination.url = selectedObject.url
                    self.navigationController?.pushViewController(destination, animated: true)
                }
            })
            self.collectionView.delegate = viewDelegate
        }
    }
    

    var resultSearchController = UISearchController()
    let  cellIdentifier = "ImageCell";
    
    var imageDataSource:ViewDataSource!
    var viewDelegate:ViewDelegate?
    var searchDelegate:SearchDelegate?
    var downloadManager:DownloadManager = DownloadManager()
    var flowLayout:CustomFlowLayout = CustomFlowLayout()
    var fetchedResultsController:FetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        downloadManager.loadPosters()
        setResultSearchController()
       collectionView.collectionViewLayout = flowLayout
        

    }
    
 
    func setResultSearchController() -> Void {
        
        searchDelegate = SearchDelegate(onInput:{[unowned self] searchText in
            self.downloadManager.searchText = searchText
        } )
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = searchDelegate
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.hidesNavigationBarDuringPresentation = false;
            //self.definesPresentationContext = NO;
            self.navigationItem.titleView = controller.searchBar
            
            
            return controller
        })()
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
    
    
    //    func setCollectionViewDelegate() -> Void {
    //        viewDelegate = ViewDelegate(onSelection:{[unowned self] indexPath in
    //            let detailsVC = DetailsViewController()
    //            detailsVC.photo = self.imageDataSource!.photos[indexPath.row]
    //            self.navigationController?.pushViewController(detailsVC, animated: true)
    //            }, onDisplay: {[unowned self] indexPath in
    //                if indexPath.row == self.imageDataSource!.photos.count - 1 {
    //                    //last cell, load more...
    //                    //copyNextRecordsFromTotalPhotos()
    //                    // self.collectionView.reloadData()
    //                }
    //        })
    //        collectionView.delegate = viewDelegate
    //    }
    //
}

