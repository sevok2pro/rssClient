//
//  NoteListTableViewController.swift
//  rssReader
//
//  Created by Vsevolod Liberov on 11/02/2019.
//  Copyright © 2019 Seva. All rights reserved.
//

import UIKit
import RxSwift

class NewsTableViewController: UITableViewController {
    var notes: Array<RssNews> = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _ = newsStorage
            .observeNotes()
            .subscribe(onNext: {next in
                self.notes = next;
                self.tableView.reloadData();
            })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

    func tap(link: String) -> () -> Void {
        func nestedTap() {
            self.performSegue(withIdentifier: "showFullNewsSeque", sender: link)
        }
        
        return nestedTap
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteListTableViewCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("can not view this cell type")
        }
        let news: RssNews = notes[indexPath.row];
        cell.newsTitle.text = news.title;
        cell.newsShortDescription.text = news.description;
        cell.onTapHandler = tap(link: news.link)
        URLSession.shared
            .dataTask(
                with: URL(string: news.imageLink)!,
                completionHandler: {data,response,error  in
                    if (error != nil){
                        fatalError("image load broken!")
                    }
                    DispatchQueue.main.async() {
                        cell.newsImage.image = UIImage(data: data!)
                    }
                }
            )
            .resume()
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let message: String = sender as! String;
        let destinationViewController: FullNewsViewController = segue.destination as! FullNewsViewController;
        destinationViewController.newsLink = message
    }
 

}
