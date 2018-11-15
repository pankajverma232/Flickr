//
//  FetchedResultActionHandler.swift
//  Flickr
//
//  Created by Pankaj Verma on 12/11/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import Foundation
import UIKit
class FetchedResultActionHandler {
    private var collectionView:UICollectionView
    private var blockOperations: [BlockOperation] = []

    init(collectionView:UICollectionView) {
        self.collectionView = collectionView
    }
    func handelAction(_ action:FetchedResultsControllerAction){
            switch action{
            case .willChangeContent:
                self.blockOperations.removeAll(keepingCapacity: false) //remove old operations
                self.collectionView.reloadData()
            case .didChangeContent:
                self.collectionView.performBatchUpdates({ //core data updated
                    self.blockOperations.forEach { $0.start() }
                }, completion: { finished in
                    self.blockOperations.removeAll(keepingCapacity: false)
                })
                
            case .ObjectAtion(let indexPath, let newIndexPath, let type):
                switch type { // item change in view
                case .insert:
                    guard let newIndexPath = newIndexPath else { return }
                    let op = BlockOperation { [weak self] in self?.collectionView.insertItems(at: [newIndexPath]) }
                    self.blockOperations.append(op)
                case .update:
                    guard let newIndexPath = newIndexPath else { return }
                    let op = BlockOperation { [weak self] in self?.collectionView.reloadItems(at: [newIndexPath]) }
                    self.blockOperations.append(op)
                case .move:
                    guard let indexPath = indexPath else { return }
                    guard let newIndexPath = newIndexPath else { return }
                    let op = BlockOperation { [weak self] in self?.collectionView.moveItem(at: indexPath, to: newIndexPath) }
                    self.blockOperations.append(op)
                case .delete:
                    guard let indexPath = indexPath else { return }
                    let op = BlockOperation { [weak self] in self?.collectionView.deleteItems(at: [indexPath]) }
                    self.blockOperations.append(op)
                }
            case .SectionAction(let sectionIndex, let type):
                switch type {
                case .insert:
                    let op = BlockOperation { [weak self] in self?.collectionView.insertSections(NSIndexSet(index: sectionIndex) as IndexSet) }
                    self.blockOperations.append(op)
                case .update:
                    let op = BlockOperation { [weak self] in self?.collectionView.reloadSections(NSIndexSet(index: sectionIndex) as IndexSet) }
                    self.blockOperations.append(op)
                case .delete:
                    let op = BlockOperation { [weak self] in self?.collectionView.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet) }
                    self.blockOperations.append(op)
                default: break
                }
            }
    }
    
}
