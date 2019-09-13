package com.ibm.migr.misc.sessioncache.demo;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Enumeration;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class WhatTimeNow
 */
@WebServlet("/WhatTimeNow")
public class WhatTimeNow extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WhatTimeNow() {
        super();
        // TODO Auto-generated constructor stub
    }


    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        final String RESP_STRING_ATTR_NAME = "RESP_STRING";
        
        HttpSession session = request.getSession(true);
        
        System.out.println("WhatTimeNow.doGet(): ------------------------------ HEADER BEGIN ------------------------------");
        Enumeration<String> names = request.getHeaderNames();
        while (names.hasMoreElements()) {
            String name = (String) names.nextElement();
            Enumeration<String> values = request.getHeaders(name);  // support multiple values
            if (values != null) {
                while (values.hasMoreElements()) {
                    String value = values.nextElement();
                    System.out.println("WhatTimeNow.doGet(): " + name + ": " + value);
                }
            }
        }
        System.out.println("WhatTimeNow.doGet(): ------------------------------ HEADER END ------------------------------");
              
        String respStr = "";
        if (session.getAttribute(RESP_STRING_ATTR_NAME) != null) {
            respStr = (String) session.getAttribute(RESP_STRING_ATTR_NAME);
        }
        
        String podName = "";
        if (System.getenv("MY_POD_NAME") != null && !System.getenv("MY_POD_NAME").equals("")) {
            podName = System.getenv("MY_POD_NAME");
        }
        
        if (System.getenv("MY_POD_NAME_") != null && !System.getenv("MY_POD_NAME_").equals("")) {
            podName = System.getenv("MY_POD_NAME_");
        }
        
        PrintWriter out = response.getWriter();
        
        Date date = new Date();
        respStr += "pod_name=" + podName + " date_time=" + date.toString() + "\n";
        session.setAttribute(RESP_STRING_ATTR_NAME, respStr);
        
        System.out.println("WhatTimeNow.doGet(): current date_time: pod_name=" + podName + " date_time=" + date.toString() + "\n");
        out.append(respStr);
        
    }


    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }


}
