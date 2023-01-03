import SwiftUI

struct EditTestView: View {
    @ObservedObject var seminarStore: SeminarStore
    var seminarID : String
    
    var selectedContent: Seminar? {
        get {
            for sample in seminarStore.seminarList {
                if sample.id == seminarID {
                    return sample
                }
            }
            return nil
        }
    }

    
    
    var body: some View {
        VStack {
            
            Text(selectedContent?.id ?? "")
            Text(selectedContent?.name ?? "")
        }
        .onAppear {
            print("-----------")
//            seminarStore.fetchSeminarID(seminarID: seminarID)
            
        }
        .task {
            seminarStore.fetchSeminarID(seminarID: seminarID)
            seminarStore.editSeminar(seminar: Seminar(id: seminarID,
                                                      image: selectedContent?.image ?? [],
                                                      name: selectedContent?.name ?? "",
                                                      date: selectedContent?.date ?? Date(),
                                                      startingTime: selectedContent?.startingTime ?? "",
                                                      endingTime: selectedContent?.endingTime ?? "",
                                                      category: selectedContent?.category ?? "",
                                                      location: selectedContent?.location ?? "",
                                                      locationUrl: selectedContent?.locationUrl ?? "",
                                                      hostName: selectedContent?.hostName ?? "",
                                                      hostImage: selectedContent?.hostImage ?? "",
                                                      hostIntroduction: selectedContent?.hostIntroduction ?? "",
                                                      seminarDescription: selectedContent?.seminarDescription ?? "",
                                                      seminarCurriculum: selectedContent?.seminarCurriculum ?? ""))
        }
    }
}

//struct EditTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditTestView()
//    }
//}
