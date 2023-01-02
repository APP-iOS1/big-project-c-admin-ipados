//
//  SeminarStore.swift
//  Big_Project_C_Customer
//
//  Created by 이종현 on 2022/12/27.
//

import SwiftUI
import Foundation
import FirebaseFirestore
import Firebase
import FirebaseStorage


class SeminarStore : ObservableObject {
    // 세미나 배열
    @Published var seminarList : [Seminar] = []
    @Published var postImageUrls: UIImage?
    
    let database = Firestore.firestore()
    
    //이미지 업로드, 완료
    //스토리지에 사진을 올리면서 사진에서 url추출!
    func storeImageToStorage(uid: String) {
        //일단 랜덤값 넣음
        let ref = Storage.storage().reference(withPath: uid) //withPath: uid 스토어에 id
        
        //@Published var postImageUrls: UIImage? 옵셔널 타입. 사진을 피커에서 선택하면 UIImage를 줌. 여기 변수로 넣음, 그거를 불러옴
        guard let imageData = postImageUrls?.jpegData(compressionQuality: 0.5) else { //.jpegData storage에 올리기 위해 형식을 .jpeg로 바꿔줌,
            return
        }
        
        ref.putData(imageData) { metadata, error in //putdata //레퍼런스 path에 imageData를 넣어줌,  스토리지 기본 함수 / //넣게 되면 metadata 받아올 수 있음
            if let error = error { //못받아오면 에러
                print("\(error)")
                return
            }
            
            ref.downloadURL() { url, error in //받아왔을때는 url추출. 스토리지 기본 함수
                if let error = error {
                    print(error)
                    return
                }
                print(url?.absoluteString ?? "망함")
                
                guard let url = url else { return }
                
                self.postToStore(imageProfileUrl: url, uid: uid) //url에 데이터 들어있음 postToStore에 url주소 쏴줌
            }
        }
    }
    
    //완료
    //매개변수로 url이랑(만 받아도 됨) uid값은 나중에 데이터 관리하기 편하게 사진이랑 스토어 들어가는 uid같게하는게 관리하는게 편함
    func postToStore(imageProfileUrl: URL, uid: String) {
        
        let uid = uid
        
        //날짜 순서대로 정렬하려
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"

            return dateFormatter
        }()
         

        // model을 쓰면 쉽게 구조화할 수 있음 / 일반적으로 store에 데이터 보내주는 함수. "postImageUrl" : imageProfileUrl받아와서 .absoluteString사용해서 string으로 강제변환하고 저장. 뷰에서 불러올때 url로 불러움
        let postData = ["id": uid, "postImageUrl" : imageProfileUrl.absoluteString]
//        [ "id": id, "image": image, "name": name, "date": date, startingTime: startingTime, endingTime: endingTime, category: category, location: location, locationUrl: locationUrl, host: host, hostIntroduction: hostIntroduction, seminarDescription: seminarDescription, seminarCurriculum: seminarCurriculum]
        
        
//        ["id": uid, "image" : imageProfileUrl.absoluteString, "seminarDescription" : bodyTexts, "currentUser" : Auth.auth().currentUser?.uid, "date" : dateFormatter.string(from: Date.now)]
                            
        Firestore.firestore().collection("Seminar").document(uid).setData(postData as [String : Any]) { error in
            if let error = error {
                print(error)
                return
            }
            
            print("success")
        }
        
        fetchSeminar()
    }
    
    
    // 모든 세미나들을 seminarList에 담아줌
    func fetchSeminar() {
        seminarList.removeAll()
        database.collection("Seminar")
            .order(by: "date", descending: false)
            .getDocuments { (snapshot, error) in
            if let snapshot {
                for document in snapshot.documents {
                    let docData = document.data()
                    let id : String = document.documentID
                    let image: [String] = docData["image"] as? [String] ?? []
                    let name: String = docData["name"] as? String ?? ""
                    let date: Date = docData["date"] as? Date ?? Date()
                    let startingTime: String = docData["startingTime"] as? String ?? ""
                    let endingTime: String = docData["endingTime"] as? String ?? ""
                    let category: String = docData["category"] as? String ?? ""
                    let location: String = docData["location"] as? String ?? ""
                    let locationUrl: String = docData["locationUrl"] as? String ?? ""
                    let host: String = docData["host"] as? String ?? ""
                    let hostIntroduction: String = docData["hostIntroduction"] as? String ?? ""
                    let seminarDescription: String = docData["seminarDescription"] as? String ?? ""
                    let seminarCurriculum: String = docData["seminarCurriculum"] as? String ?? ""
                    let postImageUrl: String = docData["postImageUrl"] as? String ?? ""
                    
                    let seminar = Seminar(id: id, image: image, name: name, date: date, startingTime: startingTime, endingTime: endingTime, category: category, location: location, locationUrl: locationUrl, host: host, hostIntroduction: hostIntroduction, seminarDescription: seminarDescription, seminarCurriculum: seminarCurriculum, postImageUrl: postImageUrl)
                    
                    self.seminarList.append(seminar)
                }
            }
            print("herer")
            dump(self.seminarList)
        }
    }
    
    // 세미나 작성 완료시 추가됨 (input Seminar 타입으로 다 넣어주시면 됩니다.)
    func addSeminar(seminar: Seminar) {
            database.collection("Seminar")
            .document(seminar.id)
                .setData(["id": seminar.id,
                          "image": seminar.image,
                          "name": seminar.name,
                          "date": seminar.date,
                          "startingTime": seminar.startingTime,
                          "endingTime": seminar.endingTime,
                          "category": seminar.category,
                          "location": seminar.location,
                          "locationUrl": seminar.locationUrl,
                          "host": seminar.host,
                          "hostIntroduction": seminar.hostIntroduction,
                          "seminarDescription": seminar.seminarDescription,
                          "seminarCurriculum": seminar.seminarCurriculum,
                          "postImageUrl" : seminar.postImageUrl
                         ])

            //FireStore Data를 READ 해오는 함수 호출
        fetchSeminar()
        }
    
}

//    // 세미나 추가시 필요 정보들
//    @Published var image : [String] = []
//    @Published var name : String = ""
//    @Published var date : Date = Date()
//    @Published var startingTime : String = ""
//    @Published var endingTime : String = ""
//    @Published var category : String = ""
//    @Published var location : String = ""
//    @Published var host : String = ""
//    @Published var hostIntroduction : String = ""
//    @Published var seminarDescription : String = ""
//    @Published var seminarCurriculum : String = ""
