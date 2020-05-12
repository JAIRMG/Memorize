//
//  ViewController.swift
//  Memorize
//
//  Created by Jair Moreno Gaspar on 4/12/20.
//  Copyright © 2020 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let dataSource = MemoryDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        view.backgroundColor = .white
    }

    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "MemoryViewController") as? MemoryViewController else {
            fatalError("Unable to instantiate memory view controller")
        }
        let item = dataSource.item(at: indexPath.row)
        vc.item = item
        navigationController?.pushViewController(vc, animated: true)
    }

}

