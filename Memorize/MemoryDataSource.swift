//
//  MemoryDataSource.swift
//  Memorize
//
//  Created by Jair Moreno Gaspar on 4/12/20.
//  Copyright © 2020 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

class MemoryDataSource: NSObject, UITableViewDataSource {
    
    var items = [MemoryItem]()
    
    override init() {
        guard let url = Bundle.main.url(forResource: "Items", withExtension: "json") else {
            fatalError("Can't find json")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Unable to load Json")
        }
        
        let decoder = JSONDecoder()
        
        guard let savedItems = try? decoder.decode([MemoryItem].self, from: data) else {
            fatalError("failed to decode json.")
        }
        
        items = savedItems
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.text
        
        return cell
    }
    
    func item(at index: Int) -> MemoryItem {
        return items[index]
    }
}
