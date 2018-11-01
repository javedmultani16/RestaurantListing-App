//
//  HomeAppVC.swift
//  App
//
//  Created by Qwesys on 01/11/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import UIKit
import SwiftIcons
class HomeAppVC:  BaseVC,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tblList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.isHidden = false
        self.setNavigationbar(isMenu: true,
                              isBack: false,
                              right_icon_Name: FASolidType.checkSquare,
                              right_String: nil,
                              right_action: #selector(clickOnCheck(sender:)),
                              title:  "Restaurants")
        tblList.delegate = self
        tblList.dataSource = self
        tblList.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     @IBAction func clickOnCheck(sender: Any){
    }
    //MARK: -  UITableView Method
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        var cell : ListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as? ListTableViewCell
        if cell == nil {
            tableView.register(UINib.init(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
            let arrNib : Array = Bundle.main.loadNibNamed("ListTableViewCell", owner: self, options: nil)!
            cell = arrNib.first as? ListTableViewCell
        }

        
        cell?.contentView.backgroundColor = UIColor .clear
        cell?.selectionStyle = .none
        
        return cell!
        
    }
    
  
}
