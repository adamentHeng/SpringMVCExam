package com.hand.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.resource.ResourceHttpRequestHandler;

public class LoginInterceptor implements HandlerInterceptor {

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		 if(handler instanceof ResourceHttpRequestHandler){
			            return true;
		  }

			if( request.getServletPath().startsWith("/customer/login") ||request.getServletPath().startsWith("/customer/view") || request.getSession().getAttribute("name")!= null ){
				return true;
			}		
			else{
				request.getRequestDispatcher("/customer/view").forward(request, response);
				//response.sendRedirect(request.getContextPath()+ "/login.jsp");	
			}
				
		return false;
	}

	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
	}

	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
	}

	
}
