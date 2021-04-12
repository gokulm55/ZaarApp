//
//  ReportsViewController.swift
//  ZaarApp
//
//  Created by apple on 08/04/21.
//

import UIKit
enum typeOption {
    case from
    case to
}
enum typeOfReport {
    case labor
    case inventory
    case equipment
}

struct ReportList {
    let empId: String?
    let date: String?
    let name: String?
    let shiftType: String?
}
struct ReportSection {
    let sectionHeader: String?
    let sectionList: [ReportList]
}
class ReportsViewController: UIViewController, UITextFieldDelegate {
    var pickerType: typeOption?
    @IBOutlet weak var fromDate: UITextField!
    @IBOutlet weak var toDate: UITextField!
    
    @IBOutlet weak var reportType: UITextField!
    @IBOutlet weak var reportTable: UITableView!
    
    var typeofReport: Int = 0
    
    var choosenFromDate = ""
    var choosenToDate = ""
    var shiftType = ""
    
    
    let datePicker = UIDatePicker()
    let pickerView = UIPickerView()
    let reportPicker = ["LABOR","INVENTORY","EQUIPMENT"]
    
    let viewModel: ReportViewModel = ReportViewModel()
    let productList: productListViewModel = productListViewModel()
    let code = UserDefaults.standard.value(forKey: "projectList")
    let id = UserService.instance.authToken
    
    
    
    
    var items: [ReportSection] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeData()
        addtap()
        
        if #available(iOS 13.4, *) {
                    datePicker.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePicker.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.preferredDatePickerStyle = .wheels
        }

        
        reportType.setLeftIcon(UIImage(systemName: "chevron.down")!.withRenderingMode(.alwaysOriginal))
        fromDate.setRightIcon(UIImage(systemName: "chevron.down")!.withRenderingMode(.alwaysOriginal))
        toDate.setRightIcon(UIImage(systemName: "chevron.down")!.withRenderingMode(.alwaysOriginal))
        fromDate.delegate = self
        toDate.delegate = self
        
        reportTable.delegate = self
        reportTable.dataSource = self
        
        datePicker.datePickerMode = .date
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        //            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onClickDoneButton))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        fromDate.inputAccessoryView = toolBar
        toDate.inputAccessoryView = toolBar
        
        print("projectCodeList", code)
        
        hideDetails()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "myBlueColor")!]

        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    func storeData(){
        let modelData = viewModel.ReportList.count
        print("count",modelData)
        
        
        items.append(ReportSection(sectionHeader: "May 22", sectionList: [
            ReportList(empId: "123", date: "april 15", name: "gokul", shiftType: "dayshift"),
            ReportList(empId: "123", date: "april 15", name: "gokul", shiftType: "dayshift"),
            ReportList(empId: "123", date: "april 15", name: "gokul", shiftType: "dayshift"),
            ReportList(empId: "123", date: "april 15", name: "gokul", shiftType: "dayshift"),
        ]))
        
    }
    func addtap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(openActionSheet))
        self.reportType.addGestureRecognizer(tap)
        
    }
    @objc func openActionSheet(){
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "LABOR", style: .default, handler: { [self] (_) in
            self.typeofReport = 1
            modelList{
                DispatchQueue.main.async {
                    reportTable.reloadData()
                }
            }
            self.reportTable.reloadData()
            self.reportType.text = "LABOR"
            //self.reportTable.isHidden = true
        }))
        sheet.addAction(UIAlertAction(title: "INVENTORY", style: .default, handler: { (_) in
            self.typeofReport = 2
            self.reportTable.reloadData()
            self.reportType.text = "INVENTORY"
            //self.reportTable.isHidden = false
        }))
        sheet.addAction(UIAlertAction(title: "EQUIPMENT", style: .default, handler: { [self] (_) in
            self.typeofReport = 3
            ActivityLoader.show()
            viewModel.getInventoryDataList(apiCode: id, projectCode: code as! String, fromDate: choosenFromDate, toDate: choosenToDate, success: {
                ActivityLoader.hide()
                reportTable.isHidden = false
                DispatchQueue.main.async { [self] in
                    reportTable.reloadData()
                    
                    print("equipmentLoaded")
                }
            }){ (error) in
                print(error)
                ActivityLoader.showError(message: error)
            }
            
            self.reportTable.reloadData()
            self.reportType.text = "EQUIPMENT"
            self.reportTable.isHidden = true
        }))
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            
        }))
        self.present(sheet, animated: true, completion: nil)
    }
    
    func modelList(completion: @escaping () -> Void){
        ActivityLoader.show()
        viewModel.getReportList(apiCode: id, projectCode: self.code as! String, fromDate: choosenFromDate, toDate: choosenToDate, success: { [self] in
            ActivityLoader.hide()
            reportTable.isHidden = false
            print("datasss",viewModel.ReportList.count)
            print("success")
            completion()
        }) { (error) in
            ActivityLoader.showError(message: error)
            print("controller",error)

        }
    }
    @objc func datePickerChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: sender.date)
        
        fromDate.text = date
        
        self.choosenFromDate = date
        print("date",self.choosenFromDate)
    }
    @objc func datePickerChangeEnd(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todate = formatter.string(from: sender.date)
        toDate.text = todate
        self.choosenToDate = todate
        print("todate", choosenToDate)
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.fromDate {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            textField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
            
        }else if textField == self.toDate{
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            textField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(datePickerChangeEnd(sender:)), for: .valueChanged)
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.fromDate {
            fromDate.resignFirstResponder()
        } else if textField == self.toDate{
            toDate.resignFirstResponder()
        }
        return true
        
    }
    @objc func onClickDoneButton() {
        self.view.endEditing(true)
    }
    func hideDetails(){
        reportTable.isHidden = true
    }
    
}
extension ReportsViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return 36
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your results"
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch typeofReport {
        case 1:
            return viewModel.ReportList.count
        case 2:
            return 0
        case 3:
            return viewModel.Equipment.count
        default:
            print("another")
            return 0
        }
//return viewModel.ReportList.count
    }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportViewCell", for: indexPath) as! ReportViewCell
        //let item = items[indexPath.section].sectionList[indexPath.row]
        
        switch typeofReport {
        case 1:
            let formatter = DateFormatter()
                formatter.locale = Locale.current
                formatter.setLocalizedDateFormatFromTemplate("MM/dd/yyyy")
                
            let dataModel = viewModel.ReportList[indexPath.row]
            if dataModel.shift == "0" {
                print("day shift",dataModel.shift)
                self.shiftType = "Day Shift"
                
            }else{
                print("night shift",dataModel.shift)
                self.shiftType = "Night Shift"
            }
           let date =  myFormatter(date: dataModel.updatedOn)
            cell.nameLabel.text = dataModel.messageDescription
            cell.dateLabel.text = date
            cell.shiftTypeLabel.text = shiftType
            
        case 2:
            let dataModel = viewModel.ReportList[indexPath.row]
            cell.nameLabel.text = dataModel.messageDescription
            cell.dateLabel.text = dataModel.updatedOn
            cell.shiftTypeLabel.text = dataModel.shift
        case 3:
            
            let dataModel = viewModel.Equipment[indexPath.row]
            let date =  myFormatter(date: dataModel.updatedOn)
            
            cell.nameLabel.text = dataModel.companyName
            cell.dateLabel.text = date
            cell.shiftTypeLabel.text = ""
       
        default:
            print("no data")
        }
        
        return cell
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
//        headerView.backgroundColor = UIColor(named: "myBlueColor")
//                return headerView
//    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(named: "myBlueColor")
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "reportDetails", sender: nil)
    }


   // reportDetails
    
}
extension UITextField{

    func setRightIcon(_ image: UIImage) {

        let imageView = UIImageView(frame: CGRect(x: 5, y: 10, width: 16, height: 10))
        imageView.image = image
        let iconContainer: UIView = UIView(frame: CGRect(x: 5, y: 0, width: 30, height: 30))
        iconContainer.addSubview(imageView)
        self.rightView = iconContainer
        self.rightViewMode = .always
    }
    func setLeftIcon(_ image: UIImage) {

        let imageView = UIImageView(frame: CGRect(x: 5, y: 10, width: 16, height: 10))
        imageView.image = image
        let iconContainer: UIView = UIView(frame: CGRect(x: 5, y: 0, width: 30, height: 30))
        iconContainer.addSubview(imageView)
        self.leftView = iconContainer
        self.leftViewMode = .always
    }}

extension Date {
    func today(format : String = "YYYY-MM-dd'T'HH:mm:ss.SSS") -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
