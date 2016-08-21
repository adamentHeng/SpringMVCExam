package com.hand.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.dao.AddressMapper;
import com.hand.entity.Address;
import com.hand.entity.AddressExample;

@Service
public class AddressService {
	@Autowired
	private AddressMapper addressMapper;
	@Autowired
	private AddressExample addressExample;
	
	public List<Address> listPage(String pageNum, String pageSize){
		addressExample.clear();
		addressExample.setPaging(true);
		int num = pageNum == null ? 1 : Short.parseShort(pageNum);
		int size =  pageSize == null ? 10 : Short.parseShort(pageSize);
		addressExample.setPageNum( (num-1)*size);
		addressExample.setPageSize(size);
		return addressMapper.selectByExample(addressExample);
	}
	
	public Integer count(){
		return addressMapper.countByExample(null);
	}
	
	public List<Address> list(){
		return addressMapper.selectByExample(null);
	}
}
