//
//  SearchViewController.swift
//  instalkr
//
//  Created by Yvonne Ng on 6/27/15.
//  Copyright (c) 2015 sassyCodes. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController : UIViewController, UISearchBarDelegate, UISearchControllerDelegate, UITableViewDataSource, UITableViewDelegate
{

    let goToGraph : String = "searchToGraph"
    
    @IBOutlet var searchBar : UISearchBar!
    @IBOutlet var userTableView : UITableView!
    var searchUser : String?
    var results : [ Model_User ]?
    var userSelected : Model_User?
    
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
            NSLog("\nResults \t\(self.results?.count)")
            
            self.userTableView.reloadData()
        }
        
    }
    
    
    func doSearchForUser()
    {
        var theSession =  NSURLSession.sharedSession()
        var access_token : String = NSUserDefaults.standardUserDefaults().objectForKey(userPrefKeys_accessToken) as! String
        if let url : NSURL = NSURL( string: Instagram_API.getUserSearch(access_token, query_user_name: self.searchBar.text ) )
        {
            theSession.dataTaskWithURL(url, completionHandler: {
                
                (data, response, error) -> Void in
                
                let jsonData : AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)!
                
                self.results = [Model_User]()
                for eachUser in (jsonData.objectForKey("data") as! NSMutableArray)
                {
                    var firstName = ""
                    if(eachUser.objectForKey("first_name") != nil)
                    {
                        firstName = eachUser.objectForKey("first_name") as! String
                    }
                    
                    var lastName = ""
                    if(eachUser.objectForKey("last_name") != nil)
                    {
                        lastName = eachUser.objectForKey("last_name") as! String
                    }
                    
                    self.results?.append(
                        Model_User(        id: eachUser.objectForKey("id") as! String,
                            username: eachUser.objectForKey("username") as! String,
                            profile_picture: eachUser.objectForKey("profile_picture") as! String,
                            first_name: firstName,
                            last_name: lastName
                        )
                    )
                }
              
                dispatch_async(dispatch_get_main_queue(), {
                
                    self.userTableView.reloadData()
                    
                    return
                })
                
            }).resume()
        }

    }
    
    

    // -- Search Bar methods

    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        if let haveResults = self.results
        {
            self.results?.removeAll()
        }
        
        self.doSearchForUser()
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



    // -- Table View methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let haveResults = results
        {
            return haveResults.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        var cell : VMCellUser = self.userTableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! VMCellUser
        
        
        cell.setStyle()
        
        var theSession = NSURLSession.sharedSession()
        
        if let url = NSURL(string: self.results![indexPath.row].profile_picture as String)
        {
            theSession.dataTaskWithURL(url, completionHandler: {
                
                (data, response, error) -> Void in
                dispatch_async(dispatch_get_main_queue(),{
                    
                    cell.userImg!.image = UIImage(data: data)!
                    
                    return
                })
                
            }).resume()
        }
        
        cell.usernameLabel!.text = self.results?[indexPath.row].username
        
        cell.fullNameLabel!.text = self.results?[indexPath.row].full_name
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.userSelected = self.results![indexPath.row]
        
        self.goToGraphNow()
    }
    
    func goToGraphNow()
    {
        self.performSegueWithIdentifier(goToGraph, sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == goToGraph)
        {
            (segue.destinationViewController as! GraphViewController).searchedUser = self.userSelected!
        }
    }
       
}
