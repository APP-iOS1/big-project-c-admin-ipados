//
//  EditSession.swift
//  big_project_c_admin_ipados
//
//  Created by Jae hyuk Yim on 2023/01/02.
//

//import SwiftUI
//import PhotosUI
//
//struct EditSessionView: View {
//    
//    @ObservedObject var seminarInfo: SeminarStore
//    @Environment(\.dismiss) private var dismiss
//    
//    private let transaction: Transaction = .init(animation: .linear)
//    
//    var selectedContent : Seminar?
//    
//    @State private var selectedCategory: String = ""
//    var dateFormatter : DateFormatter {
//        let formatter = DateFormatter()
//        //한국 시간으로 표시
//        formatter.locale = Locale(identifier: "ko_kr")
//        formatter.timeZone = TimeZone(abbreviation: "KST")
//        //형태 변환
//        formatter.dateFormat = "yyyy-MM-dd"
//        
//        return formatter
//    }
//    
//    
//    
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 80) {
//                    
//                    //MARK: - 세미나 기본정보 타이틀
//                    VStack(alignment: .leading) {
//                        HStack {
//                            Text("세미나 기본정보")
//                                .font(.title)
//                                .fontWeight(.bold)
//                                .foregroundColor(Color.accentColor)
//                            Spacer()
//                            Button{
//                                dismiss()
//                            } label: {
//                                Text("닫기")
//                                    .foregroundColor(.white)
//                                    .padding()
//                            }
//                            .fontWeight(.bold)
//                            .background {
//                                Color.accentColor
//                            }
//                            .cornerRadius(10)
//                        }
//                    }
//                    
//                    
//                    //세미나 기본정보
//                    
//                    VStack (alignment: .leading) {
//                        Text("세미나 타이틀")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                        
//                        TextField("타이틀을 입력해주세요.", text: selectedContent?.name)
//                    }
//                    
//                    
//                    //MARK: - image
//                    VStack (alignment: .leading)  {
//                        Text("대표 이미지")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                        
//                        HStack {
//                            HStack{
//                                TextField("이미지 URL을 작성해주세요.", text: selectedContent?.image)
//                            }
//                            
//                            HStack {
//                                AsyncImage(url: URL(string: selectedContent?.image), transaction: transaction, content: imageView)
//                                    .frame(width: 100, height: 100)
//                                
//                            }
//                        }
//                    }
//                    
//                    
//                    
//                    // MARK: - datePicker
//                    VStack(alignment: .leading) {
//                        
//                        Text("일정")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                        
//                        HStack {
//                            //TODO: - 날짜, 시간 DatePicker를 아이콘으로 만들고, 해당 값을 TextLabel로 작성되도록 하기
//                            HStack {
//                                Image(systemName: "calendar.circle")
//                                Text("날짜")
//                                DatePicker(selection: selectedContent?.date, displayedComponents: .date) {
//                                    Text("date")
//                                }
//                                Text("\(selectedContent?.date, formatter: dateFormatter)")
//                            }
//                            .labelsHidden()
//                            
//                            
//                            Divider()
//                            
//                            HStack {
//                                
//                                Image(systemName: "clock")
//                                Text("시작시간")
//                                TextField("시작.", text: selectedContent?.startingTime)
//                                
//                                Spacer()
//                                
//                                Text("종료시간")
//                                TextField("종료.", text: selectedContent?.endingTime)
//                            }
//                        }
//                    }
//                    
//                    
//                    // MARK: - categoryPicker
//                    VStack(alignment: .leading) {
//                        
//                        Text("유형")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                        
//                        HStack(spacing: 50) {
//                            Text("세미나 유형을 선택해주세요")
//                                .font(.callout)
//                            
//                            Picker("세미나 유형을 선택해주세요", selection: $selectedCategory) {
//                                ForEach(selectedContent?.category, id: \.self) {
//                                    Text($0)
//                                }
//                            }
//                        }
//                    }
//                    
//                    
//                    
//                    // MARK: - PlacePicker
//                    VStack(alignment: .leading) {
//                        
//                        Text("장소")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                        
//                        HStack(spacing: 50) {
//                            Text("장소를 입력해 주세요")
//                                .font(.callout)
//                            
//                            TextField("세부장소", text: selectedContent?.location)
//                            
//                            // TODO: - 웹뷰 혹은 URL ? -> 내부 협의 필요
//                            Text("장소URL")
//                                .font(.callout)
//                            
//                            TextField("주소", text: selectedContent?.locationUrl)
//                        }
//                    }
//                    
//                    
//                    
//                    // MARK: - HostInfo ( 호스트 인포 - 프로필 사진, 강사소개)
//                    VStack (alignment: .leading) {
//                        Text("강사 소개")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                        
//                        HStack {
//                            TextField("이미지 URL을 작성해주세요.", text: selectedContent?.host)
//                            AsyncImage(url: URL(string: selectedContent?.host), transaction: transaction, content: imageView)
//                                .frame(width: 100, height: 100)
//                            
//                        }
//                        
//                        VStack(alignment: .leading) {
//                            TextEditor(text: selectedContent?.hostIntroduction)
//                                .padding()
//                                .background(Color(.secondarySystemBackground))
//                                .frame(height: 150)
//                            
//                        }
//                    }
//                    
//                    
//                    
//                    //MARK: - 세미나 상세내용
//                    VStack {
//                        VStack(alignment: .leading) {
//                            Text("세미나 상세 내용")
//                                .font(.title2)
//                                .fontWeight(.bold)
//                            
//                            TextEditor(text: selectedContent?.seminarDescription)
//                                .padding()
//                                .background(Color(.secondarySystemBackground))
//                                .frame(height: 300)
//                            
//                        }
//                    }
//                    
//                    // MARK: - 상세 커리큘럼
//                    VStack(alignment: .leading) {
//                        VStack(alignment: .leading) {
//                            Text("상세 커리큘럼")
//                                .font(.title2)
//                                .fontWeight(.bold)
//                            
//                            TextEditor(text: selectedContent?.seminarCurriculum)
//                                .padding()
//                                .background(Color(.secondarySystemBackground))
//                                .frame(height: 300)
//                            
//                        }
//                    
//                    
//                    
//                    
//                        
//                        
//                        // MARK: - 세미나 등록하기 버튼 추가 (데이터)
//                        VStack(alignment: .center) {
//                            Button {
//                                seminarInfo.editSeminar(seminar: Seminar(id: selectedContent?.id ?? "",
//                                                                         image: selectedContent?.image ?? [],
//                                                                         name: selectedContent?.name ?? "",
//                                                                         date: selectedContent?.date ?? Date(),
//                                                                         startingTime: selectedContent?.startingTime ?? "",
//                                                                         endingTime: selectedContent?.endingTime ?? "",
//                                                                         category: selectedContent?.category ?? "",
//                                                                         location: selectedContent?.location ?? "",
//                                                                         locationUrl: selectedContent?.locationUrl ?? "",
//                                                                         host: selectedContent?.host ?? "",
//                                                                         hostIntroduction: selectedContent?.hostIntroduction ?? "",
//                                                                         seminarDescription: selectedContent?.seminarDescription ?? "",
//                                                                         seminarCurriculum: selectedContent?.seminarCurriculum ?? ""))
//                                
//                                
//                                
//                                
//                                dismiss()
//                                
//                            } label: {
//                                Text("세미나 수정하기")
//                                    .foregroundColor(.white)
//                                    .padding()
//                                // 등록하기
//                            }
//                            .font(.title3)
//                            .fontWeight(.bold)
//                            .foregroundColor(.black)
//                            .background {
//                                Color.accentColor
//                            }
//                            .cornerRadius(10)
//                            
//                        }
//                    }
//                    
//                }
//                .onChange(of: selectedContent) { newValue in
//                    if let selectedContent = newValue {
//                        seminarInfo.editSeminar(seminar: Seminar(id: selectedContent.id,
//                                                                 image: selectedContent.image,
//                                                                 name: selectedContent.name,
//                                                                 date: selectedContent.date,
//                                                                 startingTime: selectedContent.startingTime,
//                                                                 endingTime: selectedContent.endingTime,
//                                                                 category: selectedContent.category,
//                                                                 location: selectedContent.location,
//                                                                 locationUrl: selectedContent.locationUrl,
//                                                                 host: selectedContent.host,
//                                                                 hostIntroduction: selectedContent.hostIntroduction,
//                                                                 seminarDescription: selectedContent.seminarDescription,
//                                                                 seminarCurriculum: selectedContent.seminarCurriculum))
//                    }
//                }
//                
//            }
//        }
//        
//    }
//    //MARK: - Async image를 나타내는 비동기 메서드
//    @ViewBuilder
//    func imageView(for phase: AsyncImagePhase) -> some View {
//        switch phase {
//        case .empty:
//            Image(systemName: "photo")
//                .frame(width: 100, height: 100)
//                .overlay {
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color.gray, lineWidth: 1)
//                }
//        case .success(let image):
//            image
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//        case .failure(let error):
//            VStack(spacing: 16) {
//                Image(systemName: "xmark.octagon.fill")
//                    .foregroundColor(.red)
//                Text(error.localizedDescription)
//                    .multilineTextAlignment(.center)
//            }
//        @unknown default:
//            Text("Unknown")
//                .foregroundColor(.gray)
//        }
//    }
//}
//
//
