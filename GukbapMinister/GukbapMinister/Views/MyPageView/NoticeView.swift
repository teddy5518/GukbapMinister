//
//  NoticeView.swift
//  GukbapMinister
//
//  Created by 김요한 on 2023/02/13.
//

import SwiftUI

struct NoticeView: View {
    @StateObject var noticeViewModel = NoticeViewModel()
    

    @State private var contentsExpanded: Bool = false

    
    var body: some View {
        NavigationStack {
            List (noticeViewModel.notices) { notice in
                DisclosureGroup(notice.title) {
                    Text(notice.contents)
                }
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("공지")
        }
        .onAppear {
            noticeViewModel.subscribeNotices()
        }
        .onDisappear {
            noticeViewModel.unsubscribeNotices()
        }
    }
}

struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeView()
    }
}
