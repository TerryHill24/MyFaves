//
//  MasterViewController.swift
//  MyFaves
//
//  Created by RVC Terry on 9/14/20.
//  Copyright © 2020 Terry Hill. All rights reserved.
//
//

import UIKit

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    // 1) comment out var objects line
    //var objects = [Any]()
    
    // 2) declare and initialize two arrays
    var ListOfPhotos:[UIImage] = []
    var ListOfFavs:[String]?
    var FavDetails:[String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 3) Comment out below lines
        //        navigationItem.leftBarButtonItem = editButtonItem
        //
        //        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        //        navigationItem.rightBarButtonItem = addButton
        //        if let split = splitViewController {
        //            let controllers = split.viewControllers
        //            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        //        }
        
        // 4) Add items to 2 arrays
        //Menus
        ListOfPhotos = [
            UIImage(named: "chevy.jpeg")!,
            UIImage(named: "ford.jpeg")!,
            UIImage(named: "chrysler.png")!,
            UIImage(named: "toyota.png")!,
            UIImage(named: "lexus.jpg")!,
            UIImage(named: "bmw.jpeg")!,
            UIImage(named: "honda.jpg")!,
            UIImage(named: "kia.jpeg")!,
            UIImage(named: "jaguar.png")!,
            UIImage(named: "audi.jpg")!,
            ]
        
        ListOfFavs = ["Chevrolet","Ford","Chrysler", "Toyota","Lexus","BMW","Honda", "Kia", "Jaguar","Audi"]
        FavDetails = ["http://www.chevrolet.com","http://www.ford.com","http://www.chrysler.com", "http://www.toyota.com","http://www.lexus.com/models","http://www.bmwusa.com","http://www.honda.com", "http://www.kia.com","http://www.jaguarusa.com","http://www.audiusa.com"]
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 5) Comment out func insertNewObject.
    //Select from line finc InsertNewObject to }
    //and use shortcut command: [Command] [/] to comment all lines
    
    //    func insertNewObject(_ sender: Any) {
    //        objects.insert(NSDate(), at: 0)
    //        let indexPath = IndexPath(row: 0, section: 0)
    //        tableView.insertRows(at: [indexPath], with: .automatic)
    //    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                // 6) replace code with below code until line 75
                let object = FavDetails![indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.weburl = (object as AnyObject as? String)!
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                controller.navigationItem.title = ListOfFavs![indexPath.row]
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 7) Replace objects.count with ListOfFavs!.count
        return ListOfFavs!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // 8) Replace code with below code until }
        cell.textLabel!.text = ListOfFavs![indexPath.row]
        let imagename:UIImage = ListOfPhotos[indexPath.row]
        cell.imageView?.image = imagename.resize(maxWidthHeight: 30)
        cell.detailTextLabel?.text = ">>"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        //9) Make below false
        return false
    }
    
    // 10) Comment out override func tableView(tableView  - shortcut command: [Command] [/]
    
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            objects.remove(at: indexPath.row)
    //            tableView.deleteRows(at: [indexPath], with: .fade)
    //        } else if editingStyle == .insert {
    //            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    //        }
    //    }
    
    
}
//10 Add image extension
extension UIImage {
    
    func resize(maxWidthHeight : Double)-> UIImage? {
        
        let actualHeight = Double(size.height)
        let actualWidth = Double(size.width)
        var maxWidth = 0.0
        var maxHeight = 0.0
        
        if actualWidth > actualHeight {
            maxWidth = maxWidthHeight
            let per = (100.0 * maxWidthHeight / actualWidth)
            maxHeight = (actualHeight * per) / 100.0
        }else{
            maxHeight = maxWidthHeight
            let per = (100.0 * maxWidthHeight / actualHeight)
            maxWidth = (actualWidth * per) / 100.0
        }
        
        let hasAlpha = true
        let scale: CGFloat = 0.0
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: maxWidth, height: maxHeight), !hasAlpha, scale)
        self.draw(in: CGRect(origin: .zero, size: CGSize(width: maxWidth, height: maxHeight)))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
}
