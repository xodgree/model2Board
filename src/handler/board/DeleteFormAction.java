package handler.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;

public class DeleteFormAction implements CommandHandler{

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		int num = Integer.parseInt(req.getParameter("num"));
		String pageNum = req.getParameter("pageNum"); 
		
		req.setAttribute("num", num);
		req.setAttribute("pageNum", pageNum);

		return "/view/deleteForm.jsp";
	}

}
