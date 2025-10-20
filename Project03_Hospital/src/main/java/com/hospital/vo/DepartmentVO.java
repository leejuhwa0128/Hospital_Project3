package com.hospital.vo;

import java.util.Date;
import java.util.List;

public class DepartmentVO {
    private String deptId;
    private String name;                // 진료과명
    private String description;         // 과 소개
    private String headDoctorid;        // 과장 의사 ID
    private String phone;
    private Date createdAt;
    
    private String intro;         // 과 소개
    private String mainDiseases;  // 주요 진료 질환(콤마 구분)


    // 추가 필드
    private String locationGuide;       // 위치 안내
    private List<String> diseases;      // 주요 진료 질환
    private String mapImagePath;        // 위치 안내 지도 이미지 경로
    
    

    // Getter/Setter
    public String getDeptId() {
        return deptId;
    }
    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public String getHeadDoctorid() {
        return headDoctorid;
    }
    public void setHeadDoctorid(String headDoctorid) {
        this.headDoctorid = headDoctorid;
    }
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public Date getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getLocationGuide() {
        return locationGuide;
    }
    public void setLocationGuide(String locationGuide) {
        this.locationGuide = locationGuide;
    }
    public List<String> getDiseases() {
        return diseases;
    }
    public void setDiseases(List<String> diseases) {
        this.diseases = diseases;
    }
    public String getMapImagePath() {
        return mapImagePath;
    }
    public void setMapImagePath(String mapImagePath) {
        this.mapImagePath = mapImagePath;
    }
    
    public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public String getMainDiseases() {
		return mainDiseases;
	}
	public void setMainDiseases(String mainDiseases) {
		this.mainDiseases = mainDiseases;
	}
	@Override
    public String toString() {
        return "DepartmentVO{" +
                "deptId='" + deptId + '\'' +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", headDoctorid='" + headDoctorid + '\'' +
                ", phone='" + phone + '\'' +
                ", createdAt=" + createdAt +
                ", locationGuide='" + locationGuide + '\'' +
                ", diseases=" + diseases +
                ", mapImagePath='" + mapImagePath + '\'' +
                '}';
    }
}
