package business;

public class Patient {
    private int id,natId;
    private String name,regno,complains,prescription,additional_info,blood_pressure,cause_of_visit,diagnosis;
    private double height,weight,body_temperature;
    private String lab_exam,lab_result,served,date_of_visit,patientType,underAge,staffId;

    public Patient(int id, int natId, String name, String regno, String complains, String prescription, String additional_info, String blood_pressure, String cause_of_visit, String diagnosis, double height, double weight, double body_temperature, String lab_exam, String lab_result, String served, String date_of_visit, String patientType, String underAge, String staffId) {
        this.id = id;
        this.natId = natId;
        this.name = name;
        this.regno = regno;
        this.complains = complains;
        this.prescription = prescription;
        this.additional_info = additional_info;
        this.blood_pressure = blood_pressure;
        this.cause_of_visit = cause_of_visit;
        this.diagnosis = diagnosis;
        this.height = height;
        this.weight = weight;
        this.body_temperature = body_temperature;
        this.lab_exam = lab_exam;
        this.lab_result = lab_result;
        this.served = served;
        this.date_of_visit = date_of_visit;
        this.patientType = patientType;
        this.underAge = underAge;
        this.staffId = staffId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNatId() {
        return natId;
    }

    public void setNatId(int natId) {
        this.natId = natId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRegno() {
        return regno;
    }

    public void setRegno(String regno) {
        this.regno = regno;
    }

    public String getComplains() {
        return complains;
    }

    public void setComplains(String complains) {
        this.complains = complains;
    }

    public String getPrescription() {
        return prescription;
    }

    public void setPrescription(String prescription) {
        this.prescription = prescription;
    }

    public String getAdditional_info() {
        return additional_info;
    }

    public void setAdditional_info(String additional_info) {
        this.additional_info = additional_info;
    }

    public String getBlood_pressure() {
        return blood_pressure;
    }

    public void setBlood_pressure(String blood_pressure) {
        this.blood_pressure = blood_pressure;
    }

    public String getCause_of_visit() {
        return cause_of_visit;
    }

    public void setCause_of_visit(String cause_of_visit) {
        this.cause_of_visit = cause_of_visit;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public double getHeight() {
        return height;
    }

    public void setHeight(double height) {
        this.height = height;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public double getBody_temperature() {
        return body_temperature;
    }

    public void setBody_temperature(double body_temperature) {
        this.body_temperature = body_temperature;
    }

    public String getLab_exam() {
        return lab_exam;
    }

    public void setLab_exam(String lab_exam) {
        this.lab_exam = lab_exam;
    }

    public String getLab_result() {
        return lab_result;
    }

    public void setLab_result(String lab_result) {
        this.lab_result = lab_result;
    }

    public String getServed() {
        return served;
    }

    public void setServed(String served) {
        this.served = served;
    }

    public String getDate_of_visit() {
        return date_of_visit;
    }

    public void setDate_of_visit(String date_of_visit) {
        this.date_of_visit = date_of_visit;
    }

    public String getPatientType() {
        return patientType;
    }

    public void setPatientType(String patientType) {
        this.patientType = patientType;
    }

    public String getUnderAge() {
        return underAge;
    }

    public void setUnderAge(String underAge) {
        this.underAge = underAge;
    }

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }
}
