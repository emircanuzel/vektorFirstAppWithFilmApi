//
//  ViewController.swift
//  vektorFirstAppWithFilmApi
//
//  Created by user920681 on 3/6/20.
//  Copyright © 2020 emircan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource {
    
    
    let URL = "https://api.themoviedb.org/3/movie/222/lists?api_key=a8f2b271830886713bf596803001885a&page=1"
    var tableData = [String]()
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        callService()
    }
    
    
    
    
    //    MARK: - TableView
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = tableData[indexPath.row]
        return cell
    }
    
    
    // MARK: - Service Call
    
    
    func callService()  {
        
        AF.request(URL, method: .get).responseJSON { (response) in
            
            
            let filmJSON : JSON = JSON(response.value!)
            
            DispatchQueue.main.async {
                
                if let results = filmJSON["results"].array {
                    for result in results {
                        print(result["name"])
                        self.tableData.append(result["name"].stringValue)
                    }
                }
                
                self.tableView.reloadData()
                
            }
            
            // print(JSON( response.value!))
        }
    }
    
    
    
}

