//
//  LoginView.swift
//  big_project_c_admin_ipados
//
//  Created by TEDDY on 12/27/22.
//

import SwiftUI

struct LoginView: View {
    enum Field: Hashable {
        case email
        case password
    }
    @EnvironmentObject var viewModel : UserStore
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var loginResponseText : String = ""
    @State private var isLoadingIndicator : Bool = false
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
            HStack {
                VStack {
                    VStack(alignment: .leading) {
                        Image("LoginLogo")
                            .offset(x: -10)
                            .padding(.bottom, 10)
                        Text("테킷팅에서 트렌드를 이끄는 세미나의 호스트가 되어주세요!")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.black)
                            .padding(.bottom)
                        Text("문의 (주)멋쟁이사자처럼 담당자 황유진")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(Color(hex: 0x676767))
                    }
                    .padding(.top, 133)
                    Spacer()
                }
                .padding(.leading, 93)
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("관리자용 앱")
                        .font(.system(size: 30, weight: .semibold))
                    Text("제공해드린 아이디와 비밀번호를 입력해주세요.")
                        .font(.system(size: 20, weight: .regular))
                        .padding(.bottom, 18)
                    Rectangle()
                        .frame(width: 395, height: 1)
                        .foregroundColor(Color(hex: 0xECECEC))
                        .padding(.bottom, 32)
                    TextField("이메일 아이디를 입력하세요", text: $email)
                        .autocapitalization(.none)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .email)
                        .onSubmit {
                            focusedField = .password
                        }
                        .padding()
                        .foregroundColor(Color(hex: 0x606060))
                        .frame(width: 395, height: 55)
                        .background(Color(hex: 0xF1F1F1))
                        .cornerRadius(10)
                        .padding(.bottom, 10)
                    SecureField("비밀번호를 입력하세요", text: $password)
                        .autocapitalization(.none)
                        .focused($focusedField, equals: .password)
                        .submitLabel(.done)
                        .padding()
                        .onSubmit {
                            focusedField = nil
                        }
                        .foregroundColor(Color(hex: 0x606060))
                        .frame(width: 395, height: 55)
                        .background(Color(hex: 0xF1F1F1))
                        .cornerRadius(10)
                    Text(loginResponseText)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.red)
                        .frame(height: 20)
                    Button {
                        isLoadingIndicator = true
                        viewModel.loginUser(email: email, password: password) { completionCode in
                            switch completionCode {
                            case 200:
                                print("성공")
                                isLoadingIndicator = false
                            case 17008:
                                print("이메일 형식이 아님")
                                loginResponseText = "이메일 형식이 아닙니다."
                                isLoadingIndicator = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                                    loginResponseText = "전송이 완료되었습니다."
                                    //sheet닫는 코드
                                    
                                })
                            case 17009:
                                print("비밀번호가 다름")
                                loginResponseText = "비밀번호가 다릅니다."
                                isLoadingIndicator = false
                            case 17011:
                                print("등록되지 않은 회원")
                                loginResponseText = "등록되지 않은 관리자입니다."
                                isLoadingIndicator = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                                    loginResponseText = "전송이 완료되었습니다."
                                    //sheet닫는 코드
                                })
                            default:
                                print("고려하지 못한 에러")
                                loginResponseText = "죄송합니다. 고려하지 못한 에러입니다."
                                isLoadingIndicator = false
                            }
                        }
                    } label: {
                        ZStack {
                            Text("로그인 하기")
                                .font(.system(size: 13, weight: .bold))
                                .frame(width: 391, height: 50)
                                .foregroundColor(.white)
                                .background(.black)
                            if isLoadingIndicator {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                                    .scaleEffect(2)
                                    .frame(width: 391, height: 50)
                                    .background(.black)
                            }
                        }
                    }
                    .disabled(isLoadingIndicator)
                    .padding(.top, 30)
                    .padding(.bottom, 12)
                    Text("로그인이 되지 않거나, 아이디/비밀번호를 잃어버린 경우, \n담당 관리자에게 문의해주세요.")
                        .foregroundColor(Color(hex: 0x6c6c6c))
                        .font(.system(size: 12, weight: .medium))
                }
                .padding(.trailing, 144)
            }
//            if isLoadingIndicator {
//                ZStack {
//                    Color(.systemBackground)
//                        .ignoresSafeArea()
//                        .opacity(0.8)
//                    ProgressView()
//                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
//                        .scaleEffect(5)
//                }
//            }
        }
        .onAppear {
//            isLoadingIndicator = true
        }
    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
