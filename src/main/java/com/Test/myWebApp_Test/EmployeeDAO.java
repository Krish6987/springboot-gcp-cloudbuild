package com.Test.myWebApp_Test;

import org.springframework.stereotype.Repository;


 
@Repository
public class EmployeeDAO
{
     static Employees list = new Employees();
     
    static
    {
        list.getEmployeeList().add(new Employee(1, "gandurisrinivas789@gmail.com", "Krish", "Krishna"));
        list.getEmployeeList().add(new Employee(2, "saitej123@gmail.com", "Tej", "Sai"));
        list.getEmployeeList().add(new Employee(3, "manikanta123@gmail.com", "kanta", "Mani"));
        list.getEmployeeList().add(new Employee(4, "aman123@gmail.com", "Roy", "Aman"));
    }
     
    public Employees getAllEmployees()
    {
        return list;
    }
     
    public void addEmployee(Employee employee) {
        list.getEmployeeList().add(employee);
    }
}
