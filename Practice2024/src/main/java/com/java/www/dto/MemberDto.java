package com.java.www.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class MemberDto {

	private String id;
	private String pw;
	private int ymno;
	private String name;
	private String gender;
	private String phone;
	private String pnumber;
	private String email;
	private Timestamp birthdate;
	private String address;
	private String y_img;
	private int ypoint;
	private int login_num;
	private Timestamp ydate;
	private Timestamp recent_time;

}// MemberDto
