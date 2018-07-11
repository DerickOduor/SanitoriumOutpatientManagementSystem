package business;

public class RecordsOfficer {
    private String name,email,profile_url,department,position,status;
    private int id;


    public RecordsOfficer(String name, String email, String profile_url, String department, String position, String status, int id) {
        this.name = name;
        this.email = email;
        this.profile_url = profile_url;
        this.department = department;
        this.position = position;
        this.status = status;
        this.id = id;
    }

    public RecordsOfficer(String name, int id, String email) {
        this.email=email;
        this.id=id;
        this.name=name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getProfile_url() {
        return profile_url;
    }

    public void setProfile_url(String profile_url) {
        this.profile_url = profile_url;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
