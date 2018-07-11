import business.Records;

import javax.servlet.RequestDispatcher;
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

@WebServlet("/NewRecord")
public class NewRecord extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out=response.getWriter();

        String name,regno,faculty,dept,course,relative,d_o_b,d_o_a,residence,home_address,visit_type,staffId,patientType,underage;
        int relative_phone,phone,natId;

        name=request.getParameter("name");
        regno=request.getParameter("regno");
        faculty=request.getParameter("faculty");
        dept=request.getParameter("dept");
        course=request.getParameter("course");
        relative=request.getParameter("relative");
        d_o_a=request.getParameter("d_o_a");
        d_o_b=request.getParameter("d_o_b");
        residence=request.getParameter("residence");
        home_address=request.getParameter("home_address");
        relative_phone=Integer.parseInt(request.getParameter("relative_phone"));
        phone=Integer.parseInt(request.getParameter("phone"));
        visit_type=request.getParameter("visit_type");
        patientType=request.getParameter("pat_type");
        staffId=request.getParameter("staff_id");
        natId=Integer.parseInt(request.getParameter("nat_id"));
        underage=request.getParameter("underage");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital", "root", "");

            if(visit_type.equalsIgnoreCase("First visit")&&patientType.equalsIgnoreCase("n_st")){
                String qry="INSERT INTO patients (regno,name,dob,phone,relative,relative_phone,residence,home_address,d_o_a,faculty,department" +
                        ",course,natId,patientType,Underage,staffId)VALUES('"+regno+"','"+name+"','"+d_o_b+"','"+phone+"','"+relative+"'," +
                        "'"+relative_phone+"','"+residence+"','"+home_address+"','"+d_o_a+"','"+faculty+"','"+dept+"','"+course+"','"+0+"','Student','True','N/A')";
                Statement st=conn.createStatement();
                int i=st.executeUpdate(qry);
                //out.println(i);
                Date now=new Date();
                DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                String qry_="INSERT INTO patients_history (name,regno,date_of_visit,served,complains,prescription,additional_info,blood_pressure,body_temperature," +
                        "cause_of_visit,diagnosis,height,lab_exam,lab_result,weight,natId,patientType,Underage,staffId)" +
                        "VALUES('"+name+"','"+regno+"','"+dateFormat.format(now)+"','queue','','','','','"+0+"','','','"+0+"','','','"+0+"','"+0+"','Student','True','N/A')";
                int j=st.executeUpdate(qry_);
                if(i==1&&j==1){

                    out.println("Good");
                    /*String sql_="SELECT * FROM patients";
                    Statement st_=conn.createStatement();
                    ResultSet rs_=st.executeQuery(sql_);
                    List<Records> recordsList=new ArrayList<>();
                    while (rs_.next()){
                        String date=rs_.getString(7);
                        recordsList.add(new Records(rs_.getString(2),rs_.getString(3),rs_.getString(5),rs_.getString(4),date,rs_.getString(11),rs_.getString(12),rs_.getString(13),rs_.getString(4),rs_.getString(5),rs_.getString(6),rs_.getString(12)));
                    }
                    request.setAttribute("recordsList",recordsList);

                    String url = "/records_home.jsp";
                    /*RequestDispatcher dispatcher =
                            getServletContext().getRequestDispatcher(url);
                    dispatcher.forward(request, response);*/
                }else{
                    out.println(i+" "+j);
                }
            }else if(visit_type.equalsIgnoreCase("First visit")&&patientType.equalsIgnoreCase("n_ch")){
                Date now=new Date();
                DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                String qry="INSERT INTO patients(regno,name,dob,phone,relative,relative_phone,residence,home_address,d_o_a," +
                        "faculty,department,course,patientType,underAge,staffId,natId)VALUES('-','"+name+"','"+d_o_b+"','"+0+"'," +
                        "'"+relative+"','"+home_address+"','"+d_o_a+"','-','-','-','Underage','True','-','-')";
                Statement st=conn.createStatement();
                int i=st.executeUpdate(qry);
                out.println(i);
            }

        }catch (Exception e){
            out.println(e.getMessage());
        }

        }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
