//
//  ImageManager.swift
//  social media
//
//  Created by Devang Papinwar on 01/11/21.
//

import Foundation
import FirebaseStorage
import UIKit

let imageCache = NSCache<AnyObject , UIImage>()

struct ImageManager
{
    //MARK: PROPERTIES
    static let instance = ImageManager()
    private var REF_STOR = Storage.storage()
    
    
    //MARK: PUBLIC FUNCTIONS
    func uploadProfileImage(userID : String , image : UIImage)
    {
        let path = getProfileImagePath(userID: userID )
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.uploadImage(path: path, image: image) { (_) in }
        }
    }
    
    func uploadPostImage(postID : String , image : UIImage , handler : @escaping(_ success : Bool) -> () )
    {
        //Get the path where we will store the image
        let path = getPostImagePath(postID: postID)
        
        //Save image to path
        DispatchQueue.global(qos: .userInteractive).async {
            self.uploadImage(path: path, image: image) { (success) in
                DispatchQueue.main.async {
                    handler(success)
                }
            }
        }
    }
    
    func downloadProfileImage(userID : String , handler : @escaping(_ image : UIImage?) -> ())
    {
        print("Download image called")
        //Get the path where the Image is saved
        let path = getProfileImagePath(userID: userID)
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.downloadImage(path: path) { (returnedImage) in
                DispatchQueue.main.async {
                    handler(returnedImage)
                }
            }
        }
    }
    
    func downloadPostImage(postID : String , handler : @escaping(_ image : UIImage?) -> () )
    {
        print("Download Post Image")
        // Get the path where the image is saved
        let path = getPostImagePath(postID: postID)
        
        // Download the image from path
        DispatchQueue.global(qos: .userInteractive).async {
            self.downloadImage(path: path) { (returnedImage) in
                DispatchQueue.main.async {
                    handler(returnedImage)
                }
            }
        }
    }
    
    // gs://socialmedia-dd00d.appspot.com/posts/4xZGrrv3vJHlR1A68NVW/1
    
    //MARK: PRIVATE FUNCTIONS
    private func getProfileImagePath(userID : String) -> StorageReference
    {
        let userPath = "users/\(userID)/profile";
        let storagePath = REF_STOR.reference(withPath: userPath)
        return storagePath
    }
    
    private func getPostImagePath(postID : String) -> StorageReference
    {
        print(postID)
        let userPath = "posts/\(postID)/1";
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
    
    private func downloadImage(path : StorageReference , handler : @escaping(_ image : UIImage?) -> ())
    {
        if let cachedImage = imageCache.object(forKey: path)
        {
            print("Image found in cache")
            handler(cachedImage)
            return
        } else {
            path.getData(maxSize: 27 * 1024 * 1024) { (returnedImageData, error) in
                
                if let data = returnedImageData, let image = UIImage(data: data)
                {
                    // Success getting image data
                    imageCache.setObject(image, forKey: path)
                    handler(image)
                    return
                } else
                {
                    print(returnedImageData as? String )
                    print("Error getting data from path for image: \(error)")
                    handler(nil)
                    return
                }
                
            }
        }
    }
}
