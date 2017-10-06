//
//  ViewController.swift
//  Drawing App
//
//  Created by Puneet Sachdeva on 10/2/17.
//  Copyright © 2017 Puneet Sachdeva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var myView: DrawView!

    @IBAction func updateGreen(_ sender: Any) {
        newColor()
    }
    @IBAction func updateBlue(_ sender: Any){
        newColor()
    }
    @IBAction func updateRed(_ sender: Any) {
        newColor()
    }
    
    func newColor(){
        myView.penColor = UIColor(red: CGFloat(blueSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
    }
    @IBAction func undoLast(_ sender: Any) {
        myView.undo()
    }
    @IBAction func clearDrawing(_ sender: Any) {
        myView.clear()
    }
    @IBAction func changeSize(_ sender: UISlider) {
        myView.penWidth = CGFloat(100 * sender.value)
    }
    @IBAction func erase(_ sender: Any) {
        myView.penColor = UIColor.white
    }
    @IBAction func changePurple(_ sender: Any) {
        myView.penColor = UIColor.purple
    }
    @IBAction func changeBlue(_ sender: Any) {
        myView.penColor = UIColor.blue
    }
    @IBAction func changeGreen(_ sender: Any) {
        myView.penColor = UIColor.green
    }
    @IBAction func changeYellow(_ sender: Any) {
        myView.penColor = UIColor.yellow
    }
    @IBAction func changeOrange(_ sender: Any) {
        myView.penColor = UIColor.orange
    }
    @IBAction func changeRed(_ sender: Any) {
        myView.penColor = UIColor.red
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

