package model.dto.professor_support;

public class PaginationDto {
	
	private String professorId;
	private int currentPage;        // 현재 페이지 번호
    private int totalRows;          // 총 로우 수
    private int itemsPerPage;       // 페이지당 로우 수(기본값:10)
    private int totalPages;         // 총 페이지 수
    private int offset; 			// 페이지조회시 시작할 지점
    private String search;   		// 검색 키워드 
    private String sortDirection;   // 정렬방향
    private String urlPattern;      // 페이지 이동 URL 패턴 (예: /board?page=)
    
    public PaginationDto() {
    	this.itemsPerPage = 10;
	}
    
	public String getProfessorId() {
		return professorId;
	}
	public void setProfessorId(String professorId) {
		this.professorId = professorId;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getTotalRows() {
		return totalRows;
	}
	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}
	public int getItemsPerPage() {
		return itemsPerPage;
	}
	public void setItemsPerPage(int itemsPerPage) {
		this.itemsPerPage = itemsPerPage;
	}
	public int getTotalPages() {
		return totalPages;
	}
	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	public String getSearch() {
		return search;
	}
	public void setSearch(String search) {
		this.search = search;
	}
	public String getSortDirection() {
		return sortDirection;
	}
	public void setSortDirection(String sortDirection) {
		this.sortDirection = sortDirection;
	}
	public String getUrlPattern() {
		return urlPattern;
	}
	public void setUrlPattern(String urlPattern) {
		this.urlPattern = urlPattern;
	}
	
	@Override
	public String toString() {
		return "PagenationDto [professorId=" + professorId + ", currentPage=" + currentPage + ", totalRows=" + totalRows
				+ ", itemsPerPage=" + itemsPerPage + ", totalPages=" + totalPages + ", offset=" + offset + ", search="
				+ search + ", sortDirection=" + sortDirection + ", urlPattern=" + urlPattern + "]";
	}
    
    

	
    
    
}