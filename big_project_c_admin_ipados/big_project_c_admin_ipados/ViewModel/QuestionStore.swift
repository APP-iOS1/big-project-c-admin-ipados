//
//  QuestionStore.swift
//  Big_Project_C_Customer
//
//  Created by 이종현 on 2022/12/27.
//

import SwiftUI
import Foundation
import FirebaseFirestore
import Firebase

class QuestionStore : ObservableObject {
    
    @Published var questionList : [Question] = []
    
    let database = Firestore.firestore().collection("Seminar")
    private var listener: ListenerRegistration?
    func fetchQuestion (seminarID: String){
        database.document(seminarID).collection("Question")
            .getDocuments { (snapshot, error) in
                self.questionList.removeAll()
                if let snapshot {
                    for document in snapshot.documents {
                        let id: String = document.documentID
                        let docData = document.data()
                        let questionContent: String = docData["question"] as? String ?? ""
                        let question: Question = Question(id: id, question: questionContent)
                        self.questionList.append(question)
                    }
                }
            }
    }
    
    func listenQuestion(seminarID: String) {
            self.listener = database.document(seminarID).collection("Question").addSnapshotListener({ querySnapshot, error in
            print("메시지 리스너 호출")
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents : \(error!)")
                return }
            querySnapshot?.documentChanges.forEach{ diff in
                print(seminarID, "확인~~")
                if (diff.type == .added) {
                    print("question added")
                    self.fetchQuestion(seminarID: seminarID)
                }
                if (diff.type == .modified) {
                    print(documents)
                    self.fetchQuestion(seminarID: seminarID)
                    
                }
                if (diff.type == .removed) {
                    print(documents)
                    self.fetchQuestion(seminarID: seminarID)
                }
                
            }
            
        }
        )}
 }
