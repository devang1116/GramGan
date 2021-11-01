//
//  ImageManager.swift
//  social media
//
//  Created by Devang Papinwar on 01/11/21.
//

import Foundation
import FirebaseStorage
import UIKit

struct ImageManager
{
    //MARK: PROPERTIES
    static let instane = ImageManager()
    private var REF_STOR = Storage.storage()
    
    
    //MARK: PUBLIC FUNCTIONS
    func uploadImage(userID : String , image : UIImage)
    {
        let path = getProfileImagePath(userID: userID )
        
        uploadImage(path: path, image: image) { (_) in }
    }
    
    //MARK: PRIVATE FUNCTIONS
    private func getProfileImagePath(userID : String) -> StorageReference
    {
        let userPath = "users/\(userID)/profile";
        let storagePath = REF_STOR.reference(withPath: userPath)
        return storagePath
    }
    
    private func uploadImage(path : StorageReference ,image : UIImage , handler : @escaping(_ success : Bool) -> ())
    {
        var compression : CGFloat = 1.0   // compression Size
        let maxFileSize : Int = 240 * 240   // Maximum File size that we want to save
        let maxCompression : CGFloat = 0.05  // Max amount of Compression
        
        // Check Maximum file size
        guard var originalData = image.jpegData(compressionQuality: 1.0) else {
            print("Error getting data from Image")
            handler(false)
            return
        }
        
        // get compressed image
        while(originalData.count > maxFileSize) && (compression > maxCompression)
        {
            compression -= 0.05
            if let compressedData = image.jpegData(compressionQuality: compression)
            {
                originalData = compressedData
            }
        }
        
        
        // Get Image Data
        guard let finalData = image.jpegData(compressionQuality: 1.0) else {
            print("Error getting data from Image")
            handler(false)
            return
        }

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        
        path.putData(finalData, metadata: metadata) { (_ , error ) in
            if let err = error
            {
                print("Error while uploading image \(err)")
                handler(false)
                return
            }
            else
            {
                print("Succes uploading image")
                handler(true)
                return
            }
        }
    }
}
