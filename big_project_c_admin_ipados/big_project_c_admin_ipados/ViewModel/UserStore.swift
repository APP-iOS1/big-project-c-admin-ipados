//
//  UserStore.swift
//  Big_Project_C_Customer
//
//  Created by BOMBSGIE on 2022/12/27.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

var userUID = ""

class UserStore : ObservableObject {
    
    @Published var userList : [User] = []
    @Published var isLogin = false
    
    
    // 로그인 상태 확인
    @Published var currentUser: Firebase.User?
    let database = Firestore.firestore()
    
    // 로그인
    @Published var email: String = ""
    @Published var password: String = ""
    
    //회원가입
    @Published var signUpEmail: String = ""
    @Published var signUpPw: String = ""
    @Published var nickname : String = ""
    @Published var isAdmin : Bool = false
    @Published var goSemId : [String] = []
    
    init() {
        userList = [
            User(id: UUID().uuidString, nickname: "닉넴", email: "test@gamil.com", goSemId: ["asadlgjfsgljk"], isAdmin: true, uid: "sdghasgjkhsagklsj")
        ]
        currentUser = Auth.auth().currentUser
        
    }
    func fetchUser() {
        userList.removeAll()
        database.collection("User").getDocuments { (snapshot, error) in
            if let snapshot {
                for document in snapshot.documents {
                    let docData = document.data()
                    let id : String = document.documentID
                    let nickname: String = docData["nickname"] as? String ?? ""
                    let email: String = docData["email"] as? String ?? ""
                    let goSemId: [String] = docData["goSemId"] as? [String] ?? []
                    let isAdmin: Bool = docData["isAdmin"] as? Bool ?? false
                    let uid: String = docData["uid"] as? String ?? ""
                    
                    let user = User(id: id, nickname: nickname, email: email, goSemId: goSemId, isAdmin: isAdmin, uid: uid)
                    
                    self.userList.append(user)
                }
            }
            print("herer")
            dump(self.userList)
        }
    }
    
    // 로그인
    func loginUser(email: String, password: String, completion : @escaping (Int) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in

            if let error = error {
                let code = (error as NSError).code
                print(code, "로그인 에러 코드")
                print(error.localizedDescription)
                completion(code)
            }
            else {
                //성공
                completion(200)
                self.currentUser = result?.user
            }
//            if let error = error {
//                print("Failed to login user:", error)
//                return
//            }
//            print("Successfully logged in as user: \(result?.user.uid ?? "")")
//            self.currentUser = result?.user
        }
        
    }
    
    // 로그아웃
    func logout() {
        self.currentUser = nil
        try? Auth.auth().signOut()
    }
    
    // 회원가입
    // Auth에 계정을 등록시키는 함수
    // 회원가입
    func createNewAccount()  {
        Auth.auth().createUser(withEmail: signUpEmail, password: signUpPw) { result, error in
            if let error = error {
                print("Failed to create user:", error)
                return
            }
            
            print("Successfully created user: \(result?.user.uid ?? "")")
            //            self.storeUserInfoToDatabase(uid: result?.user.uid ?? "")
            self.storeUserInfoToDatabase(uid: result?.user.uid ?? "")
        }
    }
    
    // Firestore에 user 정보를 보내는 함수
    func storeUserInfoToDatabase(uid : String) {
        
        // model을 쓰면 쉽게 구조화할 수 있음
        let userData = ["nickName" : self.nickname, "email" : self.signUpEmail, "uid" : uid, "goSemId" : self.goSemId, "isAdmin" : self.isAdmin] as [String : Any]
        
        Firestore.firestore().collection("User").document(uid).setData(userData as [String : Any]) { error in
            if let error = error {
                print(error)
                return
            }
        }
    }
}
