package com.hand.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.hand.entity.Address;
import com.hand.service.AddressService;
import com.hand.util.ResponseUtils;

@Controller
@RequestMapping("/address")
public class AddressAction {
	@Autowired
	private AddressService addressService;
	
	@RequestMapping("/list")
	public void listPage(HttpServletRequest request, HttpServletResponse response){
		List<Address> address = addressService.list();
		String json = new Gson().toJson(address);
		ResponseUtils.renderJson(response, json);
	}
}
