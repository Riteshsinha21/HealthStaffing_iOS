import Alamofire
import SwiftyJSON

var appLoginToken : String?

public struct ERNetworkManagerResponse {    /// The server's response to the URL request
    public let responseDict: NSDictionary?
    /// The error encountered while executing or validating the request.
    public let message: String?
    
    /// Status of the request.
    public let success: Bool?
    var _metrics: AnyObject?
    init(response: NSDictionary?, status: Bool?,error: String?) {
        
        self.message = error
        self.responseDict = response
        self.success = status
    }
}

class ServerClass: NSObject {
    var arrRes = [[String:AnyObject]]()
    class var sharedInstance:ServerClass {
        struct Singleton {
            static let instance = ServerClass()
        }
        return Singleton.instance
    }
    

    
    private static var Manager: Session = {

        // Change "chawtechsolutions.ch" for Staging url
        let manager = ServerTrustManager(evaluators: ["identity.prod.ltytech.ch": DisabledTrustEvaluator()])
        
        let configuration = URLSessionConfiguration.af.default
        return Session(configuration: configuration, serverTrustManager: manager)
    }()

/*
    func postRequestWithUrlParameters(_ sendJson:[String:Any], path:String, successBlock:@escaping (_ response: JSON )->Void , errorBlock: @escaping (_ error: NSError) -> Void ){

        
        ServerClass.Manager.request(path, method: .post, parameters: sendJson, encoding: JSONEncoding.default).responseJSON { (response) in
            if response.response?.statusCode == 401 {
//               self.logOutUser()
            }
            switch response.result {
            case .success(let value):
                // print(String(data: value as! Data, encoding: .utf8)!)
                successBlock(JSON(value ))
            case .failure(let error):
                errorBlock(error as NSError)
            }
        }
    }
 */
    
    func sendMultipartRequestToServer(urlString:String,fileName:String,  sendJson:[String:Any], imageUrl:URL?, successBlock:@escaping (  _ response: JSON)->Void , errorBlock: @escaping ( _ error: NSError) -> Void )
    {
      //  let token = kUserDefaults.object(forKey: "token") as! String
       // var headerField : HTTPHeaders = ["Access-Token":token]

        AF.upload(multipartFormData: { multipartFormData in
            for (key,value) in sendJson {
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
                else
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                
            }
            if let url = imageUrl
            {
                multipartFormData.append(url, withName: fileName)
            }
       // },to: urlString, method: .post, headers : headerField)
        },to: urlString, method: .post)
        .response {  response in
            
            print(response)
            if response.response?.statusCode == 403 {
                //self.manageSession()
            }
            switch response.result {


            case .success(let value):
                // print(String(data: value as! Data, encoding: .utf8)!)
                successBlock(JSON(value ))

            case .failure( let error):
                errorBlock(error as NSError)
                print("ERROR RESPONSE: \(error)")
            }
        }
        
    }
    
    func sendSignatureMultipartRequestToServer(urlString:String,fileName:String, signatureName:String, sendJson:[String:Any], imageUrl:URL?, signatureUrl:URL? ,  successBlock:@escaping (  _ response: JSON)->Void , errorBlock: @escaping ( _ error: NSError) -> Void )
    {
      //  let token = kUserDefaults.object(forKey: "token") as! String
       // var headerField : HTTPHeaders = ["Access-Token":token]

        AF.upload(multipartFormData: { multipartFormData in
            for (key,value) in sendJson {
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
                else
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                
            }
            if let url = imageUrl
            {
                multipartFormData.append(url, withName: fileName)
            }
            if let signUrl = signatureUrl
            {
                multipartFormData.append(signUrl, withName: signatureName)
            }
       // },to: urlString, method: .post, headers : headerField)
        },to: urlString, method: .post)
        .response {  response in
            
            print(response)
            if response.response?.statusCode == 403 {
                //self.manageSession()
            }
            switch response.result {

            case .success(let value):
                // print(String(data: value as! Data, encoding: .utf8)!)
                successBlock(JSON(value ))

            case .failure( let error):
                errorBlock(error as NSError)
                print("ERROR RESPONSE: \(error)")
            }
        }
        
    }
    
    func sendSignatureMultipartRequestToServerInOrderedWay(urlString:String,fileName:String, signatureName:String, sendJson:OrderedDictionary<String, Any>, imageUrl:URL?, signatureUrl:URL? ,  successBlock:@escaping (  _ response: JSON)->Void , errorBlock: @escaping ( _ error: NSError) -> Void )
    {
      //  let token = kUserDefaults.object(forKey: "token") as! String
       // var headerField : HTTPHeaders = ["Access-Token":token]

        AF.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in sendJson.getOrderedKeys().compactMap({ key in
                return (key: key, value: sendJson.getValue(forKey: key)!)
            }) {
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
                else
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                
            }
            
//                print("Key:", key, "Value:", value)
//                let keyObj = key + "[]"
//                if let string = key as? String {
//                    multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
//                }
//            }
            
            
//            for (key,value) in sendJson {
//                if let temp = value as? NSArray {
//                    temp.forEach({ element in
//                        let keyObj = key + "[]"
//                        if let string = element as? String {
//                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
//                        }
//                    })
//                }
//                else
//                if let temp = value as? String {
//                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
//                }
//
//            }
            if let url = imageUrl
            {
                multipartFormData.append(url, withName: fileName)
            }
            if let signUrl = signatureUrl
            {
                multipartFormData.append(signUrl, withName: signatureName)
            }
       // },to: urlString, method: .post, headers : headerField)
        },to: urlString, method: .post)
        .response {  response in
            
            print(response)
            if response.response?.statusCode == 403 {
                //self.manageSession()
            }
            switch response.result {
            case .success(let value):
                // print(String(data: value as! Data, encoding: .utf8)!)
                successBlock(JSON(value ))

            case .failure( let error):
                errorBlock(error as NSError)
                print("ERROR RESPONSE: \(error)")
            }
        }
        
    }
    
    
//    Function for FacilityForm
    
    func sendFacilityFormSignatureMultipartRequestToServerInOrderedWay(urlString:String,fileName:String,  sendJson:OrderedDictionary<String, Any>, imageUrl:URL?, successBlock:@escaping (  _ response: JSON)->Void , errorBlock: @escaping ( _ error: NSError) -> Void )
    {
      //  let token = kUserDefaults.object(forKey: "token") as! String
       // var headerField : HTTPHeaders = ["Access-Token":token]

        AF.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in sendJson.getOrderedKeys().compactMap({ key in
                return (key: key, value: sendJson.getValue(forKey: key)!)
            }) {
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
                else
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                
            }
                
//                print("Key:", key, "Value:", value)
//                let keyObj = key + "[]"
//                if let string = key as? String {
//                    multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
//                }
//            }
            
            
//            for (key,value) in sendJson {
//                if let temp = value as? NSArray {
//                    temp.forEach({ element in
//                        let keyObj = key + "[]"
//                        if let string = element as? String {
//                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
//                        }
//                    })
//                }
//                else
//                if let temp = value as? String {
//                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
//                }
//
//            }
            if let url = imageUrl
            {
                multipartFormData.append(url, withName: fileName)
            }
//            if let signUrl = signatureUrl
//            {
//                multipartFormData.append(signUrl, withName: signatureName)
//            }
       // },to: urlString, method: .post, headers : headerField)
        },to: urlString, method: .post)
        .response {  response in
            
            print(response)
            if response.response?.statusCode == 403 {
                //self.manageSession()
            }
            switch response.result {
            case .success(let value):
                // print(String(data: value as! Data, encoding: .utf8)!)
                successBlock(JSON(value ))

            case .failure( let error):
                errorBlock(error as NSError)
                print("ERROR RESPONSE: \(error)")
            }
        }

    }
    
    
    
    
    

}


