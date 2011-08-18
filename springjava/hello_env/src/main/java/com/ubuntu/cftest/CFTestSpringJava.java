package com.ubuntu.cftest;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CFTestSpringJava
 */
public class CFTestSpringJava extends HttpServlet {
        private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CFTestSpringJava() {
        super();
    }

        /**
         * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
         */
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                response.setContentType("text/plain");
                response.setStatus(200);
                PrintWriter writer = response.getWriter();
                writer.println("Hello from the cloud");
                for ( String cur_var : System.getenv().keySet())
                {
                        writer.println(cur_var + " " +  System.getenv(cur_var));
                }
                writer.close();
        }
}

