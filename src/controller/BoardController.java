package controller;

import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import controller.NullHandler;

public class BoardController  extends HttpServlet {

    //Map ��ü�� ����. (string =>/board/list,CommandHandler => handler.board.ListAction )
	// ��ɾ�� ��ɾ� ó�� Ŭ������ ������ ����. /board/list�� �ϸ� ListAction���� ��.
    private Map<String, CommandHandler> commandHandlerMap = new HashMap<>();
    
    //init() �޼��� = ��ü ���� �� �ʱ�ȭ �۾�. (���� ��û�ø� ���� ��ü �����ϰ�, ���� ��û�� �տ� ���� ��ü�� ����Ѵ�.)
    //������ �ʱ�ȭ �Ҷ� ���.
    public void init() throws ServletException {
        //configFile  �ʱ�ȭ �Ķ������ ���� �о�´�.
    	String configFile = getInitParameter("configFile");
        Properties prop = new Properties();
        
        //�о�� ���� �̿��ؼ� ���� ���� ��θ� ���Ѵ�.
        String configFilePath = getServletContext().getRealPath(configFile);
        
        /*���� ���Ϸκ��� ���� ������ �о�� Properties ��ü�� �����Ѵ�. Properties��(�̸�,��)����� ���� Ŭ�����μ�,
           	�� ��� ���� ������Ƽ  �̸��� Ŀ�ǵ� �̸����� ����ϰ� ���� Ŭ���� �̸����� ����Ѵ�.
        */
        try (FileReader fis = new FileReader(configFilePath)) {
            //Properties�� load()�޼��带 ����ϸ� ���� ���Ϸκ��� ������Ƽ ������ �о�ü��ִ�.
        	prop.load(fis);
        } catch (IOException e) {
            throw new ServletException(e);
        }
        
        /*
         * Properties�� ����� �� ������Ƽ�� Ű�� ���� ���� �۾��� �ݺ��Ѵ�.
         * 1.������Ƽ �̸��� Ŀ�ǵ� �̸����� ����Ѵ�.
         * 
         * */
        Iterator keyIter = prop.keySet().iterator();
        while (keyIter.hasNext()) {
        	// 1.������Ƽ �̸��� Ŀ�ǵ� �̸����� ����Ѵ�.
            String command = (String) keyIter.next();
            
            // 2.Ŀ�ǵ� �̸��� �ش��ϴ� �ڵ鷯 Ŭ���� �̸��� Properties���� ���Ѵ�.
            String handlerClassName = prop.getProperty(command);
            
            try {
            	// 3. �ڵ鷯 Ŭ���� �̸��� �̿��ؼ� Class��ü�� ���Ѵ�.
                Class<?> handlerClass = Class.forName(handlerClassName);
                
                // 4. Class�κ��� �ڵ鷯 ��ü�� �����Ѵ�. ��, 2�� �������� ���� �̸��� �ش��ϴ� Ŭ������ ��ü�� �����Ѵ�.
                CommandHandler handlerInstance = (CommandHandler) handlerClass.newInstance();
                
                // 5. commandHandlerMap�� (Ŀ�ǵ�, �ڵ鷯 ��ü)���� ������ �����Ѵ�.
                commandHandlerMap.put(command, handlerInstance);
                
            } catch (ClassNotFoundException | InstantiationException 
            		| IllegalAccessException e) {
                throw new ServletException(e);
            }
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        process(request, response);
    }

    protected void doPost(HttpServletRequest request,
    HttpServletResponse response) throws ServletException, IOException {
        process(request, response);
    }

    private void process(HttpServletRequest request,
    HttpServletResponse response) throws ServletException, IOException {
    	
    	
        String command = request.getRequestURI();
        
        if (command.indexOf(request.getContextPath())==0) {
        	command = command.substring(request.getContextPath().length());
        }
        
        //���� ���μ���
        //commandHandlerMap���� ��û�� ó���� �ڵ鷯 ��ü�� ���Ѵ�. cmd �Ķ���� ���� Ű�� ����Ѵ�.
        CommandHandler handler = commandHandlerMap.get(command);
        
        //��ɾ �ش��ϴ� �ڵ鷯 ��ü�� �������� ���� ��� NullHandler�� ����Ѵ�. NullHandlerŬ������ 404������ �������� �����ϴ� �ڵ鷯 Ŭ������.
        if(handler ==null) {
        	handler = new NullHandler();
        }
        String viewPage = null;
        try {
        	// �� �ּ��� �� process �����϶�. �����ϰ� viewPage ����
        	/*
        	 * ���� �ڵ鷯 ��ü�� process()�޼��带 ȣ���ؼ� ��û�� ó���ϰ�, ����� ������ �� ������ ��θ� ���� ������ ���޹޴´�.
        	 * �ڵ鷯 �ν��Ͻ��� handler��  process()�޼ҵ�� Ŭ���̾�Ʈ�� ��û�� �˸°� ó���� ��, �� �������� ������ ������� 
        	 * request�� session�� �Ӽ��� �����ؾ� �Ѵ�.
        	 * */
            viewPage = handler.process(request, response);
            
        } catch (Throwable e) {
            throw new ServletException(e);
        }
        // viewPage�� null�� �ƴ� ���, �ڵ鷯 �ν��Ͻ��� ������ �� �������� �̵��Ѵ�.
        if (viewPage != null) {
	        RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
	        dispatcher.forward(request, response);
        }
    }
}
