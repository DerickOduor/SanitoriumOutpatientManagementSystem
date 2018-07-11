/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.sql.*;
import java.util.*;


/**
 *
 * @author Derick Oduor
 */
@WebServlet("/complains")
public class complains extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out=response.getWriter();
        String complain=request.getParameter("complains");
        String additional_info=request.getParameter("additional_info");
        String regno=request.getParameter("regno");
        String patientType=request.getParameter("patType");
        //out.println(complain+" "+additional_info+" "+regno+" "+patientType);

        int j=0;
        
            try{
                Class.forName("com.mysql.jdbc.Driver");
            	Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");
                //Statement statement=conn.createStatement();
                //PreparedStatement pstmt=conn.prepareStatement("UPDATE patients_history SET additional_info=? WHERE regno=?");
                /*complains='"+complains+"',additional_info='"+additional_info+"'*/
                //pstmt.setString(1, complains);
                //Statement s=conn.createStatement();

                /*s.executeUpdate("UPDATE patients_history SET complains='General body weakness',additional_info='N/A' WHERE " +
                        "regno='S13/21417/17'");*/

                //Statement stmt=conn.createStatement();
                //stmt.executeUpdate("INSERT INTO patients_history (complains,additional_info)VALUES ('"+complain+"','"+additional_info+"')");
                /*stmt.executeUpdate("INSERT INTO patients_history(name, regno, complains, prescription, additional_info, blood_pressure, body_temperature, cause_of_visit," +
                        " diagnosis, height, lab_exam, lab_result, served, weight, date_of_visit) VALUES('Reams','S13/21418/14','Headache','Paracetamol','n/a','normal','36.8'," +
                        "'Sick','Headache due to tiredness','0.0','n/a','n/a','served','65.2','2017-12-12 15:23:56')");*/
                /*Statement st=null;
                st=conn.createStatement();*/
                PreparedStatement pst=null;

                if(patientType.equalsIgnoreCase("Student")){
                    pst=conn.prepareStatement("UPDATE patients_history SET complains=?,additional_info=? WHERE regno='"+regno+"' AND served='queue'");
                    //j=st.executeUpdate();
                }else if(patientType.equalsIgnoreCase("Staff")){
                    pst=conn.prepareStatement("UPDATE patients_history SET complains=?,additional_info=? WHERE staffId='"+regno+"' AND served='queue'");
                    //j=st.executeUpdate();
                }else if(patientType.equalsIgnoreCase("Non-student")){
                    pst=conn.prepareStatement("UPDATE patients_history SET complains=?,additional_info=? WHERE natId='"+regno+"' AND served='queue'");
                    //j=st.executeUpdate();
                }else if(patientType.equalsIgnoreCase("Underage")){
                    pst=conn.prepareStatement("UPDATE patients_history SET complains=?,additional_info=? WHERE name='"+regno+"' AND patientType='Underage' AND served='queue'");
                    //j=st.executeUpdate(");
                }
                pst.setString(1,complain);
                pst.setString(2,additional_info);
                j=pst.executeUpdate();

                /*pstmt.setString(1,additional_info);
                pstmt.setString(2, regno);
                int i=pstmt.executeUpdate();*/
                //statement.executeUpdate("UPDATE patients_history SET complains='a',additional_info='abc' WHERE regno='"+regno+"'");
                //statement.executeUpdate("INSERT INTO patients_history(name,regno)VALUES('derro','me123')");
                if(j==1){
                    //out.println("\nRow inserted "
                            //+complain+" "+additional_info+" pa "+j);
                    //RequestDispatcher dispatcher=getServletContext().getRequestDispatcher("patient.jsp?regno="+regno+"&patientType="+patientType);
                    //dispatcher.forward(request,response);
                    response.sendRedirect(response.encodeURL("patient.jsp?regno="+regno+"&patientType="+patientType+"&complainsUpdated=ok"));
                }else{
                    out.println("\nFailed to insert "
                            +complain+" "+additional_info+" "+j);
                }
                conn.close();
            }catch(Exception e){
                    out.println(e.getMessage()+" -> exception");
            }
        /*try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet complains</title>");            
            out.println("</head>");
            out.println("<body>"
            +complains+" "+additional_info);
            out.println("<h1>Servlet complains at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }*/
            out.close();
    }
}
