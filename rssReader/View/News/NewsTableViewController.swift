//
//  NoteListTableViewController.swift
//  rssReader
//
//  Created by Vsevolod Liberov on 11/02/2019.
//  Copyright © 2019 Seva. All rights reserved.
//

import UIKit
import RxSwift

class NewsTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let filters = ["Все новости", "Избранные новости"];
    var news: Array<RssNews> = [];
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.filters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.filters[row]
    }
    
    @IBOutlet weak var newsFilter: UIBarButtonItem!
    
    @IBAction func onTapFilter(_ sender: UIBarButtonItem) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
        pickerView.delegate = self;
        pickerView.dataSource = self;
        vc.view.addSubview(pickerView)
        let editRadiusAlert = UIAlertController(
            title: "Сменить фильтр",
            message: "",
            preferredStyle: UIAlertController.Style.alert
        )
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(
            title: "Выбрать",
            style: .default,
            handler: {(action: UIAlertAction) in
                self.newsFilter.title = self.filters[pickerView.selectedRow(inComponent: 0)]
            })
        )
        editRadiusAlert.addAction(UIAlertAction(
            title: "Отмена",
            style: .cancel,
            handler: nil)
        )
        self.present(editRadiusAlert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _ = newsStorage
            .observeNotes()
            .subscribe(onNext: {next in
                self.news = next;
                self.tableView.reloadData();
            })
        
        newsFilter.title = self.filters[0];
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
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
        let news: RssNews = self.news[indexPath.row];
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? FullNewsViewController {
            let message: String = sender as! String;
            nextViewController.newsLink = message;
        }
    }
}
