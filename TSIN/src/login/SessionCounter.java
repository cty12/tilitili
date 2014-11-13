package login; 

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener; 

public class SessionCounter extends HttpServlet implements HttpSessionListener {
	
    private static final long serialVersionUID = 1L;  
    private static int sessionCounter = 0;
    
    public SessionCounter() {
        System.out.println("OnlineCounter initialized.");
    }
    
    public void sessionCreated(HttpSessionEvent se) {
        sessionCounter ++;  
        System.out.println("session created:" + sessionCounter);
    }  
    public void sessionDestroyed(HttpSessionEvent se) { 
        sessionCounter--;  
        System.out.println("session destroyed");
    }
    
    public static int getSessionNum() {  
        return sessionCounter;  
    }
} 