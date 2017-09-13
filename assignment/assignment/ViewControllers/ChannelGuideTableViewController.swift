//
//  ChannelGuideTableViewController.swift
//  assignment
//
//  Created by Hien Nguyen on 9/9/17.
//  Copyright © 2017 Misfit. All rights reserved.
//

import UIKit
import BoltsSwift

class ChannelGuideTableViewController: UITableViewController {

    private var channels:[Channel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if channels.count == 0 {
            self.fetchChannels()
                .continueWith(continuation: { task in
                    self.channels = task.result!
                    self.tableView.reloadData()
                })
                .continueOnErrorWith(continuation: { (error:Error) in
                    print("\(error): ")
                })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.channels.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "channelTableCellIdentifier", for: indexPath)
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension ChannelGuideTableViewController {
    func fetchChannels() -> Task<[Channel]> {
        let taskCompletionSource = TaskCompletionSource<[Channel]>()

        ChannelAPI.instance.getAll { (channels, error) in
            if (error != nil) {
                taskCompletionSource.set(error: error!)
            } else {
                taskCompletionSource.set(result: channels)
            }
        }
        return taskCompletionSource.task
    }
}
