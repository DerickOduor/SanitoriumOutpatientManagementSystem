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
import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/EnterLabResults")
public class EnterLabResults extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        String lab_results=request.getParameter("lab_results");
        int id=Integer.parseInt(request.getParameter("id"));
        Date now=new Date();
        DateFormat dateFormat=new SimpleDateFormat("yy-MM-dd HH-mm-ss");
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");
            PreparedStatement st=conn.prepareStatement("UPDATE lab SET status=?,labresult=?,time_completed=? WHERE id=?");
            st.setString(1,"done");
            st.setString(2,lab_results);
            st.setString(3,dateFormat.format(now));
            st.setInt(4,id);
            int i=st.executeUpdate();
            if(i==1){
                String url="/done_exams.jsp";
                RequestDispatcher dispatcher =
                        getServletContext().getRequestDispatcher(response.encodeURL(url));
                dispatcher.forward(request, response);
                //out.println("Lab results updated!");
            }else{
                out.println("Error!");
            }
        }catch (Exception e){
            response.getWriter().write(e.getMessage());
        }
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
