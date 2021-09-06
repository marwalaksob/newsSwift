//
//  NewsDetailView.swift
//  News
//
//  Created by Marwalakchouch on 5/9/2021.
//  Copyright © 2021 Idlebrains. All rights reserved.
//

import SwiftUI
import URLImage



struct NewsDetailView: View {
    let article: ListItem
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 20) {
                Text(article.name).font(.largeTitle).lineLimit(nil)
                VStack(alignment: .leading, spacing: 5) {
                    HStack(alignment: .center) {
                        if (article.imageUrl != nil) {
                            URLImage(article.imageUrl!, placeholder: {_ in
                                Image("placeholder-image").resizable().aspectRatio(contentMode: .fit)
                            }, content: {
                                $0.image.resizable().aspectRatio(contentMode: .fit)
                            })
                        } else {
                            Image("placeholder-image").resizable().aspectRatio(contentMode: .fit)
                        }
                    }
                    HStack {
                        Text(article.sourceWebsite ?? "Unknown").font(.footnote).foregroundColor(.gray)
                        Spacer()
                        Text(Utils.getFormattedDateString(someDate: article.date)).font(.footnote).foregroundColor(.gray)
                    }
                }
                Text(article.body ?? article.description).lineLimit(nil).font(.body)
              
            }.padding()
            Spacer()
        }
    }
}

