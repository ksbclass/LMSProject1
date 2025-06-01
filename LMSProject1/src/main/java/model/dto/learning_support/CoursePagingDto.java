package model.dto.learning_support;

import model.dto.professor_support.PaginationDto;

public class CoursePagingDto {
	
	private SearchDto searchDto;
	private PaginationDto paginationDto;
	
	public SearchDto getSearchDto() {
		return searchDto;
	}
	public void setSearchDto(SearchDto searchDto) {
		this.searchDto = searchDto;
	}
	public PaginationDto getPaginationDto() {
		return paginationDto;
	}
	public void setPaginationDto(PaginationDto paginationDto) {
		this.paginationDto = paginationDto;
	}
	
	
}