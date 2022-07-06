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
        case idItems = "https://api.mercadolibre.com/items?ids="
        case item = "https://api.mercadolibre.com/items/"
        case descriptionParameter = "/description"
        case token = "APP_USR-3215827880957566-070516-cd3e8a889cbebad3aac5b91d112b8101-734158173"
    }
    
    private let headers: HTTPHeaders = [.authorization(bearerToken: urlAPI.token.rawValue)]
    
    func getItems(using items: String, completion: @escaping ([Items]) -> Void) {
        let url = urlAPI.idItems.rawValue + items
        
        AF.request(url, headers: headers)
            .responseDecodable(of: [Items].self) { data in
                switch data.result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    print(error)
                    completion([])
                }
            }
    }
    
    func getCategory(using categorieSearch: String, completion: @escaping ([Category]) -> Void) {
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
    
    func getItemsFrom(_ categoryId: String, completion: @escaping (ListIdItem?) -> Void) {
        let url = urlAPI.categorie.rawValue + categoryId
        
        AF.request(url, headers: headers)
            .responseDecodable(of: ListIdItem.self) { data in
                switch data.result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    print(error)
                    completion(nil)
                }
            }
    }
    
    func getDescription(using itemId: String, completion: @escaping (Description?) -> Void) {
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
