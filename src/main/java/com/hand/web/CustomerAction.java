package com.hand.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.hand.entity.Customer;
import com.hand.service.CustomerService;
import com.hand.util.ResponseUtils;

@Controller
@RequestMapping("/customer")
public class CustomerAction {
	@Autowired
	private CustomerService customerService;
	
	@RequestMapping("view")
	public String view() {
		return "forward:/pages/login.jsp";
	}
	
	@RequestMapping("/listPage")
	public void listPage(HttpServletRequest request, HttpServletResponse response){
		String pageNum = request.getParameter("page");
		String pageSize = request.getParameter("rows");
		List<Customer> customers = customerService.listPage(pageNum, pageSize);
		String rows = new Gson().toJson(customers);
		JsonArray jsonArray = new JsonParser().parse(rows).getAsJsonArray();
		JsonObject jsonObject = new JsonObject();
		jsonObject.addProperty("total", customerService.count());
		jsonObject.add("rows", jsonArray);
		ResponseUtils.renderJson(response, jsonObject.toString());
	}
	
	@RequestMapping("/login")
	public String login(String username, String password,HttpServletRequest request){
		if( customerService.login(username, password) > 0 ){
			request.getSession().setAttribute("name", username);
			return "redirect:/pages/index.jsp";
		}
		return "forward:/pages/login.jsp";
	}
	
	@RequestMapping("/logout")
	public String logout(String username, String password,HttpServletRequest request){
			request.getSession().removeAttribute("name");
			return "redirect:/pages/login.jsp";
	}
	
	@RequestMapping("/saveOrUpdate")
	public String saveOrUpdate(Customer customer){
		customerService.saveOrUpdate(customer);
		return "redirect:/pages/index.jsp";
	}
	
	@RequestMapping("/delete")
	public void delete(Short customerId, HttpServletResponse response){
		JsonObject jsonObject = new JsonObject();
		try{
			if(customerService.delete(customerId) == 0 ){
				jsonObject.addProperty("msg", false);
			}
			else {
				jsonObject.addProperty("msg", true);
			}
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.addProperty("msg", false);		
		}
		ResponseUtils.renderJson(response, jsonObject.toString());
	}

	@RequestMapping("/get")
	public void get(Short customerId, HttpServletResponse response){
		Customer customer = customerService.get(customerId);
		String json = new Gson().toJson(customer);
		ResponseUtils.renderJson(response, json);
	}
}
