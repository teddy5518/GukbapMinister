//
//  StoreRegisterView.swift
//  GukbapMinister
//
//  Created by 김요한 on 2023/03/04.
//

import SwiftUI

struct StoreRegisterView: View {
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        //혹시 (제보가 아니라 등록)하면 지금 Store컬렉션에 바로 들어가는데
//        StoreRegistration 컬렉션으로 들어가는 것으로수정해주 실 수 있나요??
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct StoreRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        StoreRegisterView()
    }
}
