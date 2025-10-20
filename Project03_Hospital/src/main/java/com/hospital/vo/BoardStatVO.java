package com.hospital.vo;

public class BoardStatVO {
	private String category;
	private int total;
	private int recent;

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getRecent() {
		return recent;
	}

	public void setRecent(int recent) {
		this.recent = recent;
	}

	@Override
	public String toString() {
		return "BoardStatVO [category=" + category + ", total=" + total + ", recent=" + recent + ", getCategory()="
				+ getCategory() + ", getTotal()=" + getTotal() + ", getRecent()=" + getRecent() + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}

}