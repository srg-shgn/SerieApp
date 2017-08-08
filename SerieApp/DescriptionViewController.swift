//
//  DescriptionViewController.swift
//  SerieApp
//
//  Created by Serge Sahaguian on 17/12/2016.
//  Copyright © 2016 Serge Sahaguian. All rights reserved.
//

import UIKit

protocol DescriptionViewControllerDelegate {
    func getSelectedSerie(indexSerie: Int) -> Serie
    func getSelectedSerieIndex() -> Int
    func changeFavorite(indexSerie: Int, favoriteState: Bool)
}

class DescriptionViewController: UIViewController {
    
    var delegate: DescriptionViewControllerDelegate?
    var indexSerieSelected: Int? = 0
    
    @IBOutlet weak var imageSerie: UIImageView!
    @IBOutlet weak var titreSerie: UILabel!
    @IBOutlet weak var descriptionSerie: UITextView!
    
    @IBOutlet weak var favoriteBtn: UIButton!
    
    @IBAction func favoriteBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.changeFavorite(indexSerie: indexSerieSelected!, favoriteState: sender.isSelected)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexSerieSelected = delegate?.getSelectedSerieIndex()
        if let serie = delegate?.getSelectedSerie(indexSerie: indexSerieSelected!) {
            
            titreSerie.text = serie.title
            descriptionSerie.text = serie.description
            imageSerie.image = UIImage(named: serie.illustration)
            favoriteBtn.isSelected = serie.favorite
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
