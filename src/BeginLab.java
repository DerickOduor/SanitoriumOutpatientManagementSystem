import business.LabOfficer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;

@WebServlet("/BeginLab")
public class BeginLab extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session=request.getSession();
        LabOfficer labOfficer=(LabOfficer)session.getAttribute("logged_lab_tech");
        String lab_exam=request.getParameter("lab_exam"),begin_lab=request.getParameter("begin_lab"),lab_tech_name=labOfficer.getName();
        int id=Integer.parseInt(request.getParameter("lab_id")),lab_tech_id=labOfficer.getId();
        if(begin_lab.equalsIgnoreCase("yes")){
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");
                PreparedStatement st=conn.prepareStatement("UPDATE lab SET status=?,lab_attendant_id=?,lab_attendant_name=? WHERE id=?");
                st.setString(1,"processing");
                st.setInt(2,lab_tech_id);
                st.setString(3,lab_tech_name);
                st.setInt(4,id);
                int i=st.executeUpdate();
                if(i==1){
                    response.getWriter().write("Status updated!");
                }else{
                    response.getWriter().write("Error!");
                }
            }catch (Exception e){
                response.getWriter().write(e.getMessage());
            }
        }else{
            response.getWriter().write("received no!");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
