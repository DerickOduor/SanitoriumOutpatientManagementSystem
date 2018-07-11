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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CheckLabResults")
public class CheckLabResults extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        HttpSession session=request.getSession();
        Doctor doctor=(Doctor) session.getAttribute("logged_doctor");
        String regno="";

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
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
