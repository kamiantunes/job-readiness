//
//  Network.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 04/07/22.
//

import Alamofire

final class Network {
    private let pathBase = "https://api.mercadolibre.com/"
    
    enum Parameter : String {
        case predictor = "sites/MLB/domain_discovery/search?limit=1&q="
        case categorie = "highlights/MLB/category/"
        case idItems = "items?ids="
        case item = "items/"
        case descriptionParameter = "/description"
    }
    
    enum Requisitions: String {
        case items = "ITENS"
        case category = "CATEGORIA"
        case topItems = "TOP 2O ITENS"
        case description = "DESCRIÇÃO"
    }
    
    private let headers: HTTPHeaders = {
        let token = "APP_USR-3215827880957566-070610-e7f031dc4f1fcbb680d269bdf164affe-734158173"
        
        return [.authorization(bearerToken: token)]
    }()
    
    func getItems(using items: String, completion: @escaping ([Items]) -> Void) {
        let url = pathBase + Parameter.idItems.rawValue + items
        let requisition = Requisitions.items.rawValue
        
        AF.request(url, headers: headers)
            .responseDecodable(of: [Items].self) { data in
                self.logInit(for: requisition)
                
                switch data.result {
                case .success(let response):
                    self.logSuccess(for: requisition)
                    completion(response)
                case .failure(let error):
                    self.logError(for: requisition, with: error)
                    completion([])
                }
            }
    }
    
    func getCategory(using categorieSearch: String, completion: @escaping ([Category]) -> Void) {
        let url = pathBase + Parameter.predictor.rawValue + categorieSearch
        let requisition = Requisitions.category.rawValue
        
        AF.request(url, headers: headers)
            .responseDecodable(of: [Category].self) { data in
                self.logInit(for: requisition)
                
                switch data.result {
                case .success(let response):
                    self.logSuccess(for: requisition)
                    completion(response)
                case .failure(let error):
                    self.logError(for: requisition, with: error)
                    completion([])
                }
            }
    }
    
    func getItemsFrom(_ categoryId: String, completion: @escaping (ListIdItem?) -> Void) {
        let url = pathBase + Parameter.categorie.rawValue + categoryId
        let requisition = Requisitions.topItems.rawValue
        
        AF.request(url, headers: headers)
            .responseDecodable(of: ListIdItem.self) { data in
                self.logInit(for: requisition)
                
                switch data.result {
                case .success(let response):
                    self.logSuccess(for: requisition)
                    completion(response)
                case .failure(let error):
                    self.logError(for: requisition, with: error)
                    completion(nil)
                }
            }
    }
    
    func getDescription(using itemId: String, completion: @escaping (Description?) -> Void) {
        let url = pathBase + Parameter.item.rawValue + itemId + Parameter.descriptionParameter.rawValue
        let requisition = Requisitions.description.rawValue
        
        AF.request(url, headers: headers)
            .responseDecodable(of: Description.self) { data in
                self.logInit(for: requisition)
                
                switch data.result {
                case .success(let response):
                    self.logSuccess(for: requisition)
                    completion(response)
                case .failure(let error):
                    self.logError(for: requisition, with: error)
                    completion(nil)
                }
            }
    }
    
    private func logInit(for requisition: String) {
        print("\n---- LOG: Requisição de " + requisition + "iniciada")
    }
    
    private func logSuccess(for requisition: String) {
        print("\n---- LOG: Requisição de " + requisition + "concluída com sucesso")
    }
    
    private func logError(for requisition: String, with error: AFError) {
        print("\n---- LOG: Requisição de " + requisition + "falhou")
        print("---- LOG: Erro apresentado - " + error.localizedDescription)
    }
}
