import business.Records;

import javax.servlet.RequestDispatcher;
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

@WebServlet("/Search")
public class Search extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession httpSession=request.getSession();
        PrintWriter out=response.getWriter();
        String search_key,search_type;
        search_key=request.getParameter("search_key");
        search_type=request.getParameter("search_type");
        httpSession.removeAttribute("search_key");

        if(search_type.equalsIgnoreCase("record")){
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");
                Statement st=conn.createStatement();
                ResultSet rs_=st.executeQuery("SELECT * FROM patients WHERE name LIKE '%"+search_key+"%' OR regno LIKE '%"+search_key+"%'");
                int countResults=0;
                List<Records> searchResults=new ArrayList<>();
                while (rs_.next()){
                    countResults+=1;
                    String date=rs_.getString(7);
                    searchResults.add(new Records(rs_.getInt(1),rs_.getString(2),rs_.getString(5),rs_.getString(4),date,rs_.getString(11),rs_.getString(12),rs_.getString(13),rs_.getString(14),rs_.getString(5),rs_.getString(6),rs_.getString(12)));
                }
                request.setAttribute("recordsList",searchResults);
                httpSession.setAttribute("search_key",search_key);

                String url = "/search_results.jsp";
                RequestDispatcher dispatcher =
                        getServletContext().getRequestDispatcher(url);
                dispatcher.forward(request, response);
            }catch (Exception e){
                out.println(e.getMessage());
            }
        }
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
