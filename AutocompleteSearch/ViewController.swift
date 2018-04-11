//
//  ViewController.swift
//  AutocompleteSearch
//
//  Created by Aman Aggarwal on 11/04/18.
//  Copyright © 2018 Aman Aggarwal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var txtSearchBar: UITextField!
    @IBOutlet weak var tblCountryList: UITableView!
    
    var countries:[String] = Array()
    var originalCountriesList:[String] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Auto-Complete Search"
        countries.append("Australia")
        countries.append("India")
        countries.append("South Africa")
        countries.append("Ghana")
        countries.append("China")
        countries.append("USA")
        countries.append("Canada")
        countries.append("United Kingdom")
        countries.append("Germany")
        countries.append("Russia")
        countries.append("New ZeaLand")
        countries.append("Saudi Arabia")
        countries.append("Yemen")
        
        for country in countries {
            originalCountriesList.append(country)
        }

        tblCountryList.delegate = self
        tblCountryList.dataSource = self
        txtSearchBar.delegate = self
        txtSearchBar.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)
    }
    
    //MARK:- UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtSearchBar.resignFirstResponder()
        return true
    }
    //MARK:- searchRecords
    @objc func searchRecords(_ textField: UITextField) {
        self.countries.removeAll()
        if textField.text?.count != 0 {
            for country in originalCountriesList {
                if let countryToSearch = textField.text{
                    let range = country.lowercased().range(of: countryToSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.countries.append(country)
                    }
                }
            }
        } else {
            for country in originalCountriesList {
                countries.append(country)
            }
        }
        
        tblCountryList.reloadData()
    }

    
    //MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "country")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "country")
        }
        cell?.textLabel?.text = countries[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detVC.strCountyName = countries[indexPath.row]
        self.navigationController?.pushViewController(detVC, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

