//
//  HomeViewController.swift
//  TickerX
//
//  Created by blackbriar on 4/26/17.
//  Copyright © 2017 com.teressa. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var addStockButton: UIButton!
    @IBOutlet weak var stockTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let group = DispatchGroup()
    var YQStocks = [YQStockResult]() {
        didSet {
//            self.stockTableView.reloadData()
        }
    }
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Stock> = {
        
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // Create Fetch Request
        let fetchRequest = Stock.afetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.loadStockData), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
        self.loadStockData()
        self.stockTableView.delegate = self
        self.stockTableView.dataSource = self
        self.stockTableView.addSubview(refreshControl)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.fetchData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reloadButtonTapped(_ sender: UIButton) {
    }

    @IBAction func addStockButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSearch", sender: self)
    }
    
    @IBAction func addStock(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "toSearch", sender: self)
    }
    
    // MARK UI Setup
    
    
    
    func loadStockData() {
        YQStocks.removeAll()
        for stock in fetchedResultsController.fetchedObjects! {
            group.enter()
            NetworkManager.sharedInstance.getStocksForSymbol(symbol: stock.symbol, completion: { (json: JSON?, error: Error?) in
                guard error == nil else {
                    return
                }
                let YQStock = NetworkParser.sharedInstance.parseStockResult(json: json!)
                self.YQStocks.append(YQStock)
                self.group.leave()
            })
        }
        group.notify(queue: .main) { 
            self.stockTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
        print("calling reload")



    }
    
    // MARK: - Navigation

 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stockDetail" {
            if let destination = segue.destination as? StockDetailViewController {
                if let indexPath = stockTableView.indexPathForSelectedRow {
                    stockTableView.deselectRow(at: indexPath, animated: true)
                    destination.selectedStock = YQStocks[indexPath.row]
                }
            }
        }
    }
    
    // MARK - TableView Delegate + DataSource
    
    
    func fetchData() {
        do {
            try self.fetchedResultsController.performFetch()
            //print("Fetched")
            stockTableView.reloadData()
        } catch let e {
            print("Error while trying to perform a search: \n\(e)\n\(self.fetchedResultsController)")
        }
        
    }
    
    // MARK: TableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sectionInfo = self.fetchedResultsController.sections?[section] {
            return sectionInfo.numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("in cell FOR ROW")
        let stock = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell") as! StockTableViewCell
        if !YQStocks.isEmpty {
            print("not empty price is")
            print(YQStocks.count)
            guard indexPath.row < YQStocks.count else {
                return UITableViewCell()
            }
            cell.stock = YQStocks[indexPath.row]
            cell.configureCell()
        }
//        cell?.textLabel?.adjustsFontSizeToFitWidth = true
//        
//        cell?.backgroundColor = UIColor(red:0.7, green:1.0, blue:1.0, alpha:1.0)
//        cell?.layer.borderColor = UIColor(red:0.1, green:0.55, blue:1.0, alpha:1.0).cgColor
//        cell?.layer.borderWidth = 1.5
//        cell?.layer.cornerRadius = 5
//        cell?.clipsToBounds = true
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let stockToRemove = fetchedResultsController.object(at: indexPath)
            context.delete(stockToRemove)
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save: \(error)")
            }
        }
    }
    


}

extension HomeViewController: NSFetchedResultsControllerDelegate{
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        stockTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type) {
            
        case .insert:
            stockTableView.insertRows(at: [newIndexPath! as IndexPath], with: .fade)
        case .delete:
            stockTableView.deleteRows(at: [indexPath! as IndexPath], with: .fade)
        case .update:
            stockTableView.reloadRows(at: [indexPath! as IndexPath], with: .fade)
        case .move:
            stockTableView.deleteRows(at: [indexPath! as IndexPath], with: .fade)
            stockTableView.insertRows(at: [newIndexPath! as IndexPath], with: .fade)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        stockTableView.endUpdates()
    }
    
}

