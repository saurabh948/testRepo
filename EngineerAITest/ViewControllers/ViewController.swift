//
//  ViewController.swift
//  EngineerAITest
//
//  Created by PCQ184 on 02/08/19.
//  Copyright © 2019 PCQ184. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet private weak var tblView          : UITableView!
    @IBOutlet private weak var viewFooter       : UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Variables
    private var refreshControl  : UIRefreshControl?
    private var responseArray   : [Response]        = []
    private var pageCount       : Int               = 0
    private var isPageCompleted : Bool!             = false
    
    //MARK:- Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tblView.estimatedRowHeight  = 70
        tblView.rowHeight           = UITableView.automaticDimension
        
        //Webservice Call
        refreshControl?.beginRefreshing()
        pageCount = 0
        callPostAPI()
    }
    
    //MARK:- View Methods
    private func prepareView() {
        // Set navigation title
        setNavigationTitle()
        
        // Add Pull to refresh
        addRefreshControl()
    }
    
    //MARK:- API methods
    private func callPostAPI() {
        
        let sourceURL = "https://hn.algolia.com/api/v1/search_by_date?tags=story&page=" + "\(self.pageCount)"
        
        // Show Network indicatior
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        Alamofire.request(sourceURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            switch(response.result) {
            case .success(let value):
                let json = JSON(value)
                
                if self.pageCount == 0 {
                    self.refreshControl?.endRefreshing()
                    self.responseArray.removeAll()
                    self.setNavigationTitle()
                }
                
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 200:
                        let postList: Array<JSON> = json["hits"].arrayValue
                        let totalCount = json["nbPages"].intValue
                        
                        if self.pageCount < totalCount {
                            self.isPageCompleted = false
                            for i in 0..<postList.count {
                                
                                let dictPost = JSON(postList[i].dictionaryValue)
                                let post = Response.init(dictionary: dictPost)
                                self.responseArray.append(post)
                            }
                            self.activityIndicator.stopAnimating()
                        } else {
                            self.isPageCompleted = true
                        }
                        
                        self.tblView.reloadData()
                        break
                    default:
                        break
                    }
                }
                break
            case .failure:
                print("Failure")
                self.refreshControl?.endRefreshing()
                break
            }
        }
    }
    
    //MARK:- Custom methods
    private func setNavigationTitle()  {
        let arrFilter = self.responseArray.filter { (post) -> Bool in
            return post.isPostSelected
        }
        if arrFilter.count == 0 {
            self.title = "Number of selected posts: 0"
        } else {
            self.title = arrFilter.count > 1 ? "Number of selected posts: " + "\(arrFilter.count)" : "Number of selected post: " + "\(arrFilter.count)"
        }
    }
    
    // MARK:- Refresh Control Methods
    private func addRefreshControl() {
        if self.refreshControl == nil
        {
            refreshControl = UIRefreshControl()
            refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
            refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: UIControl.Event.valueChanged)
            self.tblView.addSubview(refreshControl!)
        }
    }
    
    @objc private func pullToRefresh() {
        self.pageCount = 0
        self.callPostAPI()
    }
}

//MARK: - Table View Delegate And Datasource Methods
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.responseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: ResponseCell.cellIdentifier, for: indexPath) as! ResponseCell
        
        let post = self.responseArray[indexPath.row]
        
        cell.lblTitle.text      = post.title
        cell.lblDate.text       = post.createdOn
        cell.toggleSwitch.isOn  = post.isPostSelected
        cell.backgroundColor    = post.isPostSelected ? UIColor.lightGray : UIColor.white
        
        if indexPath.row == self.responseArray.count - 1 && !self.isPageCompleted {
            pageCount = pageCount + 1
            activityIndicator.startAnimating()
            self.callPostAPI()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = self.responseArray[indexPath.row]
        post.isPostSelected = !post.isPostSelected
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        self.setNavigationTitle()
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if isPageCompleted == true || responseArray.count == 0 {
            return UIView()
        }
        return viewFooter
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if isPageCompleted == true || responseArray.count == 0 {
            return 0.0001
        }
        return 70.0
    }
}

