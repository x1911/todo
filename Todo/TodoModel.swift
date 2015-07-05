//
//  TodoModel.swift
//  Todo
//
//  Created by apple on 15/5/6.
//  Copyright (c) 2015年 zz. All rights reserved.
//

import UIKit

class TodoModel: NSObject {
    var id: String
    var image:String
    var title: String
    var date: NSDate //date picker 的日期类型
    
    //构造函数，对值进行初始化
    init(id:String, image:String, title:String, date:NSDate){
        self.id = id
        self.image = image
        self.title = title
        self.date = date
    }
}

//将model定义成结构体，结构体不定义 init() 初始化函数也不会报错
struct TodoModel2{
    var id: String
    var image:String
    var title: String
    var date: NSDate
}

//struct 属于swift独有，是把所有内容放到栈里， class是一个个指针放入，在传指针到class里时，可以修改指针的属性，struct无法修改，而是整个copy不会回传，class可以回传，方便修改功能