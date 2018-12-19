//
//  RadioChannelController.swift
//  InternetRadioChannel
//
//  Created by Abhishek Jaykrishna Khapare on 3/29/18.
//  Copyright © 2018 AbhishekJaykrishnaKhapare. All rights reserved.
//

import UIKit
/*
 
 RadioChannelController : 1) This a List controller, this screen displays a list of Intrnet Radio Channels.
                          2) We can filter the list by providing DJ name.
                          3) Go to detail view controller if select any row from the list.
 */
class RadioChannelController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
   
    var radioChannel : RadioChannel?
    var searchRadioChannel = [Channel]()
    
    let radioModel = RadioChannelModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        let urlStringg = "https://raw.githubusercontent.com/jvanaria/jvanaria.github.io/master/channels.json"
        self.title = "Radio Channels"
        fetchRadioChannelData(urlString : urlStringg)
    }
    //fetch the json data from the network and reload the table view
    func fetchRadioChannelData(urlString : String){
        radioModel.fetchRadioData(urlString : urlString){
            (radioChannel) in
            self.radioChannel = radioChannel
            self.searchRadioChannel = (self.radioChannel?.channels)!
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      //  return radioChannel?.channels?.count ?? 0
        return searchRadioChannel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCellId", for: indexPath) as? ChannelCell
            else {
                return UITableViewCell()
        }
        //cell.radioChannel = radioChannel?.channels?[indexPath.row]
        cell.radioChannel = searchRadioChannel[indexPath.row]
        return cell
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "channelSegue"{
        guard let vc = segue.destination as? RadioChannelDetailController else {return}
        let indexPath = tableView.indexPathForSelectedRow
        vc.radioChannel = radioChannel?.channels?[(indexPath?.row)!]
        }
    }
}

extension RadioChannelController :  UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {searchRadioChannel = radioChannel?.channels ?? [Channel]()
            tableView.reloadData()
            return}
        
        guard let channel = radioChannel?.channels else {return}
        searchRadioChannel = channel.filter({ channel -> Bool in
            (channel.dj?.lowercased().contains(searchText.lowercased()))!
        })
        tableView.reloadData()
    }
}
