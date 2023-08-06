//
//  ToDoListItemView.swift
//  MyDay
//
//  Created by Sp1der on 2023/8/5.
//

import SwiftUI

struct ToDoListItemView: View {
    @EnvironmentObject var newModel: NewItemViewViewModel
    let item: ToDoListItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.body)
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            
            Spacer()
            
            Button {
                newModel.toggleIsDone(by: item.id)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color.blue)
            }
        }
    }
}

struct ToDoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListItemView(item: .init(
            id: "123",
            title: "test",
            dueDate: Date().timeIntervalSince1970,
            createDate: Date().timeIntervalSince1970,
            isDone: true
        ))
    }
}
