//
//  FirstViewController.swift
//  SerieApp
//
//  Created by Serge Sahaguian on 17/12/2016.
//  Copyright © 2016 Serge Sahaguian. All rights reserved.
//

import UIKit

var defaults = UserDefaults.standard

class FirstViewController: UIViewController {
    
    //j'ai crée un IBOutlet de ma TableView pour récupérer l'index de l'item sélectionné
    @IBOutlet weak var serieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJson()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentSerie" {
            if let descriptionVC = segue.destination as? DescriptionViewController {
                descriptionVC.delegate = self
            }
        }
    }
    
    func parseJson() {
        //on récupère l’url du fichier à parser
        let path = Bundle.main.url(forResource: "series", withExtension: "json")
        //on récupère le contenu du fichier en Data
        let jsonData = try? Data(contentsOf: path!)
        //on sérialize la data pour la rendre lisible
        let json = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
        
        if let serieJson = json as? [[String:String]] { //on downcast en [[String:String]]
            SerieInformation.buildAllSerie(serieArray: serieJson)
        }
    }
}

class MyTableDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SerieInformation.getAllSerieCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let serieData = SerieInformation.getSerie(indexSerie: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        cell.setup(with: serieData)
        if serieData.favorite == true {
            cell.backgroundColor = UIColor.yellow
        } else {
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
}

/*
 extension MyTableDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
 */

//On applique la class "CustomCell" à notre cellule custom dans le storyboard
class CustomCell: UITableViewCell {
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var illustration: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func setup(with cellData: Serie) {
        title.text = cellData.title
        genre.text = cellData.genre
        illustration.image = UIImage(named: cellData.illustration)
    }
}

extension FirstViewController: DescriptionViewControllerDelegate {
    func getSelectedSerie(indexSerie:Int) -> Serie {
        return SerieInformation.getSerie(indexSerie: indexSerie)
    }
    
    func getSelectedSerieIndex() -> Int {
        //recupération de l'index de la série selectionnée
        let selectedSerieItem = serieTableView.indexPathForSelectedRow?.row
        //desélection de la cellule pour supprimer le fond gris
        serieTableView.deselectRow(at: serieTableView.indexPathForSelectedRow!, animated: false)
        return selectedSerieItem!
    }
    
    func changeFavorite(indexSerie: Int, favoriteState: Bool) {
        SerieInformation.changeFavorite(indexSerie: indexSerie, newState: favoriteState)
        serieTableView.reloadData()
    }
}





