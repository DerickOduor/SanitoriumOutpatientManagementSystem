package business;

import java.sql.Date;

public class LabExams {
    String lab_exam,lab_result,s_regno,s_name,doctor_name,lab_attendant_name;
    int id,lab_attendant_id,doctor_id,natId;
    String date_sent,time_completed,additional_info,status,staffId,patType;

    public LabExams() { }

    public LabExams(String lab_exam, String lab_result, String s_regno, String s_name, int doctor_id, String doctor_name, int lab_attendant_id, String lab_attendant_name, int id, String date_sent, String time_completed, String additional_info, String status, String staffId, int natId, String patType) {
        this.lab_exam = lab_exam;
        this.lab_result = lab_result;
        this.s_regno = s_regno;
        this.s_name = s_name;
        this.doctor_id = doctor_id;
        this.doctor_name = doctor_name;
        this.lab_attendant_id = lab_attendant_id;
        this.lab_attendant_name = lab_attendant_name;
        this.id = id;
        this.date_sent = date_sent;
        this.time_completed = time_completed;
        this.additional_info = additional_info;
        this.status = status;
        this.staffId = staffId;
        this.natId = natId;
        this.patType = patType;
    }

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    public int getNatId() {
        return natId;
    }

    public void setNatId(int natId) {
        this.natId = natId;
    }

    public String getPatType() {
        return patType;
    }

    public void setPatType(String patType) {
        this.patType = patType;
    }

    public String getAdditional_info() {
        return additional_info;
    }

    public void setAdditional_info(String additional_info) {
        this.additional_info = additional_info;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public String getS_regno() {
        return s_regno;
    }

    public void setS_regno(String s_regno) {
        this.s_regno = s_regno;
    }

    public String getS_name() {
        return s_name;
    }

    public void setS_name(String s_name) {
        this.s_name = s_name;
    }

    public int getDoctor_id() {
        return doctor_id;
    }

    public void setDoctor_id(int doctor_id) {
        this.doctor_id = doctor_id;
    }

    public String getDoctor_name() {
        return doctor_name;
    }

    public void setDoctor_name(String doctor_name) {
        this.doctor_name = doctor_name;
    }

    public int getLab_attendant_id() {
        return lab_attendant_id;
    }

    public void setLab_attendant_id(int lab_attendant_id) {
        this.lab_attendant_id = lab_attendant_id;
    }

    public String getLab_attendant_name() {
        return lab_attendant_name;
    }

    public void setLab_attendant_name(String lab_attendant_name) {
        this.lab_attendant_name = lab_attendant_name;
    }

    public String getDate_sent() {
        return date_sent;
    }

    public void setDate_sent(String date_sent) {
        this.date_sent = date_sent;
    }

    public String getTime_completed() {
        return time_completed;
    }

    public void setTime_completed(String time_completed) {
        this.time_completed = time_completed;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
