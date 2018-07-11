import business.LabExams;
import business.Records;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.reflect.TypeToken;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/served")
public class served extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");
            String qry="SELECT * FROM patients_history WHERE served='served'";

            Statement st=connection.createStatement();
            ResultSet rs_=st.executeQuery(qry);

            //if(rs_.next()==true){
                List<Records> recordsList=new ArrayList<>();
                while (rs_.next()){
                    String date=rs_.getString(7);
                    recordsList.add(new Records(rs_.getInt(1),rs_.getString(2),rs_.getString(3),rs_.getString(5),rs_.getString(4),rs_.getString(10),rs_.getString(11),rs_.getString(12),rs_.getString(13),rs_.getString(7),rs_.getString(8),rs_.getString(9),rs_.getString(6),rs_.getString(14),rs_.getString(15),rs_.getInt(17),rs_.getString(16)));
                }
                request.setAttribute("recordsList",recordsList);
                String url = "/served_patients.jsp";
                RequestDispatcher dispatcher =
                        getServletContext().getRequestDispatcher(url);
                dispatcher.forward(request, response);
        }catch (Exception e){
            response.getWriter().write(e.getMessage());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");
            String qry="SELECT * FROM patients_history WHERE served='served'";

            Statement st=connection.createStatement();
            ResultSet rs_=st.executeQuery(qry);

            //if(rs_.next()==true){
            List<Records> recordsList=new ArrayList<>();
            while (rs_.next()){
                String date=rs_.getString(7);
                recordsList.add(new Records(rs_.getInt(1),rs_.getString(2),rs_.getString(3),rs_.getString(5),rs_.getString(4),rs_.getString(10),rs_.getString(11),rs_.getString(12),rs_.getString(13),rs_.getString(7),rs_.getString(8),rs_.getString(9),rs_.getString(6),rs_.getString(14),rs_.getString(15),rs_.getInt(17),rs_.getString(16)));
            }
            request.setAttribute("recordsList",recordsList);
            String url = "/served_patients.jsp";
            RequestDispatcher dispatcher =
                    getServletContext().getRequestDispatcher(url);
            dispatcher.forward(request, response);
        }catch (Exception e){
            response.getWriter().write(e.getMessage());
        }
    }
}
