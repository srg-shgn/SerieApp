//
//  SerieModel.swift
//  SerieApp
//
//  Created by Serge Sahaguian on 17/12/2016.
//  Copyright © 2016 Serge Sahaguian. All rights reserved.
//

import Foundation

//MARK: - Serie
struct Serie {
    let title, genre, illustration, description: String
    var favorite: Bool = false
}

struct SerieInformation {
    static private var allSerie = [Serie]()
    static var defaults = UserDefaults.standard
    
    static func buildAllSerie(serieArray: [[String:String]]) {// -> [Serie] {
        for item in serieArray {
            if let serieDict = item as? [String:String] {
                let myTitle = serieDict["title"]! as String
                let myGenre = serieDict["genre"]! as String
                let myIllustration = serieDict["illustration"]! as String
                let myDescription = serieDict["description"]! as String
                
                var myFavorite = false
                //on verifie si favorite stocké dans UserDefaults
                if let isFavorite = defaults.object(forKey: myTitle) as? Bool {
                    myFavorite = isFavorite
                }

                let mySerie = Serie(title: myTitle, genre: myGenre, illustration: myIllustration, description: myDescription, favorite: myFavorite)
                allSerie.append(mySerie)
            }
        }
        //return allSerie
    }
    
    static func getAllSerieCount() -> Int {
        return allSerie.count
    }
    
    static func getSerie(indexSerie: Int) -> Serie {
        return allSerie[indexSerie]
    }
    
    static func changeFavorite(indexSerie: Int, newState: Bool) {
        
        allSerie[indexSerie].favorite = newState
        
        let keyName = allSerie[indexSerie].title
        let isFavorite = newState
        //stockage de isFavorite dans UserDefaults
        defaults.set(isFavorite, forKey: keyName)
        
//        if var serie = allSerie[indexSerie] as? Serie {
            //cette méthode ne met pas à jour dans allSerie => POURQUOI ???
//            serie.favorite = newState
//        }
    }
}



