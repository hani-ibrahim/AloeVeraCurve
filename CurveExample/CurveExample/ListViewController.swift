//
//  ListViewController.swift
//  CurveExample
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

final class ListViewController: UITableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Drawing Examples" : "Animation Examples"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? SampleCurve.allCases.count : SamplePolynomialCurve.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "drawingCell", for: indexPath)
            cell.textLabel?.text = SampleCurve.allCases[indexPath.row].title
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "animationCell", for: indexPath)
            cell.textLabel?.text = SamplePolynomialCurve.allCases[indexPath.row].title
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        if let viewController = segue.destination as? DrawingViewController {
            viewController.sampleCurve = SampleCurve.allCases[indexPath.row]
        } else if let viewController = segue.destination as? AnimationViewController {
            viewController.sampleCurve = SamplePolynomialCurve.allCases[indexPath.row]
        }
    }
}
