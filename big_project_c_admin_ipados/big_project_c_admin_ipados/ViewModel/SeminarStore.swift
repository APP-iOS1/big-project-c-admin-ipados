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

    @Published var seminar : Seminar
    
    let database = Firestore.firestore()
    
    init() {
        seminarList = []
        seminar = Seminar(id: "", image: [], name: "", date: Date(), startingTime: "", endingTime: "", category: "", location: "", locationUrl: "", hostName: "", hostImage: "", hostIntroduction: "", seminarDescription: "", seminarCurriculum: "")
    }
    
    // MARK: Storage 함수
    func storeImageToStorage(id:String, selectedImages: [UIImage?]) {
        //일단 랜덤값 넣음
        let uid = id
        var photos: [String] = []
        let ref = Storage.storage().reference(withPath: uid)
        
        for selectedImage in selectedImages {
            
            var photoID = UUID().uuidString
            let ref = Storage.storage().reference(withPath: photoID)
            
            guard selectedImage != nil else {
                return
            }

            guard let imageData = selectedImage?.jpegData(compressionQuality: 0.5) else {
                return
            }
            
            ref.putData(imageData) { metadata, error in
                if let error = error {
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
                    
                    photos.append(url.absoluteString)
                    postToStore(imageUrls: photos, uid: uid)
                }
            }
        }
        
        func postToStore(imageUrls: [String], uid: String) {
            
            let uid = uid
            
            //날짜 순서대로 정렬하려
            let dateFormatter: DateFormatter = {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
                
                return dateFormatter
            }()

            for url in imageUrls {
                let postData = ["id": uid, "image" : url]

                Firestore.firestore().collection("Seminar").document(uid).updateData([
                    "image" : FieldValue.arrayUnion([url])
                ])
                    print("success")
            }
            Firestore.firestore().collection("Seminar").document(uid).updateData([
                "image" : FieldValue.arrayRemove([""])
            ])
            fetchSeminar()
        }
    }
    
    
    // 모든 세미나들을 seminarList에 담아줌
    func fetchSeminarID(seminarID : String) {
        seminarList.removeAll()
        database.collection("Seminar").document("\(seminarID)").getDocument { (snapshot, error) in
            if let docData = snapshot?.data() {
                    let id : String = docData["id"] as? String ?? ""
                    let image: [String] = docData["image"] as? [String] ?? []
                    let name: String = docData["name"] as? String ?? ""
                    let createdAtTimeStamp: Timestamp = docData["date"] as? Timestamp ?? Timestamp()
                    let date: Date = createdAtTimeStamp.dateValue()
                    let startingTime: String = docData["startingTime"] as? String ?? ""
                    let endingTime: String = docData["endingTime"] as? String ?? ""
                    let category: String = docData["category"] as? String ?? ""
                    let location: String = docData["location"] as? String ?? ""
                    let locationUrl: String = docData["locationUrl"] as? String ?? ""
                    let hostName: String = docData["hostName"] as? String ?? ""
                    let hostImage: String = docData["hostImage"] as? String ?? ""
                    let hostIntroduction: String = docData["hostIntroduction"] as? String ?? ""
                    let seminarDescription: String = docData["seminarDescription"] as? String ?? ""
                    let seminarCurriculum: String = docData["seminarCurriculum"] as? String ?? ""
                    
                    let seminar = Seminar(id: id, image: image, name: name, date: date, startingTime: startingTime, endingTime: endingTime, category: category, location: location, locationUrl: locationUrl, hostName: hostName, hostImage: hostImage, hostIntroduction: hostIntroduction, seminarDescription: seminarDescription, seminarCurriculum: seminarCurriculum)
                    
                    self.seminarList.append(seminar)
                    print(seminar)
                }
        }
    }
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
                    let createdAtTimeStamp: Timestamp = docData["date"] as? Timestamp ?? Timestamp()
                    let date: Date = createdAtTimeStamp.dateValue()
                    let startingTime: String = docData["startingTime"] as? String ?? ""
                    let endingTime: String = docData["endingTime"] as? String ?? ""
                    let category: String = docData["category"] as? String ?? ""
                    let location: String = docData["location"] as? String ?? ""
                    let locationUrl: String = docData["locationUrl"] as? String ?? ""
                    let hostName: String = docData["hostName"] as? String ?? ""
                    let hostImage: String = docData["hostImage"] as? String ?? ""
                    let hostIntroduction: String = docData["hostIntroduction"] as? String ?? ""
                    let seminarDescription: String = docData["seminarDescription"] as? String ?? ""
                    let seminarCurriculum: String = docData["seminarCurriculum"] as? String ?? ""
                    
                    let seminar = Seminar(id: id, image: image, name: name, date: date, startingTime: startingTime, endingTime: endingTime, category: category, location: location, locationUrl: locationUrl, hostName: hostName, hostImage: hostImage, hostIntroduction: hostIntroduction, seminarDescription: seminarDescription, seminarCurriculum: seminarCurriculum)
                    
                    self.seminarList.append(seminar)
                }
            }
            print("herer")
            dump(self.seminarList)
        }
    }
    
    // 세미나 작성 완료시 추가됨 (input Seminar 타입으로 다 넣어주시면 됩니다.)
    func addSeminar(seminar: Seminar, selectedImages: [UIImage?], selectedHostImage: UIImage?) {
        database.collection("Seminar")
            .document(seminar.id)
            .setData(["id": seminar.id,
                      "image": seminar.image,
                      "name": seminar.name,
                      "date": seminar.createdDate,
                      "startingTime": seminar.startingTime,
                      "endingTime": seminar.endingTime,
                      "category": seminar.category,
                      "location": seminar.location,
                      "locationUrl": seminar.locationUrl,
                      "hostName": seminar.hostName,
                      "hostImage": seminar.hostImage,
                      "hostIntroduction": seminar.hostIntroduction,
                      "seminarDescription": seminar.seminarDescription,
                      "seminarCurriculum": seminar.seminarCurriculum,
                     ])
        
        // MARK: -selectedHostImageStore, storeHostImageToStorege 값 할당
        storeImageToStorage(id: seminar.id, selectedImages: selectedImages)
        storeHostImageToStorage(id: seminar.id, selectedHostImages: selectedHostImage)
        fetchSeminar()
    }
    
    func editSeminar(seminar: Seminar, selectedImages: [UIImage?], selectedHostImage: UIImage?) {
        database.collection("Seminar")
            .document(seminar.id)
            .updateData(["id": seminar.id,
                         "image": seminar.image,
                         "name": seminar.name,
                         "date": seminar.date,
                         "startingTime": seminar.startingTime,
                         "endingTime": seminar.endingTime,
                         "category": seminar.category,
                         "location": seminar.location,
                         "locationUrl": seminar.locationUrl,
                         "hostName": seminar.hostName,
                         "hostImage": seminar.hostImage,
                         "hostIntroduction": seminar.hostIntroduction,
                         "seminarDescription": seminar.seminarDescription,
                         "seminarCurriculum": seminar.seminarCurriculum,
                        ])
        
        // MARK: -selectedHostImageStore, storeHostImageToStorege 값 할당
        storeImageToStorage(id: seminar.id, selectedImages: selectedImages)
        storeHostImageToStorage(id: seminar.id, selectedHostImages: selectedHostImage)
        fetchSeminar()
    }

    // selectedHostImage
    func storeHostImageToStorage(id:String, selectedHostImages: UIImage?) {
        //일단 랜덤값 넣음
        let uid = id
        let photoID = UUID().uuidString
        let ref = Storage.storage().reference(withPath: photoID)
            
            guard selectedHostImages != nil else {
                return
            }

            guard let imageData = selectedHostImages?.jpegData(compressionQuality: 0.5) else {
                return
            }
            
            ref.putData(imageData) { metadata, error in
                if let error = error {
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
                    
                    self.postHostImageToStore(imageUrl: url, uid: uid)
                }
            }
        }
    
    
        
        func postHostImageToStore(imageUrl: URL, uid: String) {
            
            let uid = uid
            
            //날짜 순서대로 정렬하려
            let dateFormatter: DateFormatter = {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
                
                return dateFormatter
            }()

            let postData = ["id": uid, "hostImage" : imageUrl.absoluteString]

                Firestore.firestore().collection("Seminar").document(uid).updateData(postData)
                    print("success")
          
            fetchSeminar()
    }
    
    
    // MARK: - 세미나 게시물 삭제하기
    func deleteSeminar(seminar: Seminar) {
            database.collection("Seminar")
            .document(seminar.id)
                .delete()
        //TODO: 스토리지 이미지도 삭제!(접근하는 경로 찾기 어려움...)
        for url in seminar.image {
            Storage.storage().reference(forURL: url).delete { error in
                if let error {
                    print("delete storage error")
                }
            }
        }
        
        //FireStore Data를 READ 해오는 함수 호출
//    storeImageToStorage(id: seminar.id, selectedImages: selectedImages)

            //FireStore Data를 READ 해오는 함수 호출
            fetchSeminar()
        }
    
    func fetchSeminarIDList(completion : @escaping ([String]) -> ()) {
            database.collection("Seminar")
                .order(by: "date", descending: false)
                .getDocuments { (snapshot, error) in
                    if let snapshot {
                        var seminarIdList : [String] = []
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
                            let hostName: String = docData["hostName"] as? String ?? ""
                            let hostImage: String = docData["hostImage"] as? String ?? ""
                            let hostIntroduction: String = docData["hostIntroduction"] as? String ?? ""
                            let seminarDescription: String = docData["seminarDescription"] as? String ?? ""
                            let seminarCurriculum: String = docData["seminarCurriculum"] as? String ?? ""
                            
                            let seminar = Seminar(id: id, image: image, name: name, date: date, startingTime: startingTime, endingTime: endingTime, category: category, location: location, locationUrl: locationUrl, hostName: hostName, hostImage: hostImage, hostIntroduction: hostIntroduction, seminarDescription: seminarDescription, seminarCurriculum: seminarCurriculum)
                            
                            seminarIdList.append(seminar.id)
                        }
                        completion(seminarIdList)
                    }
                }
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


