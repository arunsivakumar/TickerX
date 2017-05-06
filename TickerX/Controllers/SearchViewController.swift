//
//  SearchViewController.swift
//  TickerX
//
//  Created by blackbriar on 4/26/17.
//  Copyright © 2017 com.teressa. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var textFieldLine: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var results = [YQSearchResult]()
//    {
//        didSet {
//            self.tableView.reloadData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        searchTextField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchTextDidChange(_ sender: UITextField) {
        print("DID CHANGED")
        if let text = sender.text, !text.isEmpty {
            startActivity()
            NetworkManager.sharedInstance.searchSymbol(query: text, completion: { (json: JSON?, error: Error?) in
                guard error == nil else {
                    return
                }
                self.results = NetworkParser.sharedInstance.parseSearchResults(json: json!)
                self.tableView.reloadData()
                self.endActivity()
            })

        } else {
            results = []
            DispatchQueue.main.async {
                self.tableView.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }

        
    }
    // MARK UI Setup
    
    fileprivate func startActivity() {
        results.removeAll()
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.activityIndicator.startAnimating()
            //self.messageLabel.text = "Loading..."
        }
    }
    
    fileprivate func endActivity() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.isHidden = false

            //self.messageLabel.text = "Search for company name or symbol."
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell",
                                                 for: indexPath) as! SearchTableViewCell
        let searchResult = results[indexPath.row]
        print("NAME is \(searchResult)")
        cell.nameLabel.text = searchResult.name
        cell.exchangeLabel.text = searchResult.exchange
        cell.symbolLabel.text = searchResult.symbol
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count is \(results.count)")
        return results.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let stock = results[indexPath.row]
        var resultCount = 0
        //check if company is already saved
        let fetchRequest  = Stock.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", stock.name)
        do {
            let result = try context.fetch(fetchRequest)
            resultCount = result.count
        } catch let error as NSError {
            print(error)
        }
        
        if resultCount == 0 {
            
            //save company
            let stockToSave = Stock(name: stock.name, symbol: stock.symbol, exchange: stock.exchange, typeDisplay: stock.typeDisplay)
            //print(companytosave)
            do {
                try context.save()
            } catch let error as NSError{
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
    fileprivate func customizeUI() {
        tableView.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchTextField.resignFirstResponder()
    }

    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
