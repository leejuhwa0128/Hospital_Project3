package com.hospital.vo;


	import java.sql.Date;

	public class FileVO {
	    private int fileId;             
	    private String refTable;        
	    private int refId;              
	    private String fileName;        
	    private String filePath;        
	    private String uploadedBy;     
	    private Date uploadedAt;       

	    // Getter & Setter
	    public int getFileId() {
	        return fileId;
	    }

	    public void setFileId(int fileId) {
	        this.fileId = fileId;
	    }

	    public String getRefTable() {
	        return refTable;
	    }

	    public void setRefTable(String refTable) {
	        this.refTable = refTable;
	    }

	    public int getRefId() {
	        return refId;
	    }

	    public void setRefId(int refId) {
	        this.refId = refId;
	    }

	    public String getFileName() {
	        return fileName;
	    }

	    public void setFileName(String fileName) {
	        this.fileName = fileName;
	    }

	    public String getFilePath() {
	        return filePath;
	    }

	    public void setFilePath(String filePath) {
	        this.filePath = filePath;
	    }

	    public String getUploadedBy() {
	        return uploadedBy;
	    }

	    public void setUploadedBy(String uploadedBy) {
	        this.uploadedBy = uploadedBy;
	    }

	    public Date getUploadedAt() {
	        return uploadedAt;
	    }

	    public void setUploadedAt(Date uploadedAt) {
	        this.uploadedAt = uploadedAt;
	    }

	    @Override
	    public String toString() {
	        return "FileVO{" +
	                "fileId=" + fileId +
	                ", refTable='" + refTable + '\'' +
	                ", refId=" + refId +
	                ", fileName='" + fileName + '\'' +
	                ", filePath='" + filePath + '\'' +
	                ", uploadedBy='" + uploadedBy + '\'' +
	                ", uploadedAt=" + uploadedAt +
	                '}';
	    }
	}

