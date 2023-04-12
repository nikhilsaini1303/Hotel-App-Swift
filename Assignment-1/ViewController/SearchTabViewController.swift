//
//  SearchTabViewController.swift
//  Assignment-1
//
//  Created by Nikhil Saini on 11/04/23.
//

import UIKit
import FirebaseAuth
import SkeletonView

class SearchTabViewController: UIViewController {
    
    var HotelList = [Hotel]()
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
         self.view.showAnimatedGradientSkeleton()
     }
     

     
    
     func setUpElements() {
         
         Utilities.styleTextField(locationTextField)
         Utilities.styleFilledButton(searchButton)
         
     }
    
    func fetchData() {
        let place = locationTextField.text
        let fplace = place!.replacingOccurrences(of: " ", with: "%20")
        let url = URL(string: "https://hotels4.p.rapidapi.com/locations/v3/search?q=\(fplace)&locale=en_US&langid=1033&siteid=300000001")
        
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)

        let headers = [
            "X-RapidAPI-Key": "b7f0c098d1msh8000a209160b699p160cb6jsnbff91d2e5955",
            "X-RapidAPI-Host": "hotels4.p.rapidapi.com"
        ]

        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else {
                self.present(Utilities.createAlertController(title: "Error", message: "No such location"), animated: true, completion: nil)
                return
            }
            var newHotelList:Hotels?
            do {
                newHotelList = try JSONDecoder().decode(Hotels.self, from: data)
            }
            catch {
                self.present(Utilities.createAlertController(title: "Error", message: error.localizedDescription), animated: true, completion: nil)
            }
            self.HotelList = newHotelList!.sr
            DispatchQueue.main.async {

                self.myTableView.stopSkeletonAnimation()
                self.myTableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                
                self.myTableView.reloadData()
            }
        })
        dataTask.resume()
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        fetchData()
        locationTextField.text = nil
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "isUserSignedIn")
            self.dismiss(animated: true, completion: nil)
        } catch let err {
            self.present(Utilities.createAlertController(title: "Error", message: err.localizedDescription), animated: true, completion: nil)
        }
        
    }
    
}

extension SearchTabViewController: SkeletonTableViewDataSource, SkeletonTableViewDelegate {
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HotelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath) as! MyTableViewCell
        if HotelList[indexPath.row].regionNames?.fullName != nil {
            cell.fullNameLabel.text = "FullName: \(HotelList[indexPath.row].regionNames!.fullName!)"
        }
        else {
            cell.fullNameLabel.text = "No Name Available"
        }
        if HotelList[indexPath.row].regionNames?.shortName != nil {
            cell.shortNameLabel.text = "ShortName: \(HotelList[indexPath.row].regionNames!.shortName!)"
        }
        else {
            cell.shortNameLabel.text = "No Name Available"
        }
        if HotelList[indexPath.row].regionNames?.displayName != nil {
            cell.displayNameLabel.text = "DisplayName: \(HotelList[indexPath.row].regionNames!.displayName!)"
        }
        else {
            cell.displayNameLabel.text = "No Name Available"
        }
        if HotelList[indexPath.row].regionNames?.primaryDisplayName != nil {
            cell.primaryNameLabel.text = "PrimaryDisplayName: \(HotelList[indexPath.row].regionNames!.primaryDisplayName!)"
        }
        else {
            cell.primaryNameLabel.text = "No Name Available"
        }
        if HotelList[indexPath.row].regionNames?.secondaryDisplayName != nil {
            cell.secondaryNameLabel.text = "SecondaryDisplayName: \(HotelList[indexPath.row].regionNames!.secondaryDisplayName!)"
        }
        else {
            cell.secondaryNameLabel.text = "No Name Available"
        }
        if HotelList[indexPath.row].regionNames?.lastSearchName != nil {
            cell.lastNameLabel.text = "LastSearchName: \(HotelList[indexPath.row].regionNames!.lastSearchName!)"
        }
        else {
            cell.lastNameLabel.text = "No Name Available"
        }
        
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return MyTableViewCell.identifier
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        myTableView.isSkeletonable = true
        myTableView.showAnimatedGradientSkeleton()
    }
    
}
