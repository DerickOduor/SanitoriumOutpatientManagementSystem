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

@WebServlet("/NewStudentRecord")
public class NewStudentRecord extends HttpServlet {
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
        //d_o_a=request.getParameter("d_o_a");
        d_o_b=request.getParameter("d_o_b");
        residence=request.getParameter("residence");
        home_address=request.getParameter("home_address");
        relative_phone=Integer.parseInt(request.getParameter("relative_phone"));
        phone=Integer.parseInt(request.getParameter("phone"));
        visit_type=request.getParameter("visit_type");
        patientType=request.getParameter("pat_type");
        //staffId=request.getParameter("staff_id");
        //natId=Integer.parseInt(request.getParameter("nat_id"));
        underage=request.getParameter("underage");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital", "root", "");

            if(visit_type.equalsIgnoreCase("First visit")&&patientType.equalsIgnoreCase("n_st")){
                Date now=new Date();
                DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                String qry="INSERT INTO patients(regno,name,dob,phone,relative,relative_phone,residence,home_address,d_o_a," +
                        "faculty,department,course,patientType,underAge,staffId,natId)VALUES('"+regno+"','"+name+"','"+d_o_b+"','"+phone+"'," +
                        "'"+relative+"','"+relative_phone+"','-','"+home_address+"','"+dateFormat.format(now)+"','"+faculty+"','"+dept+"'," +
                        "'"+course+"','Student','False','-','"+0+"')";
                Statement st=conn.createStatement();
                int i=st.executeUpdate(qry);

                String qry2="INSERT INTO patients_history(name,regno,complains,prescription,additional_info,blood_pressure," +
                        "body_temperature,cause_of_visit,diagnosis,height,lab_exam,lab_result,served,weight,date_of_visit,natId,patientType," +
                        "underAge,staffId)values('"+name+"','"+regno+"','-','-','-','-','"+0+"','-','-','"+0+"','-','-','queue'," +
                        "'"+0+"','"+dateFormat.format(now)+"','"+0+"','Student','False','-')";
                int j=st.executeUpdate(qry2);
                if(i==1&&j==1){
                    String qry3="SELECT * FROM patients ORDER BY id DESC";
                    ResultSet rs_=st.executeQuery(qry3);
                    List<Records> recordsList=new ArrayList<>();
                    while (rs_.next()){
                        String date=rs_.getString(7);
                        recordsList.add(new Records(rs_.getInt(1),rs_.getString(2),rs_.getString(3),rs_.getString(5),rs_.getString(4),rs_.getString(10),rs_.getString(11),rs_.getString(12),rs_.getString(13),rs_.getString(7),rs_.getString(8),rs_.getString(9),rs_.getString(6),rs_.getString(14),rs_.getString(15),rs_.getInt(17),rs_.getString(16)));
                    }
                    request.setAttribute("recordsList",recordsList);

                    String url = "/records_home.jsp";
                    RequestDispatcher dispatcher =
                            getServletContext().getRequestDispatcher(response.encodeURL(url));
                    dispatcher.forward(request, response);
                }
                //out.println(i+" "+j);
            }else if(visit_type.equalsIgnoreCase("First visit")&&patientType.equalsIgnoreCase("n_")){

            }

        }catch (Exception e){
            out.println(e.getMessage());
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
