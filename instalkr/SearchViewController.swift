//
//  SearchViewController.swift
//  instalkr
//
//  Created by Yvonne Ng on 6/27/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController : UIViewController, UISearchBarDelegate, UISearchControllerDelegate
{

    let goToGraph : String = "searchToGraph"
    
    @IBOutlet var searchBar : UISearchBar!
    
    var searchUser : String?
    var results : [ Model_User ]?
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        if let searchResult = results
        {
            NSLog("\(searchResult.count)")
        }
    }
    
    
    func doSearchForUser()
    {
        
    }
    
    
    

    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool
    {
        searchBar.alpha = 0.8
        
        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        
        searchBar.alpha = 0.15
        
        return true
    }



        
        
       
}
