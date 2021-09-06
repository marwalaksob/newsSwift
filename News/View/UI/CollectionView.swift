//qw//  CollectionView.swift
//  News
//
//  Created by Marwalakchouch on 5/9/2021.
//  Copyright © 2021 Idlebrains. All rights reserved.
//

import SwiftUI
import URLImage


struct CollectionView : View {

    @ObservedObject var list: ListItems = ListItems()

    public init() {
        self.list.fetch()
    }
    var body: some View {

        NavigationView{
        ScrollView(.horizontal) {
            HStack {
                ForEach(list.items) { article in

                    NavigationLink(destination: NewsDetailView(article: article)) {
                        VStack {
                            if (article.imageUrl != nil) {
                                URLImage(article.imageUrl!, delay: 0.25, placeholder: {_ in
                                    Image("placeholder-image").resizable()
                                        .aspectRatio(contentMode: .fill)

                                }, content: {
                                    $0.image.resizable()
                                        .frame(width: 340, height: 600, alignment : .center)
                                        .cornerRadius(15)
                                        .offset(x : -70)



                                })
                            } else {
                                Image("placeholder-image")
                                    .resizable().aspectRatio(contentMode: .fill)

                            }
                            VStack(alignment: .leading, spacing: 5) {
                                Text(article.name)

                                    .lineLimit(1)

                                    .font(.headline)

                                Text(article.description)
                                    .lineLimit(2)
                                    .frame(width: 340, alignment : .leading)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                                Spacer()
                            }
                        }

                        }.buttonStyle(PlainButtonStyle())
                        .frame(width: 500, height: 800, alignment: .center)


                }
            }
        }.navigationBarTitle("Headlines")
        .padding(.top , 80)

        }
    }
}
