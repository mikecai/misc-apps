package com.ibm.migr.misc.sessioncache.demo;

 

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 

/**
 * Servlet implementation class CounterServlet
 */
@WebServlet("/CounterServlet")
public class CounterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CounterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

 

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String hc_sess_id = null;
        String j_sess_id = null;
        Counter counter = null;
        String pod_name = "";
        
        HttpSession session = request.getSession(true);
        
        hc_sess_id = (String) session.getId();
        System.out.println("CounterServlet: Hazelcast Session ID = " + hc_sess_id);
        session.setAttribute("hc_sess_id", hc_sess_id);
        
        j_sess_id = (String) request.getRequestedSessionId();
        System.out.println("CounterServlet: JSessionID = " + j_sess_id);
        session.setAttribute("j_sess_id", j_sess_id);
        
        counter = (Counter) session.getAttribute("counter");
        
        pod_name = (String) System.getenv("MY_POD_NAME");
        System.out.println("CounterServlet: pod_name = " + pod_name);
        session.setAttribute("pod_name", pod_name);
        
        if (counter == null) {
            counter = new Counter();
        }
        session.setAttribute("counter", counter);
        System.out.println("CounterServlet: Counter = " + counter + "     {" + j_sess_id + "} {" + hc_sess_id + "}");
        
        String increment = request.getParameter("increment");
        if (increment != null) { 
            counter.increment(); 
            System.out.println("CounterServlet: count incremented     {" + j_sess_id + "} {" + hc_sess_id + "}");
        }
        
        String decrement = request.getParameter("decrement");
        if (decrement != null) { 
            counter.decrement(); 
            System.out.println("CounterServlet: count decremented     {" + j_sess_id + "} {" + hc_sess_id + "}");
        }
        
        String reset = request.getParameter("reset");
        if (reset != null) { 
            counter.reset(); 
            System.out.println("CounterServlet: count reset     {" + j_sess_id + "} {" + hc_sess_id + "}");
        }
        
        String invalidate = request.getParameter("invalidate");
        if (invalidate != null) { 
            session.invalidate(); 
            System.out.println("CounterServlet: session invalidated     {" + j_sess_id + "} {" + hc_sess_id + "}");
        }
        
        System.out.println("CounterServlet: current count = " + counter.getCount() + "     {" + j_sess_id + "} {" + hc_sess_id + "}");
        request.getRequestDispatcher("/index.jsp").forward(request, response);
        
    }

 

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

 

}