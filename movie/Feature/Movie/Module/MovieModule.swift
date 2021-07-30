//
//  MovieModule.swift
//  movie
//
//  Created by Samsud Dhuha on 29/07/21.
//

import Foundation
import SwiftyJSON
import iOSNFramework

protocol MovieDelegate {
    func getListGenre(language: String)
    func getListMovie(idGenre: String, language: String, page: Int)
    func getVideo(idMovie: Int)
}

class MovieModule: ModuleDelegate, MovieDelegate {
    
    let TAG_GENRE = "TAG-GENRE"
    let TAG_MOVIE = "TAG-MOVIE"
    let TAG_VIDEO_MOVIE = "TAG-VIDEO-MOVIE"

    override init(viewStateDelegate: ViewStateDelegate, controller: UIViewController) {
        super.init(viewStateDelegate: viewStateDelegate, controller: controller)
    }
    
    func getListGenre(language: String) {
        self.network.networkConfiguration(tag: TAG_GENRE)
        self.network.onLoading(isLoading: true, message: "")

        commonService.request(Common.genre(language: language), completion: {result in switch result {
        

        case .success(let response):
            self.network.onLoading(isLoading: false, message: "")
            let data = JSON.init(response.data)

            do {
                _ = try response.filterSuccessfulStatusCodes()
                
                let dataMap = try JSONDecoder().decode([Genre].self, from: data["genres"].rawData())
                self.network.onSucess(data: dataMap, message: data[KEY_MESSAGE].stringValue)

            } catch {
                print(data)
                self.network.onLoading(isLoading: false, message: "")
                self.network.onFailure(data: data[KEY_CODE].stringValue, message: data[KEY_MESSAGE].stringValue)
            }

        case .failure(_):
            self.network.onLoading(isLoading: false, message: "")
            self.network.onFailure(data: "", message: ERROR_MESSAGE)
        }})
    }
    
    func getListMovie(idGenre: String, language: String, page: Int) {
        self.network.networkConfiguration(tag: TAG_MOVIE)
        self.network.onLoading(isLoading: true, message: "")

        commonService.request(Common.movie(genre: idGenre, language: language, page: page), completion: {result in switch result {
        

        case .success(let response):
            self.network.onLoading(isLoading: false, message: "")
            let data = JSON.init(response.data)

            do {
                _ = try response.filterSuccessfulStatusCodes()
                
                let dataMap = try JSONDecoder().decode([Movie].self, from: data["results"].rawData())
                self.network.onSucess(data: dataMap, message: data[KEY_MESSAGE].stringValue)
                
                
            } catch {
                self.network.onLoading(isLoading: false, message: "")
                self.network.onFailure(data: data[KEY_CODE].stringValue, message: data[KEY_MESSAGE].stringValue)
            }

        case .failure(_):
            self.network.onLoading(isLoading: false, message: "")
            self.network.onFailure(data: "", message: ERROR_MESSAGE)
        }})
    }
    
    func getVideo(idMovie: Int) {
        self.network.networkConfiguration(tag: TAG_VIDEO_MOVIE)
        self.network.onLoading(isLoading: true, message: "")

        commonService.request(Common.trailer(id: idMovie), completion: {result in switch result {
        

        case .success(let response):
            self.network.onLoading(isLoading: false, message: "")
            let data = JSON.init(response.data)

            do {
                _ = try response.filterSuccessfulStatusCodes()
                
                let dataMap = try JSONDecoder().decode([ResultVideo].self, from: data["results"].rawData())
                self.network.onSucess(data: dataMap, message: data[KEY_MESSAGE].stringValue)

            } catch {
                print(data)
                self.network.onLoading(isLoading: false, message: "")
                self.network.onFailure(data: data[KEY_CODE].stringValue, message: data[KEY_MESSAGE].stringValue)
            }

        case .failure(_):
            self.network.onLoading(isLoading: false, message: "")
            self.network.onFailure(data: "", message: ERROR_MESSAGE)
        }})
    }
}
