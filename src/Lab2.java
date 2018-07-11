import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/Lab2")
public class Lab2 extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out=response.getWriter();

        String lab_exam=request.getParameter("lab_exam");
        String additional_info=request.getParameter("additional_info");
        String regno=request.getParameter("regno");
        String name=request.getParameter("name");
        String patType=request.getParameter("patType");
        String doctor_id=request.getParameter("doctor_id");
        String doctor_name=request.getParameter("doctor_name");
        boolean process_lab=Boolean.parseBoolean((request.getParameter("process_lab")));
        response.setContentType("type/plain");

        String sql="",sql_="";
        Date now=new Date();
        DateFormat dateFormat=new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");

        if(process_lab==true&&!lab_exam.equals("")){
            //response.getWriter().write("ok");
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");

                if(patType.equalsIgnoreCase("Student")){
                    sql="UPDATE patients_history SET lab_exam='"+lab_exam+"',served='lab' WHERE regno='"+regno+"' AND served='queue'";
                    sql_="INSERT INTO lab (s_name,s_regno,doctor_id,doctor_name,labexam,additional_info,date_sent,labresult,lab_attendant_id,lab_attendant_name,time_completed,patType," +
                            "staffId,natId)values(" +
                            "'"+name+"','"+regno+"','"+doctor_id+"','"+doctor_name+"','"+lab_exam+"','"+additional_info+"','"+dateFormat.format(now)+"'," +
                            "'','','','2018-01-01 00:00:00','Student','-','"+0+"')";
                }else if(patType.equalsIgnoreCase("Non-Student")){
                    sql="UPDATE patients_history SET lab_exam='"+lab_exam+"',served='lab' WHERE natId='"+regno+"' AND served='queue'";
                    sql_="INSERT INTO lab (s_name,s_regno,doctor_id,doctor_name,labexam,additional_info,date_sent,labresult,lab_attendant_id,lab_attendant_name,time_completed,patType," +
                            "staffId,natId)values(" +
                            "'"+name+"','-','"+doctor_id+"','"+doctor_name+"','"+lab_exam+"','"+additional_info+"','"+dateFormat.format(now)+"'," +
                            "'','','','2018-01-01 00:00:00','Non-Student','-','"+regno+"')";
                }else if(patType.equalsIgnoreCase("Staff")){
                    sql="UPDATE patients_history SET lab_exam='"+lab_exam+"',served='lab' WHERE staffId='"+regno+"' AND served='queue'";
                    sql_="INSERT INTO lab (s_name,s_regno,doctor_id,doctor_name,labexam,additional_info,date_sent,labresult,lab_attendant_id,lab_attendant_name,time_completed,patType," +
                            "staffId,natId)values(" +
                            "'"+name+"','"+regno+"','"+doctor_id+"','"+doctor_name+"','"+lab_exam+"','"+additional_info+"','"+dateFormat.format(now)+"'," +
                            "'','','','2018-01-01 00:00:00','Staff','"+regno+"','-')";
                }else if(patType.equalsIgnoreCase("Underage")){
                    sql="UPDATE patients_history SET lab_exam='"+lab_exam+"',served='lab' WHERE name='"+regno+"'AND served='queue'";
                    sql_="INSERT INTO lab (s_name,s_regno,doctor_id,doctor_name,labexam,additional_info,date_sent,labresult,lab_attendant_id,lab_attendant_name,time_completed,patType," +
                            "staffId,natId)values(" +
                            "'"+name+"','"+regno+"','"+doctor_id+"','"+doctor_name+"','"+lab_exam+"','"+additional_info+"','"+dateFormat.format(now)+"'," +
                            "'','','','2018-01-01 00:00:00','Underage','-','"+0+"')";
                }

                Statement st=conn.createStatement();
                int i=st.executeUpdate(sql);

                /*String sql_="INSERT INTO lab (s_name,s_regno,doctor_id,doctor_name,labexam,additional_info,date_sent,labresult,lab_attendant_id,lab_attendant_name,time_completed)values(" +
                        "'"+name+"','"+regno+"','"+doctor_id+"','"+doctor_name+"','"+lab_exam+"','"+additional_info+"','"+dateFormat.format(now)+"'," +
                        "'','','','2018-01-01 00:00:00')";*/
                int j=st.executeUpdate(sql_);

                if(j==1&&i==1){
                    response.getWriter().write("ok");
                }else{
                    response.getWriter().write(regno+" Failed->"+i+" "+j);
                }
            }catch (Exception e){
                response.getWriter().write(e.getMessage());
            }
        }else{
            response.getWriter().write("Failed>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
