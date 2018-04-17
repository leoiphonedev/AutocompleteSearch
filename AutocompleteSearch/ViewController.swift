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
    @IBOutlet weak var bottomLayoutForTableView: NSLayoutConstraint!
    
    fileprivate var countries: [String] = Array()
    fileprivate var originalCountriesList: [String] = Array()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Auto-Complete Search"
        self.populateCountries()
        self.commonConfig()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //MARK:- Config
    fileprivate func configKeyboardHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    fileprivate func commonConfig() {
        self.configKeyboardHandling()
        self.configTable()
        self.configTextField()
    }
    
    fileprivate func configTable() {
        self.tblCountryList.register(UITableViewCell.self, forCellReuseIdentifier: "country")
        self.tblCountryList.delegate = self
        self.tblCountryList.dataSource = self
    }
    
    fileprivate func configTextField() {
        self.txtSearchBar.placeholder = "Search Country ..."
        self.txtSearchBar.clearButtonMode = .whileEditing
        self.txtSearchBar.delegate = self
        self.txtSearchBar.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)
    }
    
    //MARK:- Keyboard Handling
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo!
        let keyboardHeight =  (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let updatedHeight = keyboardHeight.height
        self.bottomLayoutForTableView.constant = updatedHeight
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        self.bottomLayoutForTableView.constant = 0.0
    }

    //MARK:- UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtSearchBar.resignFirstResponder()
        return true
    }
    
    //MARK:- searchRecords
    fileprivate func populateCountries() {
        self.countries.append("Australia")
        self.countries.append("India")
        self.countries.append("South Africa")
        self.countries.append("Ghana")
        self.countries.append("China")
        self.countries.append("USA")
        self.countries.append("Canada")
        self.countries.append("United Kingdom")
        self.countries.append("Germany")
        self.countries.append("Russia")
        self.countries.append("New ZeaLand")
        self.countries.append("Saudi Arabia")
        self.countries.append("Yemen")
        
        for country in self.countries {
            self.originalCountriesList.append(country)
        }
    }
    
    fileprivate func restoreCountries() {
        for country in self.originalCountriesList {
            self.countries.append(country)
        }
    }
    
    @objc func searchRecords(_ textField: UITextField) {
        self.countries.removeAll()
        let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if text.isEmpty {
            self.restoreCountries()
        } else {
            self.originalCountriesList.forEach({ (country) in
                if let _ = country.lowercased().range(of: text, options: .caseInsensitive, range: nil, locale: nil) {
                    self.countries.append(country)
                }
            })
        }
        self.tblCountryList.reloadData()
    }
    
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "country", for: indexPath)
        cell.textLabel?.text = self.countries[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detVC.countryName = self.countries[indexPath.row]
        self.navigationController?.pushViewController(detVC, animated: true)
    }
}
