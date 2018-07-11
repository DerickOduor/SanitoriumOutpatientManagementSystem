import business.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.Principal;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/Login")
public class Login extends HttpServlet {
    HttpSession httpSession;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        PrintWriter out=response.getWriter();

        httpSession=request.getSession();
        //out.println(username+" "+password);

        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");
            String sql = "SELECT * FROM employees WHERE email='"+username+"'AND password='"+password+"'";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            int count = 0;
            String logged_email="";
            int logged_id=0;
            String logged_name="";
            String logged_profile_pic="";
            String department="";
            String position="";
            String status_="";
            //out.println(rs.next());
            /*if(rs.next()==false){
                response.sendRedirect("index.jsp");+
            }*/
                while(rs.next()){
                    count++;
                    logged_email =rs.getString(3);
                    logged_id=Integer.parseInt(rs.getString(1));
                    logged_name=rs.getString(2);
                    logged_profile_pic=rs.getString(5);
                    department=rs.getString(6);
                    position=rs.getString(7);
                    status_=rs.getString(8);
                    out.println(logged_email+" "+logged_id+" "+logged_name);

                    if(position.equalsIgnoreCase("Doctor")){
                        //out.println(position);
                        //httpSession.invalidate();
                        httpSession.removeAttribute("logged_doctor");
                        Doctor doctor=new Doctor(logged_name,logged_email,logged_profile_pic,department,position,status_,logged_id);
                        httpSession.setAttribute("logged_doctor",doctor);
                        //request.setAttribute("user", doctor);

                        String url = "/home.jsp";
                        RequestDispatcher dispatcher =
                                getServletContext().getRequestDispatcher(url);
                        dispatcher.forward(request, response);
                    }else if(position.equalsIgnoreCase("Records Officer")){
                        httpSession.removeAttribute("logged_records_officer");
                        RecordsOfficer recordsOfficer=new RecordsOfficer(logged_name,logged_email,logged_profile_pic,department,position,status_,logged_id);
                        httpSession.setAttribute("logged_records_officer",recordsOfficer);
                        //request.setAttribute("user", doctor);

                        String sql_="SELECT * FROM patients ORDER BY id DESC";
                        Statement st_=conn.createStatement();
                        ResultSet rs_=st.executeQuery(sql_);
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
                    }/*else if(position.equalsIgnoreCase("Nurse")){
                        out.println(position);
                    }else if(position.equalsIgnoreCase("Pharmacist")){
                        out.println(position);
                    }*/else if(position.equalsIgnoreCase("Lab Technician")){
                        //out.println(position);
                        httpSession.removeAttribute("logged_lab_tech");
                        LabOfficer labOfficer=new LabOfficer(logged_name,logged_email,logged_profile_pic,department,position,status_,logged_id);
                        httpSession.setAttribute("logged_lab_tech",labOfficer);

                        sql="SELECT * FROM lab where status='pending' ORDER BY date_sent DESC";
                        rs=st.executeQuery(sql);
                        List<LabExams> labExamsList=new ArrayList<>();
                        while(rs.next()){
                            labExamsList.add(new LabExams(rs.getString(6),rs.getString(7),rs.getString(3),rs.getString(2),rs.getInt(4),
                                    rs.getString(5),rs.getInt(9),rs.getString(10),rs.getInt(1),rs.getString(12),rs.getString(11),
                                    rs.getString(8),rs.getString(13),rs.getString(14),rs.getInt(15),rs.getString(16)));
                        }
                        //out.print(labExamsList);
                        request.setAttribute("labExamsList",labExamsList);
                        String url = "/lab_home.jsp";
                        RequestDispatcher dispatcher =
                                getServletContext().getRequestDispatcher(response.encodeURL(url));
                        dispatcher.forward(request, response);
                    }else{
                        //response.sendRedirect("index.jsp");
                    }
                }
                /*if(count==0){
                    response.sendRedirect("index.jsp");
                }*/
        }catch(Exception e){
            out.println(e.getMessage()+" -> Exception");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
