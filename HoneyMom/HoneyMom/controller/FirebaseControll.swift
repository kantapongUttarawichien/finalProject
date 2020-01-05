//
//  FirebaseControll.swift
//  HoneyMom
//
//  Created by kantapong on 5/12/2562 BE.
//  Copyright © 2562 kantapong. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class FirebaseService {

    // Sign up new users
    class func signupnewusers(email:String, password:String, name:String, height:String, weight:String, bloodsugar:String, congenitaldisease:String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["name" : name,"height" : height,"weight" : weight,"bloodsugar" : bloodsugar,"congenitaldisease" : congenitaldisease,"uid" : authResult!.user.uid]) {(error) in
                    
            print("Register")
        }
        }
    }
    
}
