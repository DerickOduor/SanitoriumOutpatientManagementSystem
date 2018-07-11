import business.Doctor;
import business.LabExams;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.reflect.TypeToken;

@WebServlet("/Lab")
public class Lab extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        HttpSession session=request.getSession();
        Doctor doctor=(Doctor) session.getAttribute("logged_doctor");

        String lab_exam=request.getParameter("lab_exam");
        String additional_info=request.getParameter("additional_info");
        String regno=request.getParameter("regno");
        String name=request.getParameter("name");
        String doctor_id=request.getParameter("doctor_id");
        String doctor_name=request.getParameter("doctor_name");
        boolean process_lab=Boolean.parseBoolean((request.getParameter("process_lab")));
        response.setContentType("type/plain");

        if(process_lab==true&&!lab_exam.equals("")){
            response.getWriter().write("ok");
            /*try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");

                String sql="UPDATE patients_history SET lab_exam='"+lab_exam+"',served='lab' WHERE regno='"+regno+"'";

                Statement st=conn.createStatement();
                int i=st.executeUpdate(sql);

                Date now=new Date();
                DateFormat dateFormat=new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");

                String sql_="INSERT INTO lab (s_name,s_regno,doctor_id,doctor_name,labexam,additional_info,date_sent,labresult,lab_attendant_id,lab_attendant_name,time_completed)values(" +
                        "'"+name+"','"+regno+"','"+doctor_id+"','"+doctor_name+"','"+lab_exam+"','"+additional_info+"','"+dateFormat.format(now)+"'," +
                        "'','','','0000-00-00 00:00:00')";
                int j=st.executeUpdate(sql_);

                if(j==1&&i==1){
                    response.getWriter().write("ok");
                }else{
                    response.getWriter().write("Failed");
                }
            }catch (Exception e){
                response.getWriter().write(e.getMessage());
            }*/
        }else{
            response.getWriter().write("Failed");
        }



        /*
        response.getWriter().write("Received");*/

        if(!(request.getParameter("regno_in_lab")).equals("")){
            try{
                regno=request.getParameter("regno_in_lab");
                String patType=request.getParameter("patType");
                Class.forName("com.mysql.jdbc.Driver");
                Connection connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");
                String qry="";
                if(patType.equalsIgnoreCase("Student")){
                    qry="SELECT * FROM lab WHERE s_regno='"+request.getParameter("regno_in_lab")+"' AND status='done' AND doctor_id='"+doctor.getId()+"'";
                }else if(patType.equalsIgnoreCase("Staff")){
                    qry="SELECT * FROM lab WHERE staffId='"+request.getParameter("regno_in_lab")+"' AND status='done' AND doctor_id='"+doctor.getId()+"'";
                }else if(patType.equalsIgnoreCase("Non-student")){
                    qry="SELECT * FROM lab WHERE natId='"+request.getParameter("regno_in_lab")+"' AND status='done' AND doctor_id='"+doctor.getId()+"'";
                }else if(patType.equalsIgnoreCase("Underage")){
                    qry="SELECT * FROM lab WHERE name='"+request.getParameter("regno_in_lab")+"' AND status='done' AND doctor_id='"+doctor.getId()+"'";
                }
                Statement st=connection.createStatement();
                ResultSet rs=st.executeQuery(qry);
                response.getWriter().write("Lab results");

                List<LabExams> labResult=new ArrayList<>();
                while (rs.next()){
                    labResult.add(new LabExams(rs.getString(6),rs.getString(7),rs.getString(3),rs.getString(2),rs.getInt(4),
                            rs.getString(5),rs.getInt(9),rs.getString(10),rs.getInt(1),rs.getString(12),rs.getString(11),
                            rs.getString(8),rs.getString(13),rs.getString(14),rs.getInt(15),rs.getString(16)));
                    //labResult.add(new LabExams());
                    //labResult.add(new LabExams(rs.getString(6),rs.getString(7),rs.getString(3),rs.getString(2),rs.getString(4),rs.getString(5),rs.getString(9),rs.getString(10),rs.getInt(1),rs.getString(12),rs.getString(11),rs.getString(13),rs.getString(8),rs.getString(14),rs.getInt(15),rs.getString(16)));
                }
                /*if(labResult.size()!=0){
                    /*Gson gson=new Gson();
                    JsonElement element=gson.toJsonTree(labResult,new TypeToken<List<LabExams>>(){}.getType());
                    JsonArray jsonArray=element.getAsJsonArray();
                    response.setContentType("application/json");
                    response.getWriter().print(jsonArray);*/
                    /*response.getWriter().write("Lab results");
                }else{
                    response.getWriter().write("None");
                }*/
            }catch (Exception e){
                response.getWriter().write(e.getMessage());
            }
            //response.getWriter().write("Received!");
        }else if((request.getParameter("regno_in_lab")).equals("")){
            response.getWriter().write("Empty");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /*try{
            String regno="S11/14114/15";
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");
            String qry="SELECT * FROM lab WHERE s_regno='"+regno+"' AND status='pending'";

            Statement st=connection.createStatement();
            ResultSet rs=st.executeQuery(qry);

            List<LabExams> labResult=new ArrayList<>();
            labResult.clear();
            while (rs.next()){
                //labResult.add(new LabExams());
                labResult.add(new LabExams(rs.getString(6),rs.getString(7),rs.getString(3),rs.getString(2),rs.getString(4),rs.getString(5),rs.getString(9),rs.getString(10),rs.getString(12),rs.getString(11),rs.getInt(1)));
            }
            if(labResult.size()!=0){
                Gson gson=new Gson();
                JsonElement element=gson.toJsonTree(labResult,new TypeToken<List<LabExams>>(){}.getType());
                JsonArray jsonArray=element.getAsJsonArray();
                response.setContentType("application/json");
                response.getWriter().print(jsonArray);
            }else{
                response.getWriter().write("None");
            }
        }catch (Exception e){
            response.getWriter().write(e.getMessage());
        }*/
    }
}
