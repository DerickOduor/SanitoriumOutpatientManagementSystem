import business.RecordsOfficer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import static java.lang.System.out;

@WebServlet("/Logout")
public class Logout extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        out.println("Processing ...");
        HttpSession httpSession=request.getSession();
        String l="";
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        //out.println("Processing ...");
        HttpSession httpSession=request.getSession();
        String l="";
        Enumeration parameterNames=request.getParameterNames();
        if(parameterNames.hasMoreElements()==true) {
            while (parameterNames.hasMoreElements()) {
                String parameterName = (String) parameterNames.nextElement();
                l = request.getParameter(parameterName);
                //out.println(l);
            }
            httpSession.removeAttribute(l);
            String url = "/index.jsp";
            RequestDispatcher dispatcher =
                    getServletContext().getRequestDispatcher(url);
            dispatcher.forward(request, response);
        }else{
            out.println("Invalid request! Contact system administrator.");
        }
        out.close();
    }
}
