package com.iforum.model;
import java.io.Serializable;

public class Student implements Serializable{
    
    private int id;
    private String matricnum;
    private String fullname;
    private String program;
    private String intakesession;
    private String status;

    public Student(int id, String matricnum, String fullname, String program, String intakesession, String status) {
        this.id = id;
        this.matricnum = matricnum;
        this.fullname = fullname;
        this.program = program;
        this.intakesession = intakesession;
        this.status = status;
    }
    
    public Student() {
        
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMatricnum() {
        return matricnum;
    }

    public void setMatricnum(String matricnum) {
        this.matricnum = matricnum;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getProgram() {
        return program;
    }

    public void setProgram(String program) {
        this.program = program;
    }

    public String getIntakesession() {
        return intakesession;
    }

    public void setIntakesession(String intakesession) {
        this.intakesession = intakesession;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
