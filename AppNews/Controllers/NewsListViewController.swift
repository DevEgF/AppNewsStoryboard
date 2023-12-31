//
//  NewsListViewController.swift
//  AppNews
//
//  Created by Egito Filho on 21/12/23.
//

import UIKit

class NewsListViewController: UIViewController {
    
    @IBOutlet weak var newsListTableView: UITableView!
    
    var localDataProvider: NewsListDataProvider?
    
    private var newsList: [NewsModel]? {
        didSet {
            self.newsListTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.initLocalDataProvider()
    }
    
    private func initLocalDataProvider () {
        self.localDataProvider = NewsListDataProvider()
        self.localDataProvider?.delegate = self
        self.localDataProvider?.getNewsList()
    }
    
    private func setupTableView() {
        self.newsListTableView.delegate = self
        self.newsListTableView.dataSource = self
        self.newsListTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
    }
}

///extensions

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
    }
}

extension NewsListViewController: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.newsList?.count ?? 0
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
             fatalError("Unable to dequeue subclassed cell")
         }
         
         guard let newsList = newsList else {
             fatalError("Unable news")
         }
         
         cell.news = newsList[indexPath.row]
         return cell
     }
}

extension NewsListViewController: NewsListDataProviderProtocol {
    func success(model: Any) {
        self.newsList = model as? [NewsModel]
    }
    
    func errorData(_ provider: GenericDataProvider?, error: Error) {
        print("\(error.localizedDescription)")
    }
}
