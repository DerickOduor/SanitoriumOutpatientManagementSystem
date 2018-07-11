import business.Records;
import com.sun.org.apache.regexp.internal.RE;

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
import java.util.concurrent.ArrayBlockingQueue;

import static java.lang.System.out;

@WebServlet("/records")
public class records extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        ArrayBlockingQueue<Records> patientsQueue;
        //out.println("Processing ..."+request.getParameter("name"));
        String name,regno,faculty,dept,course,relative,d_o_b,d_o_a,residence,home_address,visit_type;
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



        //out.println("Requsets-> "+name+" "+regno+" "+faculty+" "+dept+" "+course+" "+relative+" "+d_o_a+" "+d_o_b+" "+residence+" "+home_address+" "+relative_phone+" "+phone);

        /*if(!name.matches("[a-zA-Z]")){
            out.println("Invalid name");
        }else if(!(request.getParameter("phone")).matches("[0-9]")){
            out.println("Invalid phone");
        }else if(!faculty.matches("[a-zA-Z]")){
            out.println("invalid faculty");
        }else if (!dept.matches("[a-zA-Z]")){
            out.println("invalid dept");
        }else if(!course.matches("[a-zA-Z]")){
            out.println("invalid course");
        }else if(!relative.matches("[a-zA-Z]")){
            out.println("invalid relative");
        }else if(!residence.matches("[a-zA-Z]")){
            out.println("invalid residence");
        }else if(!home_address.matches("[a-zA-Z]")){
            out.println("invalid h_a");
        }else if(!(request.getParameter("relative_phone")).matches("[0-9]")){
            out.println("invalid r_p");
        }else if(visit_type.equalsIgnoreCase("First visit")){*/
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");
                String qry="INSERT INTO patients (regno,name,dob,phone,relative,relative_phone,residence,home_address,d_o_a,faculty,department,course)VALUES('"+regno+"','"+name+"','"+d_o_b+"','"+phone+"','"+relative+"','"+relative_phone+"','"+residence+"','"+home_address+"','"+d_o_a+"','"+faculty+"','"+dept+"','"+course+"')";
                Statement st=conn.createStatement();
                int i=st.executeUpdate(qry);
                //out.println(i);
                Date now=new Date();
                DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                String qry_="INSERT INTO patients_history (name,regno,date_of_visit,served,complains,prescription,additional_info,blood_pressure,body_temperature,cause_of_visit,diagnosis,height,lab_exam,lab_result,weight)" +
                        "VALUES('"+name+"','"+regno+"','"+dateFormat.format(now)+"','queue','','','','','"+0+"','','','"+0+"','','','"+0+"')";
                int j=st.executeUpdate(qry_);
                if(i==1&&j==1){

                    out.println("Good");
                    String sql_="SELECT * FROM patients";
                    Statement st_=conn.createStatement();
                    ResultSet rs_=st.executeQuery(sql_);
                    List<Records> recordsList=new ArrayList<>();
                    while (rs_.next()){
                        String date=rs_.getString(7);
                        recordsList.add(new Records(rs_.getInt(1),rs_.getString(3),rs_.getString(5),rs_.getString(4),date,rs_.getString(11),rs_.getString(12),rs_.getString(13),rs_.getString(4),rs_.getString(5),rs_.getString(6),rs_.getString(12)));
                    }
                    request.setAttribute("recordsList",recordsList);

                    String url = "/records_home.jsp";
                    RequestDispatcher dispatcher =
                            getServletContext().getRequestDispatcher(url);
                    dispatcher.forward(request, response);
                }else{
                    out.println(i+" "+j);
                }
            }catch (Exception e){
                out.println(e.getMessage());
            }
        /*}else if(visit_type.equalsIgnoreCase("Subsequent visit")){

        }*/

        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
