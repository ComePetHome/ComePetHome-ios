//
//  TestView.swift
//  ComePetHome
//
//  Created by 주진형 on 1/8/24.
//
import SwiftUI
struct TestView: View {
    // 1
    @State private var path: [Int] = []


    var body: some View {
        // 2
        NavigationStack(path: $path) {

            Button("Start") {
                // 3
                path.append(1)

            }
            .navigationDestination(for: Int.self) { int in
                // 4
                DetailView(path: $path, count: int)

            }
            .navigationTitle("Home")
        }
    }
}

struct DetailView: View {
    // 5
    @Binding var path: [Int]

    
    let count: Int
    
    var body: some View {
        Button("Go deeper") {
            path.append(count + 1)
        }
        .navigationBarTitle(count.description)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Pop to Root") {
                    // 6
                    print(path)
                    path = []

                }
            }
        }
    }
}
#Preview{
    TestView()
}
