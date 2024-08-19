//
//  ListVC.swift
//  CoreDataData
//
//  Created by SAIL on 05/08/24.
//

import UIKit

class ListVC: UIViewController  {
    
    @IBOutlet weak var listTableView: UITableView!{
        didSet{
            listTableView.delegate = self
            listTableView.dataSource = self
            listTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        }
    }
    var listData = [Person]()
    let CoreData = CoreDataCRUDFile.Shared
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readListData()
    }
    
    func readListData() {
        CoreData.readData{ [self] profile in
            listData = profile ?? []
            listTableView.reloadData()
        }
        
    }
}

extension ListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        let data = listData[indexPath.row]
        cell.nameLabel.text = data.name
        cell.emailIdLabel.text = data.emailId
        cell.idNoLabel.text = "\(data.id)"
        cell.createAtLabel.text = "\(data.createdAt ?? Date())"
        
       return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlert(title: "Alert", message: "Choose the format", actionTitles: ["Update", "Delete", "Cancel"],actionStyles: [.default, .destructive, .cancel], handlers: [
            { action in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateProfileVc") as! CreateProfileVc
                let data = self.listData[indexPath.row]
                vc.updateData = data
                vc.updateTime = true
                self.navigationController?.pushViewController(vc, animated: true)
            },
            { action in
                
                let data = self.listData[indexPath.row]
                self.CoreData.DeleteData(data, handler: {result in
                    DispatchQueue.main.async { [self] in
                        do {
                            if (result!){
                                readListData()
                            }
                            else {
                            }
                        }
                    }
                })
            },
            { action in
                
            }
        ])
        
    }
}
