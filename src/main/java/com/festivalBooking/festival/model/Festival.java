package com.festivalBooking.festival.model;

import java.util.Date;

public class Festival {
	private int id;
	private int userId;
	private String title;
	private String date;
	private String startTime;
	private String endTime;
	private String place;
	private String address;
	private int price;
	private int priceOffline;
	private String imagePath;
	private String lineUp;
	private String explain;
	private String warning;
	private String festivalMaster;
	private String askRoot;
	private boolean isTimeOver;
	private Date createdAt;
	private Date updatedAt;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getPriceOffline() {
		return priceOffline;
	}
	public void setPriceOffline(int priceOffline) {
		this.priceOffline = priceOffline;
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public String getLineUp() {
		return lineUp;
	}
	public void setLineUp(String lineUp) {
		this.lineUp = lineUp;
	}
	public String getExplain() {
		return explain;
	}
	public void setExplain(String explain) {
		this.explain = explain;
	}
	public String getWarning() {
		return warning;
	}
	public void setWarning(String warning) {
		this.warning = warning;
	}
	public String getFestivalMaster() {
		return festivalMaster;
	}
	public void setFestivalMaster(String festivalMaster) {
		this.festivalMaster = festivalMaster;
	}
	public String getAskRoot() {
		return askRoot;
	}
	public void setAskRoot(String askRoot) {
		this.askRoot = askRoot;
	}
	public boolean isTimeOver() {
		return isTimeOver;
	}
	public void setTimeOver(boolean isTimeOver) {
		this.isTimeOver = isTimeOver;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	
	
}
