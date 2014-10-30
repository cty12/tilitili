package upload;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ProgressServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();

		HttpSession session = request.getSession(true);
		if (session == null) {
			out.println("Sorry, session is null"); // just to be safe
			return;
		}

		UploadProgressListener uploadProgressListener = (UploadProgressListener) session.getAttribute("uploadProgressListener");
		if (uploadProgressListener == null) {
			out.println("Progress listener is null");
			return;
		}

		out.println(uploadProgressListener.getMessage());

	}
}
