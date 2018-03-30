//
//  GoogleDownloader.swift
//  FilterShowcase
//
//  Created by JungMoon-Mac on 2018. 3. 29..
//  Copyright © 2018년 Sunset Lake Software. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Toast

class GoogleDownloader: NSObject {
    static func downlaod(driveFileId:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let view = appDelegate.window?.rootViewController?.view
        view?.makeToast("Image Download Started")
        
        let filePath = "\(NSHomeDirectory())/Documents/\(driveFileId)"
        Alamofire.request("https://drive.google.com/uc?id=\(driveFileId)").responseImage { response in
            debugPrint(response)
            debugPrint(response.result)
       
            if let image = response.result.value{
                print("image downloaded: \(image)")
                
                print("filePath \(filePath)")
                try! UIImagePNGRepresentation(image)?.write(to: URL(fileURLWithPath:filePath))
                
                view?.makeToast("Image Download Successful.\n\(driveFileId)")
            }
            else{
                view?.makeToast("Image Download Failed.")
            }
        }
        
        UserDefaults.standard.set(filePath, forKey: "filter_path")
        UserDefaults.standard.synchronize()

    }
}
