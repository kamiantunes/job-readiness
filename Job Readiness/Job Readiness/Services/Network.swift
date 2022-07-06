//
//  Network.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 04/07/22.
//

import Alamofire

final class Network {
    enum urlAPI : String {
        case predictor = "https://api.mercadolibre.com/sites/MLB/domain_discovery/search?limit=1&q="
        case categorie = "https://api.mercadolibre.com/highlights/MLB/category/"
        case idItems = "https://api.mercadolibre.com/items?ids="
        case item = "https://api.mercadolibre.com/items/"
        case descriptionParameter = "/description"
        case token = "APP_USR-3215827880957566-070610-e7f031dc4f1fcbb680d269bdf164affe-734158173"
    }
    
    private let headers: HTTPHeaders = [.authorization(bearerToken: urlAPI.token.rawValue)]
    
    func getItems(using items: String, completion: @escaping ([Items]) -> Void) {
        let url = urlAPI.idItems.rawValue + items
        
        AF.request(url, headers: headers)
            .responseDecodable(of: [Items].self) { data in
                print("\n---- LOG: Requisição de ITENS iniciada")
                
                switch data.result {
                case .success(let response):
                    print("---- LOG: Requisição de ITENS concluída com sucesso")
                    completion(response)
                case .failure(let error):
                    print("---- LOG: Requisição de ITENS falhou")
                    print("---- LOG: Erro apresentado - " + error.localizedDescription)
                    completion([])
                }
            }
    }
    
    func getCategory(using categorieSearch: String, completion: @escaping ([Category]) -> Void) {
        let url = urlAPI.predictor.rawValue + categorieSearch
        
        AF.request(url, headers: headers)
            .responseDecodable(of: [Category].self) { data in
                print("\n---- LOG: Requisição de CATEGORIA iniciada")
                
                switch data.result {
                case .success(let response):
                    print("---- LOG: Requisição de CATEGORIA concluída com sucesso")
                    completion(response)
                case .failure(let error):
                    print("---- LOG: Requisição de CATEGORIA falhou")
                    print("---- LOG: Erro apresentado - " + error.localizedDescription)
                    completion([])
                }
            }
    }
    
    func getItemsFrom(_ categoryId: String, completion: @escaping (ListIdItem?) -> Void) {
        let url = urlAPI.categorie.rawValue + categoryId
        
        AF.request(url, headers: headers)
            .responseDecodable(of: ListIdItem.self) { data in
                print("\n---- LOG: Requisição de TOP 20 ITENS iniciada")
                
                switch data.result {
                case .success(let response):
                    print("---- LOG: Requisição de TOP 20 ITENS concluída com sucesso")
                    completion(response)
                case .failure(let error):
                    print("---- LOG: Requisição de TOP 20 ITENS falhou")
                    print("---- LOG: Erro apresentado - " + error.localizedDescription)
                    completion(nil)
                }
            }
    }
    
    func getDescription(using itemId: String, completion: @escaping (Description?) -> Void) {
        let url = urlAPI.item.rawValue + itemId + urlAPI.descriptionParameter.rawValue
        
        AF.request(url, headers: headers)
            .responseDecodable(of: Description.self) { data in
                print("\n---- LOG: Requisição de DESCRIÇÃO iniciada")
                
                switch data.result {
                case .success(let response):
                    print("---- LOG: Requisição de DESCRIÇÃO concluída com sucesso")
                    completion(response)
                case .failure(let error):
                    print("---- LOG: Requisição de DESCRIÇÃO falhou")
                    print("---- LOG: Erro apresentado - " + error.localizedDescription)
                    completion(nil)
                }
            }
    }
}
