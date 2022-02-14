//
//  networkingProvider.swift
//  gestorEmpleados_sergio
//
//  Created by APPS2M on 25/1/22.
//

import Foundation
import UIKit
import Alamofire

final class NetworkingProvider{
    static let shared = NetworkingProvider()
    private let apiUrl = "http://localhost/tarea2/public/api/" // Url api
    private let status = 200...299
    
    /*
     Función para hacer login PUT
     */
    func login(user: userLogin, success: @escaping (_ user: User?) -> (), failure: @escaping (_ error:Error?) -> ())
    {
        let url = "http://localhost/tarea2/public/api/login"
        
        AF.request(url, method: .put, parameters: user, encoder: JSONParameterEncoder.default).validate(statusCode: status).responseDecodable(of: Response.self) {
            response in
            
            if let data = response.value?.data{
                print(data)
                success(data)
            }
            
            if let error = response.error {
                failure(error)
            }
        }
        
    }
    
    /*
     Función para registrarse PUT
     */
    func addUser(user: AddUser, api_token:String, success: @escaping (_ msg: User?) -> (), failure: @escaping (_ error:Error?) -> ())
    {
        let url = "http://localhost/tarea2/public/api/create?api_token=\(api_token)"
        
        AF.request(url, method: .put, parameters: user, encoder: JSONParameterEncoder.default).validate(statusCode: status).responseDecodable(of: Response.self) {
            response in
            
            if let data = response.value?.data {
                success(data)
            }
            
            if let error = response.error {
                failure(error)
            }
        }
    }
    
    /*
     Función para recuperar la contraseña POST
     */
    func recoveryPass(email: String, success: @escaping (_ user: User?) -> (), failure: @escaping (_ error:Error?) -> ())
    {
        let url = "http://localhost/tarea2/public/api/password?email=\(email)"
        AF.request(url, method: .post).validate(statusCode: status).responseDecodable(of: Response.self) {
            response in
            
            if let data = response.value?.data{
                success(data)
            }
            if let error = response.error {
                failure(error)
            }
        }
        
    }
    
    /*
     Función para listar empleados GET
     */
    func listEmployees(success: @escaping (_ data: [User]?, _ status: Int?)->(), failure: @escaping (_ error:Error?) ->()){
        
        let api_token = UserDefaults.standard.string(forKey: "token")
        let url = "http://localhost/tarea2/public/api/list?api_token=\(api_token!)"
        
        AF.request(url, method: .get) .validate(statusCode: status).responseDecodable(of:ListResponse.self){
            response in
            
            if let data = response.value?.data, let statusCode = response.value?.status{
                success(data, statusCode)
            }
            
            if let error = response.error{
                failure(error)
            }
        }
    }
    
    func detailsEmployee(id: Int, success: @escaping (_ data: User?, _ status: Int?) -> (), failure: @escaping (_ error:Error?) ->()){
        
        let api_token = UserDefaults.standard.string(forKey: "token")
        let url = "http://localhost/tarea2/public/api/detail?api_token=\(api_token!)&id=\(id)"
        
        AF.request(url, method: .get).validate(statusCode: status).responseDecodable(of: Response.self, decoder: DateDecoder()) {
            response in
            
            if let data = response.value?.data, let statusCode = response.value?.status {
                success(data, statusCode)
            }
            
            if let error = response.error {
                failure(error)
            }
        }
    }
    
    /*
     Función para consultar el perfil del empleado GET
     */
    func employeeProfile(success: @escaping (_ data: User?, _ status: Int?) -> (), failure: @escaping (_ error:Error?) ->()){
        
        let api_token = UserDefaults.standard.string(forKey: "token")
        let url = "http://localhost/tarea2/public/api/profile?api_token=\(api_token!)"
                
      
        AF.request(url, method: .get).validate(statusCode: status).responseDecodable(of: Response.self, decoder: DateDecoder()) {
            response in

            if let data = response.value?.data, let statusCode = response.value?.status {
                success(data, statusCode)
            }

            if let error = response.error {
                failure(error)
            }
        }
    }
    
    
    
    
}
