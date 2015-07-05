//
//  ViewController.swift
//  Todo
//
//  Created by apple on 15/5/6.
//  Copyright (c) 2015年 zz. All rights reserved.
//

import UIKit

//本地数据库存储
var todos: [TodoModel] = [] //全局，每个地方都可调用这个todos
var fliteredTodos:[TodoModel] = [] //用于存储搜索结果的数组

func dateFromString (dateStr: String) -> NSDate? {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.dateFromString(dateStr)
    return date
}

//继承protocol，继承以后要将 func copy 过来重写,UITableViewDataSource用于cell内容的控制，UITableViewDelegate用于删除cell，UISearchDisplayDelegate用于搜索结果
class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, UISearchDisplayDelegate {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() { //view读入的初始化
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //调入新的cell
        //var nib = UINib(nibName: "firstTableViewCell", bundle: nil)
        //self.tableView.registerNib(nib, forCellReuseIdentifier: "firstTableViewCell")
        
        
        //nvaigationbar背景设置
        
        let bar = self.navigationController?.navigationBar
        //bar?.setBackgroundImage(UIImage(named: "bar"), forBarMetrics: UIBarMetrics.Default);
        //bar?.tintColor = UIColor.whiteColor()
        
        
        //背景图片调用
        // UIColor 的用法可以让这个图片产生 repeat-X repeat-Y 的效果
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "wlbackground07")!)
        
        todos = [
            TodoModel(id: "1", image: "child-selected", title: "去游乐场", date: dateFromString("2014-10-20")!),
            TodoModel(id: "2", image: "shopping-cart-selected", title: "购物", date: dateFromString("2014-10-28")!),
            TodoModel(id: "3", image: "phone-selected", title: "打电话", date: dateFromString("2014-10-30")!),
            TodoModel(id: "4", image: "phone-selected", title: "打电话", date: dateFromString("2014-10-30")!),
            TodoModel(id: "5", image: "", title: "Travel to Europe", date: dateFromString("2014-10-31")!)
        ]
        println(todos)
        //用代码写 navigation bar 上面的 按钮
        navigationItem.leftBarButtonItem = editButtonItem()
        
        //搜索栏默认隐藏
        var contentOffset = tableView.contentOffset //获得tableview的位置
        contentOffset.y += searchDisplayController!.searchBar.frame.size.height
        tableView.contentOffset = contentOffset
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //只有一个section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

    
    
    //重写 UITableViewDataSource 里必须要用的func
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //返回有多少行，如果是显示搜索结果的tableview，则返回搜索结果的行数
        if tableView == searchDisplayController?.searchResultsTableView{ //判断是搜索过程
            return fliteredTodos.count
        }
        return todos.count //全局数据库的数量，返回行数
        
    }
    
    //tableView 函数负责呈现每个cell的内容
    /*
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        // table 里显示的内容
        let cell = self.tableView.dequeueReusableCellWithIdentifier("todoCell") as! UITableViewCell
        //dequeueReusableCellWithIdentifier将屏幕不显示的cell重用成下滑新的内容，Reusable可重用的cell
     */
        
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            //let cell = tableView.dequeueReusableCellWithIdentifier("firstTableViewCell", forIndexPath: indexPath) as! firstTableViewCell
        // table 里显示的内容
        let cell = self.tableView.dequeueReusableCellWithIdentifier("todoCell") as! UITableViewCell
        
        var todo: TodoModel //声明todo类型

        
        if tableView == searchDisplayController?.searchResultsTableView{ //判断是否搜索过程
            todo = fliteredTodos[indexPath.row] as TodoModel
        }else{
            //绑定内存数据库的内容
            todo = todos[indexPath.row] as TodoModel  //取出数组中每一行的数据当成class的内容
        }
        
        //先给cell中的每个元素定个tag值，然后通过 cell.viewWithTag() 可以给每个赋值
        var image = cell.viewWithTag(101) as? UIImageView
        var title = cell.viewWithTag(102) as? UILabel
        var date = cell.viewWithTag(103) as? UILabel
        
        // .image用这个表示图片，链接上根据文件名链接
        image?.image = UIImage(named: todo.image)
        //title?.text = todo.id + ".  " + todo.title
        title?.text = todo.title
        
        //时间显示方式根据手机设置而显示为不同的方式
        let locale = NSLocale.currentLocale()
        //指定一个显示时间的格式
        let dateFormat = NSDateFormatter.dateFormatFromTemplate("yyyy MM dd", options: 0, locale: locale)
        
        //根据 nsdate 的格式将数据库里的时间放到 103 tag 的文字里
        let dateFormatter = NSDateFormatter()
        //dateFormatter 初始化
        dateFormatter.dateFormat = dateFormat
        
        date?.text = dateFormatter.stringFromDate(todo.date)
        
        return cell
    }
    
    //UITableViewDelegate 删除cell，通过手势滑动删除
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete{
            todos.removeAtIndex(indexPath.row)      //删除某一行
            tableView.deleteRowsAtIndexPaths([indexPath],withRowAnimation:UITableViewRowAnimation.Automatic )
        }
    }
    
    // 个性化搜索结果的tableview要重写 func
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       return 85
    }
    
    
    //navigation controller 上的 edit 按钮按下以后的操作
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
    
    //允许移动各个cell的功能
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return editing
    }
    
    //移动以后位置的计算方法
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let todo = todos.removeAtIndex(sourceIndexPath.row) //移动起始点从数据库中删除，将这个位置存到 todo里
        todos.insert(todo, atIndex: destinationIndexPath.row) //插入到目标位置
    }
    
    //搜索功能，继承UISearchDisplayDelegate需要重写的function
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        
        //将搜索结果发到 发filter数组里，$0指数组里每个元素，假如元素的 title 包含搜索的内容 searchString 不为空，则过滤出来存放到数组 fliteredTodos 中
        fliteredTodos = todos.filter(){$0.title.rangeOfString(searchString) != nil}
        return true
    }
    

    
    
    //确认后返回前一个界面，该界面reload
    @IBAction func close(segue: UIStoryboardSegue){
        //println("close")
        tableView.reloadData()
    }
    
    //修改todo，需要重载一个方法,prepareForSegue 当页面切换使用到segue时就会调用这个方法
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //判断是调用哪个segue，用上了前面给segur定义的 identifier，当是EditTodo就传送数据
        if segue.identifier == "EditTodo"{
            var vc = segue.destinationViewController as! DetailViewController //要给目的viewcontroller转型
        
            //取出用于点击了哪一行，用户选择的行indexPathForSelectedRow
            var indexPath = tableView.indexPathForSelectedRow()
            //看这个值是否为空
            if let index = indexPath{
                //存放在全局数组里行数的值提交给 detailViewController 里的todo 变量
                vc.todo = todos[index.row]
            }//if let
            
        }//if segue
    }

}//class


