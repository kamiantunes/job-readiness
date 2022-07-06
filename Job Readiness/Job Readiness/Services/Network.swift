//
//  Network.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 04/07/22.
//

import Alamofire

//MLB2146288737

final class Network {
    
    enum urlAPI : String {
        case predictor = "https://api.mercadolibre.com/sites/MLB/domain_discovery/search?limit=1&q="
        case categorie = "https://api.mercadolibre.com/highlights/MLB/category/"
        case items = "https://api.mercadolibre.com/items?ids="
        case item = "https://api.mercadolibre.com/items/"
        case descriptionParameter = "/description"
    }
    
    private let headers: HTTPHeaders = [.authorization(bearerToken: "APP_USR-3215827880957566-070516-cd3e8a889cbebad3aac5b91d112b8101-734158173")]
    
//    func makeRequisition(url: String) {}
    
    func getItems(items: String, completion: @escaping ([Response]) -> Void) {
        let url = urlAPI.items.rawValue + items
        
        AF.request(url, headers: headers)
            .responseDecodable(of: [Response].self) { data in
                switch data.result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    print(error)
                    completion([])
                }
            }
    }
    
    func getCategory(categorieSearch: String, completion: @escaping ([Category]) -> Void) {
        let url = urlAPI.predictor.rawValue + categorieSearch
        
        AF.request(url, headers: headers)
            .responseDecodable(of: [Category].self) { data in
                switch data.result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    print(error)
                    completion([])
                }
            }
    }
    
    func getItemsFrom(_ categoryId: String, completion: @escaping (ItemIdResponse?) -> Void) {
        let url = urlAPI.categorie.rawValue + categoryId
        
        AF.request(url, headers: headers)
            .responseDecodable(of: ItemIdResponse.self) { data in
                switch data.result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    print(error)
                    completion(nil)
                }
            }
    }
    
    func getDescription(_ itemId: String, completion: @escaping (Description?) -> Void) {
        let url = urlAPI.item.rawValue + itemId + urlAPI.descriptionParameter.rawValue
        
        AF.request(url, headers: headers)
            .responseDecodable(of: Description.self) { data in
                switch data.result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    print(error)
                    completion(nil)
                }
            }
    }
}
