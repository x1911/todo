//
//  DetailViewController.swift
//  Todo
//
//  Created by apple on 15/5/7.
//  Copyright (c) 2015年 zz. All rights reserved.
//

import UIKit

//关键盘要继承UITextFieldDelegate
class DetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButon: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var todoItem: UITextField!
    @IBOutlet weak var todoDate: UIDatePicker!

//修改todo list里的内容,定义一个变量，类型是TodoModel格式，接受viewController里传过来的点取哪一行里的信息
    var todo : TodoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoItem.delegate = self
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "wlbackground07")!)
        
        // 初始化todo数值，判断todo数据过来为0的时候，则判断是新加list
        if todo == nil{
            aButton.selected = true //默认新加时候图片选定
            navigationController?.title = "new todo"
        }else{//修改的情况
            navigationController?.title = "edit todo"
            if todo?.image == "child-selected"{
                aButton.selected = true
            }
            else if todo?.image == "phone-selected"{
                bButon.selected = true
            }
            else if todo?.image == "shopping-cart-selected"{
                cButton.selected = true
            }
            else if todo?.image == "travel-selected"{
                dButton.selected = true
            }
            
            todoItem.text = todo?.title
            todoDate.setDate((todo?.date)!, animated: false)
            
        }//if todo
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //取消其他按钮高亮状态
    func resetButton() {
        aButton.selected = false
        bButon.selected = false
        cButton.selected = false
        dButton.selected = false
    }

    @IBAction func aTapped(sender: AnyObject) {
        resetButton()
        aButton.selected = true //选定状态
    }
    @IBAction func bTapped(sender: AnyObject) {
        resetButton()
        bButon.selected = true
    }
    @IBAction func cTapped(sender: AnyObject) {
        resetButton()
        cButton.selected = true
    }
    @IBAction func dTapped(sender: AnyObject) {
        resetButton()
        dButton.selected = true
    }
    
    @IBAction func okTapped(sender: AnyObject) {
        
        //判断是否没填内容
        if todoItem.text == ""{
        let alertController = UIAlertController(title: "Hi, dude", message: "好像要做的事情为空?", preferredStyle: .Alert) //.Alert是正中弹出提示框，.ActionSheet 是底部弹出提示框
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
        }
        
        var image =  ""
        if aButton.selected{
            image = "child-selected"
        }
        else if bButon.selected{
            image = "phone-selected"
        }
        else if cButton.selected{
            image = "shopping-cart-selected"
        }
        else if dButton.selected{
            image = "travel-selected"
        }
        
        if todo == nil{//新增
        //生成唯一标识ID
        let uuid = NSUUID().UUIDString // Spport Xcode 6.1
            todo = TodoModel (id:uuid, image:image, title: todoItem.text, date:todoDate.date)
        //println(uuid)
        todos.append(todo!) //todos += [todo]在结尾新增
        //todos += [TodoModel (id: uuid, image:image, title: todoItem.text,  date: todoDate.date)]
            
        }else{//修改更新，只是修改当前todo里的内容
            todo?.image = image
            todo?.title = todoItem.text
            todo?.date = todoDate.date
            
        }
    
        
    }

    //test url load web
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! webViewController
        vc.webURL = "http://www.baidu.com"
    }
*/

    
    
    
    //textfield能关键盘，重写的class，点击return就键盘消失
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //点其他地方键盘消失，重写touchesEnded针对todoItem的情况
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        todoItem.resignFirstResponder()
    }



}
