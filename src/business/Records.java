package business;

public class Records {
    private String name,phone,d_o_b,d_o_a,faculty,department,course,relative_phone,residence,home_address,relative,patientType,underage,staffId,regno;
    private int natId,id;

    public Records(int id, String name, String phone, String d_o_b, String d_o_a, String faculty, String department, String course, String relative_phone, String residence, String home_address, String relative) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.d_o_b = d_o_b;
        this.d_o_a = d_o_a;
        this.faculty = faculty;
        this.department = department;
        this.course = course;
        this.relative_phone = relative_phone;
        this.residence = residence;
        this.home_address = home_address;
        this.relative = relative;
    }

    public Records(int id,String regno, String name, String phone, String d_o_b, String d_o_a, String faculty, String department, String course, String relative_phone, String residence, String home_address, String relative, String patientType, String underage, int natId,String staffId) {
        this.id = id;
        this.regno=regno;
        this.name = name;
        this.phone = phone;
        this.d_o_b = d_o_b;
        this.d_o_a = d_o_a;
        this.faculty = faculty;
        this.department = department;
        this.course = course;
        this.relative_phone = relative_phone;
        this.residence = residence;
        this.home_address = home_address;
        this.relative = relative;
        this.patientType = patientType;
        this.underage = underage;
        this.natId = natId;
        this.staffId=staffId;
    }

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    public String getRegno() {
        return regno;
    }

    public void setRegno(String regno) {
        this.regno = regno;
    }

    public String getPatientType() {
        return patientType;
    }

    public void setPatientType(String patientType) {
        this.patientType = patientType;
    }

    public String getUnderage() {
        return underage;
    }

    public void setUnderage(String underage) {
        this.underage = underage;
    }

    public int getNatId() {
        return natId;
    }

    public void setNatId(int natId) {
        this.natId = natId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getD_o_b() {
        return d_o_b;
    }

    public void setD_o_b(String d_o_b) {
        this.d_o_b = d_o_b;
    }

    public String getD_o_a() {
        return d_o_a;
    }

    public void setD_o_a(String d_o_a) {
        this.d_o_a = d_o_a;
    }

    public String getFaculty() {
        return faculty;
    }

    public void setFaculty(String faculty) {
        this.faculty = faculty;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public String getRelative_phone() {
        return relative_phone;
    }

    public void setRelative_phone(String relative_phone) {
        this.relative_phone = relative_phone;
    }

    public String getResidence() {
        return residence;
    }

    public void setResidence(String residence) {
        this.residence = residence;
    }

    public String getHome_address() {
        return home_address;
    }

    public void setHome_address(String home_address) {
        this.home_address = home_address;
    }

    public String getRelative() {
        return relative;
    }

    public void setRelative(String relative) {
        this.relative = relative;
    }
}
