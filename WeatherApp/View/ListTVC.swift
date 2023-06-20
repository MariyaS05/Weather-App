//
//  ListTVC.swift
//  WeatherApp
//
//  Created by Мария  on 25.04.23.
//

import UIKit
import RealmSwift


class ListTVC: UITableViewController {
    private var realm = try! Realm()
    var citiesArray = [Weather]()
    var filterCityArray = [Weather]()
    var namesCitiesArray : [String] = []
    let newWeather = Weather()
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty : Bool {
        guard let text =  searchController.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    var isFiltering : Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        citiesArray = realm.objects(Weather.self).map({$0})
        if self.citiesArray.isEmpty {
            namesCitiesArray = ["Минск","Брест","Гродно","Витебск","Гомель","Речица"]
            self.citiesArray =  Array(repeating: newWeather, count: namesCitiesArray.count)
            addCities()
        }
        setupSearchController()
    }
    
    @IBAction func pressAddButton(_ sender: Any) {
        presentAlert(name: "Добавить город", placeholder: "Введите название города") {[weak self] city in
            guard let self =  self  else {
                return
            }
            GetCitiesWeather.getCoordinateFrom(city: city) { result in
                switch result {
                case .success :
                    self.namesCitiesArray.append(city.capitalizedSentence)
                    self.citiesArray.append(self.newWeather)
                    self.addCities()
                case .failure(let failure):
                    print(failure)
                    self.presentCustomAlert(with: "Что-то пошло не так", message: "Проверьте название города и введите еще раз.", buttonTitle: "ОК")
                }
            }
        }
    }
    private func setupSearchController(){
        searchController.searchResultsUpdater =  self
        searchController.obscuresBackgroundDuringPresentation =  false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext =  true
        navigationItem.hidesSearchBarWhenScrolling =  false
    }
    
    private func addCities(){
        GetCitiesWeather.getCityWeather(cities: self.namesCitiesArray) {[weak self] index, weather in
            guard let self = self else {
                return
            }
            guard let weather = weather else {
                DispatchQueue.main.async {
                    self.presentCustomAlert(with: "Что-то пошло не так.", message: "Проверьте соединение с интернетом", buttonTitle: "ОК")
                }
                return
            }
            self.citiesArray[index] =  weather
            self.citiesArray[index].name = self.namesCitiesArray[index]
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filterCityArray.count
        }
        return self.citiesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell
        var weather = Weather()
        if isFiltering {
            weather =  filterCityArray[indexPath.row]
        } else {
            weather =  citiesArray[indexPath.row]
        }
        cell.configure(weather: weather)
        return cell
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, completionHandler in
            let editingRow = self.namesCitiesArray[indexPath.row]
            if let index =  self.namesCitiesArray.firstIndex(of: editingRow) {
                if self.isFiltering {
                    self.filterCityArray.remove(at: index)
                }else {
                    self.citiesArray.remove(at: index)
                }
                self.tableView.reloadData()
            }
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // MARK: - navigatin
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath =  tableView.indexPathForSelectedRow else {return}
            if isFiltering {
                let filter =  filterCityArray[indexPath.row]
                let destVC =  segue.destination as! DetailViewController
                destVC.weather =  filter
            } else {
                let cityWeather =  citiesArray[indexPath.row]
                let destVC =  segue.destination as! DetailViewController
                destVC.weather =  cityWeather
            }
        }
    }
}
extension ListTVC : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text =  searchController.searchBar.text else {return}
        filterContentForSearchText(text)
    }
    private func filterContentForSearchText(_ searchText : String){
        filterCityArray =  citiesArray.filter{$0.name.contains(searchText)}
        tableView.reloadData()
    }
}

