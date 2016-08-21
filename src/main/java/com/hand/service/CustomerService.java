package com.hand.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.dao.CustomerMapper;
import com.hand.entity.Customer;
import com.hand.entity.CustomerExample;

@Service
public class CustomerService {
	@Autowired
	private CustomerMapper customerMapper;
	@Autowired
	private CustomerExample customerExample;
	
	public List<Customer> listPage(String pageNum, String pageSize){
		customerExample.clear();
		customerExample.setPaging(true);
		int num = pageNum == null ? 1 : Short.parseShort(pageNum);
		int size =  pageSize == null ? 10 : Short.parseShort(pageSize);
		customerExample.setPageNum( (num-1)*size);
		customerExample.setPageSize(size);
		return customerMapper.selectByExample(customerExample);
	}
	
	public Integer count(){
		return customerMapper.countByExample(null);
	}
	
	public int login(String username, String password){
		customerExample.clear();
		customerExample.createCriteria().andFirstNameEqualTo(username);
		return customerMapper.countByExample(customerExample);
	}
	
	public void saveOrUpdate(Customer customer){
		customer.setStoreId((byte) 1);
		if(customer.getCustomerId() != null ){
			customerMapper.updateByPrimaryKeySelective(customer);
		}
		else{
			customerMapper.insertSelective(customer);
		}
	}
	
	public int delete(Short customerId)throws Exception{
		return customerMapper.deleteByPrimaryKey(customerId);
	}
	
	public Customer get(Short customerId){
		return customerMapper.selectByPrimaryKey(customerId);
	}
}
