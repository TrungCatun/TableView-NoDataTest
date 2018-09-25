//
//  TableViewController.swift
//  TableView-NoDataTest
//
//  Created by Trung on 6/30/18.
//  Copyright © 2018 TrungCatun. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet var noDataView: UIView!
    @IBOutlet weak var fooderTableView: UIView!
    
    var number = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return number.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = String(number[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as? DetailViewController
        if let index = tableView.indexPathForSelectedRow {
            detailViewController?.data = String(number[index.row])
        }
      
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        let detailViewController = unwindSegue.source as? DetailViewController
        if let index = tableView.indexPathForSelectedRow {
            number[index.row] = Int(detailViewController?.data ?? "") ?? 0
        }
        else {
            if detailViewController?.data != nil {
            number.append(Int(detailViewController?.data ?? "") ?? 0)
            }
        }
        tableView.reloadData()
    }
    
    var hasNoData: Bool = false {
        didSet {
            //hasNoData ? (tableView.tableFooterView = noDataView) : (tableView.tableFooterView = fooderTableView)
            if hasNoData {
                tableView.tableFooterView = noDataView
            }
            else {
                tableView.tableFooterView = fooderTableView
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        hasNoData = number.count == 0
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            number.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            hasNoData = number.count == 0
        }
    }
    

}
