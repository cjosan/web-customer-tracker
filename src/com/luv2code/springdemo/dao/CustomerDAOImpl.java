package com.luv2code.springdemo.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.luv2code.springdemo.entity.Customer;

@Repository
public class CustomerDAOImpl implements CustomerDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public List<Customer> getCustomers() {
		
		Session currentSession = sessionFactory.getCurrentSession();
		
		Query<Customer> query = currentSession.createQuery("from Customer order by lastName", Customer.class);
		
		List<Customer> customers = query.getResultList();
		
		return customers;
	}

	@Override
	public void saveCustomer(Customer customer) {
		
		Session currentSession = sessionFactory.getCurrentSession();
		
		currentSession.saveOrUpdate(customer);
	}

	@Override
	public Customer getCustomer(int customerId) {
		
		Session currentSession = sessionFactory.getCurrentSession();
		
		Customer customer = currentSession.get(Customer.class, customerId);
		
		return customer;
	}

	@Override
	public void deleteCustomer(int customerId) {
		
		Session currentSession = sessionFactory.getCurrentSession();
		
		Query query = currentSession.createQuery("delete from Customer where id = :customerId");
		query.setParameter("customerId", customerId);
		
		query.executeUpdate();
	}

	@Override
	public List<Customer> searchCustomers(String searchName) {
		
		Session currentSession = sessionFactory.getCurrentSession();
		
		if (searchName != null && searchName.trim().length() > 0) {

            // search for firstName or lastName ... case insensitive
			Query<Customer> query = currentSession.createQuery("from Customer where lower(firstName) like :name or lower(lastName) like :name", Customer.class);
			query.setParameter("name", "%" + searchName.toLowerCase() + "%");
			
			return query.getResultList();
        }
        
		return getCustomers();
	}

}
