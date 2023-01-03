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
    
}
