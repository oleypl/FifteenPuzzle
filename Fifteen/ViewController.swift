//
//  ViewController.swift
//  Fifteen
//
//  Created by Michal Olejniczak on 31/07/2020.
//  Copyright © 2020 Michal Olejniczak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var puzzle1: UIImageView!
    @IBOutlet weak var puzzle2: UIImageView!
    @IBOutlet weak var puzzle3: UIImageView!
    @IBOutlet weak var puzzle4: UIImageView!
    @IBOutlet weak var puzzle5: UIImageView!
    @IBOutlet weak var puzzle6: UIImageView!
    @IBOutlet weak var puzzle7: UIImageView!
    @IBOutlet weak var puzzle8: UIImageView!
    @IBOutlet weak var puzzle9: UIImageView!
    @IBOutlet weak var puzzle10: UIImageView!
    @IBOutlet weak var puzzle11: UIImageView!
    @IBOutlet weak var puzzle12: UIImageView!
    @IBOutlet weak var puzzle13: UIImageView!
    @IBOutlet weak var puzzle14: UIImageView!
    @IBOutlet weak var puzzle15: UIImageView!
    @IBOutlet weak var emptyPuzzle: UIImageView!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var loadImageButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    var puzzleList: [UIImageView?] = []
    var puzzleListShuffled: [UIImageView?] = []
    var location = CGPoint(x: 0, y: 0)
    var choosenPuzzle: UIImageView?
    var puzzleBeforeChoose: CGPoint?
    var movement: String?
    var emptyPoint: UIImageView?
    var fromChosenToEmpty: CGFloat?
    var pointsAfterShuffle: [CGPoint] = []
    var pointsBeforeShuffle: [CGPoint] = []
    var shuffled: Bool = false
    var imagePicker = UIImagePickerController()
    var timer: Timer!
    var count = 0
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first{
            puzzleList.forEach{ puzzle in
                if( puzzle!.frame.contains(touch.location(in: self.view)) ) {
                    if choosenPuzzle == nil{
                        choosenPuzzle = puzzle
                        puzzleBeforeChoose = puzzle?.center
                        movement = (movemenPermission(choosenPuzzle: self.choosenPuzzle!))
                    }
                    location = touch.location(in: self.view)
                }
            }
            
            if(movement == "UP"){
                if(location.y <= (choosenPuzzle?.center.y)! ){
                    if(location.y >= (emptyPoint?.center.y)!){
                        choosenPuzzle?.center.y = location.y
                    }else{
                        choosenPuzzle?.center.y = emptyPoint?.center.y as! CGFloat
                    }
                }
            }
            else if(movement == "DOWN"){
                if(location.y >= (choosenPuzzle?.center.y)!){
                    if(location.y <= (emptyPoint?.center.y)!){
                        choosenPuzzle?.center.y = location.y
                    }else{
                        choosenPuzzle?.center.y = emptyPoint?.center.y as! CGFloat
                    }
                }
            }
            else if(movement == "LEFT"){
                if(location.x <= (choosenPuzzle?.center.x)!){
                    if(location.x >= (emptyPoint?.center.x)!){
                        choosenPuzzle?.center.x = location.x
                    }else{
                        choosenPuzzle?.center.x = emptyPoint?.center.x as! CGFloat
                    }
                }
            }
            else if(movement == "RIGHT"){
                //                print("empty puzzle right")
                if(location.x >= (choosenPuzzle?.center.x)!){
                    if(location.x <= (emptyPoint?.center.x)!){
                        choosenPuzzle?.center.x = location.x
                    }else{
                        choosenPuzzle?.center.x = emptyPoint?.center.x as! CGFloat
                    }
                }
            }
        }
    }
    
    @IBAction func imageLoadAction(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(movement != nil){
            if(movement == "UP"){
                if((choosenPuzzle?.center.y)! - (emptyPoint?.center.y)!  > fromChosenToEmpty!/2 ){
                    choosenPuzzle?.center.y = puzzleBeforeChoose?.y as! CGFloat
                }else{
                    choosenPuzzle?.center.y = emptyPoint?.center.y as! CGFloat
                    emptyPoint?.center.y = puzzleBeforeChoose?.y as! CGFloat
                }
            }
            else if(movement == "DOWN"){
                if((emptyPoint?.center.y)! - (choosenPuzzle?.center.y)! > fromChosenToEmpty!/2 ){
                    choosenPuzzle?.center.y = puzzleBeforeChoose?.y as! CGFloat
                }else{
                    choosenPuzzle?.center.y = emptyPoint?.center.y as! CGFloat
                    emptyPoint?.center.y = puzzleBeforeChoose?.y as! CGFloat
                }
            }
            else if(movement == "LEFT"){
                if((choosenPuzzle?.center.x)! - (emptyPoint?.center.x)! > fromChosenToEmpty!/2 ){
                    choosenPuzzle?.center.x = puzzleBeforeChoose?.x as! CGFloat
                }else{
                    choosenPuzzle?.center.x = emptyPoint?.center.x as! CGFloat
                    emptyPoint?.center.x = puzzleBeforeChoose?.x as! CGFloat
                }
            }
            else if(movement == "RIGHT"){
                if((emptyPoint?.center.x)! - (choosenPuzzle?.center.x)! > fromChosenToEmpty!/2 ){
                    choosenPuzzle?.center.x = puzzleBeforeChoose?.x as! CGFloat
                }else{
                    choosenPuzzle?.center.x = emptyPoint?.center.x as! CGFloat
                    emptyPoint?.center.x = puzzleBeforeChoose?.x as! CGFloat
                }
            }
        }else{
            choosenPuzzle?.center = puzzleBeforeChoose!
        }
        
        if(shuffled){
            correctPuzzlesChecker()
        }
        
        choosenPuzzle = nil
        movement = nil
    }
    
    func correctPuzzlesChecker(){
        var index = 0
        var correct = 0
        
        puzzleList.forEach{ puzzle in
            if(puzzle?.center == pointsBeforeShuffle[index])
            {
                correct = correct + 1
            }
            index = index + 1
            
        }
        if(puzzleList[puzzleList.count-1]?.center == pointsBeforeShuffle.last )
        {
            correct = correct - 1
            
        }
            if(puzzleList.count-1 == correct && count != 0){
                self.infoLabel.text = "Time: " + String(self.count) + " .Push shuffle to start"
                stopTime()
                
                let refreshAlert = UIAlertController(title: "Congratulations!!!", message: "You win", preferredStyle: UIAlertController.Style.alert)
                refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .cancel, handler: { (action: UIAlertAction!) in
                    print("You win")
                    
                }))
                present(refreshAlert, animated: true, completion: nil)
            }
        progressBar.progress = Float(correct) / Float(15)
    }
    
    @IBAction func clearButtonAction(_ sender: Any) {
        var index = 0
        stopTime()
        self.infoLabel.text = "Push shuffle to start"

        puzzleList.forEach{ puzzle in
            puzzle?.center = pointsBeforeShuffle[index]
            index = index + 1
        }
        shuffled = false
        correctPuzzlesChecker()
    }
    
    @IBAction func shuffleAction(_ sender: Any) {
        clearButtonAction(sender)
        var index: Int = 0
        self.infoLabel.text = ""
        
        pointsAfterShuffle.removeAll()
        puzzleList.forEach{ puzzle in
            pointsAfterShuffle.append(puzzle!.center)
        }
        pointsAfterShuffle.shuffle()
        puzzleList.forEach{ puzzle in
            puzzle?.center = pointsAfterShuffle[index]
            index = index + 1
        }
        shuffled = true
        correctPuzzlesChecker()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(playTime), userInfo: nil, repeats: true)
    }
    
    @objc func playTime(){
        count += 1
        result.text = String(count)
    }
    
    func stopTime(){
        if timer != nil {
            timer!.invalidate()
            timer = nil
            result.text = String(0)
            count = 0
        }
    }
    
    func movemenPermission(choosenPuzzle: UIImageView ) ->String{
        puzzleList.forEach{ puzzle in
            if(puzzle == emptyPuzzle)
            {
                emptyPoint = puzzle
            }
        }
        
        if let calculatedDistance = fromChosenToEmpty{
            var upperPoint = CGPoint(x: choosenPuzzle.center.x , y: choosenPuzzle.center.y - calculatedDistance)
            var downPoint = CGPoint(x: choosenPuzzle.center.x , y: choosenPuzzle.center.y + calculatedDistance)
            var leftPoint = CGPoint(x: choosenPuzzle.center.x - calculatedDistance , y: choosenPuzzle.center.y)
            var rightPoint = CGPoint(x: choosenPuzzle.center.x + calculatedDistance , y: choosenPuzzle.center.y)
            
            
            if let point = emptyPoint{
                if(emptyPoint?.center == upperPoint ){
                    return "UP"
                }else if(emptyPoint?.center == downPoint){
                    return "DOWN"
                }else if(emptyPoint?.center == leftPoint){
                    return "LEFT"
                }else if(emptyPoint?.center == rightPoint){
                    return "RIGHT"
                }
            }
        }
        return "NO_MOVE"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        loadImageButton.layer.cornerRadius = 16
        shuffleButton.layer.cornerRadius = 16
        clearButton.layer.cornerRadius = 16
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 5)
        
        
        puzzleList = [puzzle1, puzzle2, puzzle3, puzzle4, puzzle5, puzzle6, puzzle7, puzzle8, puzzle9, puzzle10, puzzle11, puzzle12, puzzle13, puzzle14, puzzle15, emptyPuzzle]
        fromChosenToEmpty =  sqrt(pow(puzzleList[0]!.center.x - puzzleList[1]!.center.x, 2) + pow(puzzleList[0]!.center.y - puzzleList[1]!.center.y, 2))
        
        puzzleList.forEach{ puzzle in
            puzzle?.layer.cornerRadius = 3
            pointsBeforeShuffle.append(puzzle!.center)
        }
        
        print("distance between two puzzles")
        print(fromChosenToEmpty)
    }
}


extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true)
        
        let split = SplitImage()
        split.makeSplit(image: image)
        
        var index: Int = 0
        
        puzzleList.forEach{ puzzle in
            if( index != split.getImages16().count-1){
                puzzle?.image = split.getImages16()[index]
                index = index + 1
            }
        }
    }
    
}
