//
//  SearchDelegate.swift
//  Flickr
//
//  Created by Pankaj Verma on 10/11/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import Foundation
import UIKit
class SearchDelegate: NSObject, UISearchResultsUpdating {
    var onInputText:(String)->()
    var currentTime = Date()
    var lastTime = Date()
    var currentText = ""
    var lastText = ""
    var apiSent = false
    
    init(onInput:@escaping(String)->()) {
        self.onInputText = onInput
    }
    //MARK:- UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {

        lastTime = currentTime;
        currentTime = Date()
        lastText = currentText
        currentText = searchController.searchBar.text!
        
        isQualifiedTextForSearch()
    }
    func isQualifiedTextForSearch() -> Void {
        apiSent = false
        //minimum 2 char required to call API, next api will be hit after timeIntervalkaj
        let validTimeInterval = currentTime.timeIntervalSince(lastTime) > 2
        let validForSearch = lastText != currentText
        
        //send last hit after 2 seconds if user stopped typing but hit is not sent
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 + Date().timeIntervalSince(currentTime)) {[weak self] in
            self?.trackForIdleHit()
        }
        if (!validForSearch || !validTimeInterval){
            return
        }
        apiSent = true
        onInputText(currentText)
    }
    func trackForIdleHit() -> Void {
        if !apiSent && lastText != currentText{
            apiSent = true
             onInputText(currentText)
        }

    }

}
