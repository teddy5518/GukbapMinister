//
//  EditNicknameView.swift
//  GukbapMinister
//
//  Created by 전혜성 on 2023/02/03.
//

import SwiftUI
import FirebaseAuth


enum NickNameTextField: Hashable {
    case nickNameTextFieldFocus
}

struct EditNicknameView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var manager = UserInfoUpdateManager()
    
    @FocusState private var focusField: NickNameTextField?
    @State private var showAlert: Bool = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
               
                TextField("\(manager.user.userNickname)", text: $manager.user.userNickname)
                    .focused($focusField, equals: .nickNameTextFieldFocus)
                
                Text( """
                    닉네임은 욕설, 외설, 폭력적이지 않아야 합니다.
                    또한 종교, 성별, 인종, 지역 등으로 타인을 차별하거나 인신공격적 이어서는 안됩니다.
                    
                    부적절한 닉네임 사용시 서비스 이용이 제한될 수 있습니다.
                    """
                )
                .multilineTextAlignment(.leading)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 30)
                
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("닉네임")
            .toolbar {
                Button {
                    if !manager.user.userNickname.isEmpty {
                        manager.handleUpdateButton()
                        dismiss()
                    } else {
                        showAlert = true
                    }
                } label: {
                    Text("완료")
                }
                .disabled(!manager.modified)
                .alert("비어있는 닉네임", isPresented: $showAlert) {
                    Button("확인") {
                        showAlert = false
                    }
                } message: {
                    Text("적어도 한 글자 이상의 닉네임을 입력해주세요.")
                }
            }
        }
        .onAppear {
            focusField = .nickNameTextFieldFocus
        }
        .onTapGesture {
           hideKeyboard()
        }
    }
}
