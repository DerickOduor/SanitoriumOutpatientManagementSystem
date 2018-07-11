import business.Records;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/AddToQueue")
public class AddToQueue extends HttpServlet {
    List<Records> recordsList=new ArrayList<>();
    String patientType="",regno="",staffId="",name="";
    int natId=0;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        int pat_id=Integer.parseInt(request.getParameter("pat_id"));

        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital", "root", "");
            Statement st=conn.createStatement();
            String qry="SELECT * FROM patients WHERE id='"+pat_id+"'";
            ResultSet rs_=st.executeQuery(qry);
            while(rs_.next()){
                recordsList.add(new Records(rs_.getInt(1),rs_.getString(2),rs_.getString(3),rs_.getString(5),rs_.getString(4),rs_.getString(10),rs_.getString(11),rs_.getString(12),rs_.getString(13),rs_.getString(7),rs_.getString(8),rs_.getString(9),rs_.getString(6),rs_.getString(14),rs_.getString(15),rs_.getInt(17),rs_.getString(16)));
            }
            for (Records r:recordsList) {
                patientType=r.getPatientType();
                regno=r.getRegno();
                natId=r.getNatId();
                name=r.getName();
                staffId=r.getStaffId();
            }
            //out.println("Received "+patientType+" "+pat_id);
            if(patientType.equalsIgnoreCase("")==false){
                if(patientType.equalsIgnoreCase("Student")){
                    Date now=new Date();
                    DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String qry2="INSERT INTO patients_history(name,regno,complains,prescription,additional_info,blood_pressure," +
                            "body_temperature,cause_of_visit,diagnosis,height,lab_exam,lab_result,served,weight,date_of_visit,natId,patientType," +
                            "underAge,staffId)values('"+name+"','"+regno+"','-','-','-','-','"+0+"','-','-','"+0+"','-','-','queue'," +
                            "'"+0+"','"+dateFormat.format(now)+"','"+0+"','Student','False','-')";
                    int i=st.executeUpdate(qry2);
                    if(i==1){
                        response.getWriter().write("queued");
                    }
                }else if(patientType.equalsIgnoreCase("Staff")){
                    Date now=new Date();
                    DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String qry2="INSERT INTO patients_history(name,regno,complains,prescription,additional_info,blood_pressure," +
                            "body_temperature,cause_of_visit,diagnosis,height,lab_exam,lab_result,served,weight,date_of_visit,natId,patientType," +
                            "underAge,staffId)values('"+name+"','-','-','-','-','-','"+0+"','-','-','"+0+"','-','-','queue'," +
                            "'"+0+"','"+dateFormat.format(now)+"','"+0+"','Staff','False','"+staffId+"')";
                    int i=st.executeUpdate(qry2);
                    if(i==1){
                        response.getWriter().write("queued");
                    }
                }else if(patientType.equalsIgnoreCase("Non-Student")){
                    Date now=new Date();
                    DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String qry2="INSERT INTO patients_history(name,regno,complains,prescription,additional_info,blood_pressure," +
                            "body_temperature,cause_of_visit,diagnosis,height,lab_exam,lab_result,served,weight,date_of_visit,natId,patientType," +
                            "underAge,staffId)values('"+name+"','-','-','-','-','-','"+0+"','-','-','"+0+"','-','-','queue'," +
                            "'"+0+"','"+dateFormat.format(now)+"','"+natId+"','Non-Student','False','-')";
                    int i=st.executeUpdate(qry2);
                    if(i==1){
                        response.getWriter().write("queued");
                    }
                }else if(patientType.equalsIgnoreCase("Underage")){
                    Date now=new Date();
                    DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String qry2="INSERT INTO patients_history(name,regno,complains,prescription,additional_info,blood_pressure," +
                            "body_temperature,cause_of_visit,diagnosis,height,lab_exam,lab_result,served,weight,date_of_visit,natId,patientType," +
                            "underAge,staffId)values('"+name+"','-','-','-','-','-','"+0+"','-','-','"+0+"','-','-','queue'," +
                            "'"+0+"','"+dateFormat.format(now)+"','"+0+"','Underage','True','-')";
                    int i=st.executeUpdate(qry2);
                    if(i==1){
                        response.getWriter().write("queued");
                    }
                }
            }else{
                response.getWriter().write("Received null");
            }
        }catch(Exception e){
            response.getWriter().write(e.getMessage());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //int pat_id=Integer.parseInt(request.getParameter("id"));
        response.getWriter().write(" Received");
    }
}
