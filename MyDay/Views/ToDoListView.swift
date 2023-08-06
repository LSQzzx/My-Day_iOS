//
//  ToDoListView.swift
//  MyDay
//
//  Created by Sp1der on 2023/8/5.
//

import SwiftUI

struct ToDoListView: View {
    @StateObject var viewModel = ToDoListViewViewModel()
    @EnvironmentObject var newModel: NewItemViewViewModel
    
    var body: some View {
        NavigationView {
            VStack{
                if newModel.items.isEmpty {
                    Text("No items")
                } else {
                    List (newModel.items) { item in
                        ToDoListItemView(item: item)
                            .swipeActions {
                                Button {
                                    newModel.delete(by: item.id)
                                } label: {
                                    Text("Delete")
                                }
                            }
                    }
                    .listStyle(PlainListStyle())
                    
                    TLButton(title: "Delete All Done", background: .red){
                        newModel.deleteDone()
                    }
                    .frame(width: 180, height: 40)
                    .padding(.bottom, 10)
                }
            }
            .navigationTitle("MyDay")
            .toolbar {
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }.onAppear {
                newModel.loadStructs()
            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView().environmentObject(NewItemViewViewModel())
    }
}
