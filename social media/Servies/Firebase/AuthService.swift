//
//  AuthService.swift
//  social media
//
//  Created by Devang Papinwar on 31/10/21.
//

// USed to auth users in firebase and handle user accounts
import Foundation
import FirebaseAuth
import FirebaseFirestore
import UIKit

let DB_BASE = Firestore.firestore()
class AuthService
{
    static let instance = AuthService()
    private var REF_USERS = DB_BASE.collection("users")
    
    //MARK: Functions
    func logInUserToFirebase( credential : AuthCredential , handler : @escaping(_ providerID : String? , _ isError : Bool , _ isNewUser : Bool? , _ userID : String?) -> ())
    {
        Auth.auth().signIn(with: credential) { result, error in
            if error != nil
            {
                print("ERROR IN AUTH SERVICE")
                handler(nil,true , nil , nil)
                return
            }
            guard let providerID = result?.user.uid else {
                print("Error getting provider ID")
                handler(nil,true , nil , nil)
                return
            }
            
            self.checkIfUserExistsInDatabase(providerID: providerID) { existingUserID in
                if let userId = existingUserID
                {
                     handler(providerID , true , false , userId)
                }
                else
                {
                    handler(providerID , false , true , nil)
                }
            }
            
            print("TRUE HAI BHAI")
        }
    }
    
    func logInUserToApp(userID : String , handler : @escaping (_ success : Bool) -> () )
    {
        getUserData(forUserID: userID) { returnedName, returnedBio in
            print("Succes while logging in")
            if let name = returnedName , let bio = returnedBio {
                handler(true )
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
                {
                    UserDefaults.standard.set(userID, forKey: CurrentUserDefaults.userID)
                    UserDefaults.standard.set(returnedBio, forKey: CurrentUserDefaults.bio)
                    UserDefaults.standard.set(returnedName, forKey: CurrentUserDefaults.displayName)
                }
                
            }
            else
            {
                print("Error logging the user in")
                handler(false)
            }
        }
        
    }
    
    
    func logOutUser(handler : @escaping(_ success : Bool) -> () )
    {
        do
        {
            try Auth.auth().signOut()
            
        }
        catch
        {
            print("Error signign out")
            handler(false)
            return
        }
        handler(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
        {
            let defaultDictionary = UserDefaults.standard.dictionaryRepresentation()
            
            defaultDictionary.keys.forEach { key in
                UserDefaults.standard.removeObject(forKey: key)
            }

        }
    }
    
    func createNewUserInDatabase(name : String , email : String ,  providerID : String , provider : String , profileImage : UIImage , handler : @escaping(_ userId : String? ) -> () )
    {
        let document = REF_USERS.document()
        let userID = document.documentID
        
        // Upload Profile Image to Database
        ImageManager.instane.uploadImage(userID: userID, image: profileImage)

        // Upload Prpfole dtaa to Database
        let userData : [String : Any] = [DatabaseUserFields.display_name : name ,
                                         DatabaseUserFields.email : email ,
                                         DatabaseUserFields.provider : provider ,
                                         DatabaseUserFields.provider_id : providerID ,
                                         DatabaseUserFields.user_id : userID ,
                                         DatabaseUserFields.bio : " " ,
                                         DatabaseUserFields.date_created :FieldValue.serverTimestamp() ]
        
        document.setData(userData) { error in
            if let err = error {
                print("Error uploading documents \(err)")
                handler(nil)
            }
            else
            {
                handler(userID)
            }
        }
    }
    
    
    //MARK: GET USER FUNCTIONS
    func getUserData(forUserID userID : String , handler : @escaping(_ name : String? , _ bio : String?) -> () )
    {
        REF_USERS.document(userID).getDocument { (documentSnapshot , error) in
            if let document = documentSnapshot,
               let name = document.get(DatabaseUserFields.display_name) as? String,
               let bio = document.get(DatabaseUserFields.bio) as? String
            {
                print("Success")
                handler(name , bio)
                return
            }
            else
            {
                print("Error getting User info")
                handler(nil , nil)
                return
            }
        }

    }
    
    private func checkIfUserExistsInDatabase(providerID : String , handler : @escaping(_ existingUserID : String?) -> ())
    {
        REF_USERS.whereField(DatabaseUserFields.provider_id, isEqualTo: providerID).getDocuments { (querySnapshot , error) in
            if let snapshot = querySnapshot , snapshot.count > 0 , let documnent = snapshot.documents.first {
                let exisitingUserID = documnent.documentID
                handler(exisitingUserID)
                return
            }
            else
            {
                handler(nil)
                return
            }
        }
    }
}
