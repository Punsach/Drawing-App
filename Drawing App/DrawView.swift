//
//  Drawing.swift
//  Drawing App
//
//  Created by Puneet Sachdeva on 10/2/17.
//  Copyright © 2017 Puneet Sachdeva. All rights reserved.
//

import UIKit

class DrawView: UIView {
    var points = [CGPoint]()
    var penWidth:CGFloat = 50
    var penColor = UIColor.blue
    var path = UIBezierPath()
    
    var images: [UIImage?] = []
    var drawing: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        points.append(touches.first!.location(in: self))
        setNeedsDisplay()
        images.append(drawing)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            points.append(t.location(in: self))
        }
        setNeedsDisplay()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //https://stackoverflow.com/questions/30696307/how-to-convert-a-uiview-to-an-image
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        drawing = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        points.removeAll()
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.white.setFill()
        UIRectFill(rect)
        penColor.setStroke()
        path.fill()
        drawing?.draw(in: rect)
        path = createQuadPath(points: points)
        path.stroke()
        path.removeAllPoints()
    }
    
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        return CGPoint(x: (first.x + second.x)/2, y:(first.y + second.y)/2)
    }
    
    func undo(){
        if images.count != 0 {
            drawing = images.popLast()!
        }
        setNeedsDisplay()
    }
    
    func clear(){
        points.removeAll()
        drawing = nil
        setNeedsDisplay()
    }
    
    func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        //let path = UIBezierPath()
        if points.count < 2 { return path }
        if(penWidth == 0){
            path.lineWidth = 1.0
        }
        else{
            path.lineWidth = penWidth
        }
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        let firstPoint = points[0]
        let secondPoint = points[1]
        let firstMidpoint = midpoint(first: firstPoint, second: secondPoint)
        path.move(to: firstPoint)
        path.addLine(to: firstMidpoint)
        for index in 1 ..< points.count-1 {
            let currentPoint = points[index]
            let nextPoint = points[index + 1]
            let midPoint = midpoint(first: currentPoint, second: nextPoint)
            path.addQuadCurve(to: midPoint, controlPoint: currentPoint)
        }
        guard let lastLocation = points.last else { return path }
        path.addLine(to: lastLocation)
        return path
    }
}
