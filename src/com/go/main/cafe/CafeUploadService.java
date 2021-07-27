package com.go.main.cafe;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class CafeUploadService {
	HttpServletRequest req = null;

	public CafeUploadService(HttpServletRequest req) {
		this.req = req;
	}

	public CafeDTO PhotoUpload() {
		// 1. 용량 제한 10MB 설정 (1byte 단위)
		int maxSize = 10 * 1024 * 1024;
		// 2. 저장경로 설정
		String uploadPath = "C:/img";
		// 3. 만약 없으면 생성
		File dir = new File(uploadPath);
		if (!dir.exists()) {
			System.out.println("폴더없음 폴더생성");
			dir.mkdir();
		}

		// 업로드된 파일을 저장할 저장소와 관련된 클래스
		DiskFileItemFactory fileItemFactory = new DiskFileItemFactory();
		fileItemFactory.setRepository(dir); // 업로드 된 파일을 저장할 위치를 File객체로 지정
		fileItemFactory.setSizeThreshold(maxSize); // 사이즈
		ServletFileUpload fileUpload = new ServletFileUpload(fileItemFactory);

		// 어레이리스트 생성
		String text = null;
		ArrayList<HashMap<String, Object>> maparr = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> map = null;
		// 삭제할 이미지 파일 넘버모음
		ArrayList<Integer> fileIdxs = new ArrayList<Integer>();
		CafeDTO dto = new CafeDTO();

		// 업로드 해봅시다
		try {
			List<FileItem> items = fileUpload.parseRequest(req);
			for (FileItem item : items) {
				if (item.isFormField()) { // 일반 파라미터받기
					text = item.getString("UTF-8");
					if (item.getFieldName().equals("cafeName")) {
						System.out.println("cafeName 파라미터 : " + text);
						dto.setCafeName(text);
					} else if (item.getFieldName().equals("cafeLocation")) {
						System.out.println("cafeLocation 파라미터 : " + text);
						dto.setCafeLocation(text);
					} else if (item.getFieldName().equals("cafeAddress")) {
						System.out.println("cafeAddress 파라미터 : " + text);
						dto.setCafeAddress(text);
					} else if (item.getFieldName().equals("cafePhone")) {
						System.out.println("cafePhone 파라미터 : " + text);
						dto.setCafePhone(text);
					} else if (item.getFieldName().equals("cafeDetail")) {
						System.out.println("cafeDetail 파라미터 : " + text);
						dto.setCafeDetail(text);
					} else if (item.getFieldName().equals("cafeTime")) {
						System.out.println("cafeTime 파라미터 : " + text);
						dto.setCafeTime(text);
					}else if (item.getFieldName().equals("ownerNo")) {
						System.out.println("onnerNo 파라미터 : " + text);
						dto.setOnnerNo(text);
					} else if (item.getFieldName().equals("parkingCheck")) {
						System.out.println("parkingCheck 파라미터 : " + text);
						dto.setParkingCheck(text);
					}else if (item.getFieldName().equals("petCheck")) {
						System.out.println("petCheck 파라미터 : " + text);
						dto.setPetCheck(text);
					}else if (item.getFieldName().equals("childCheck")) {
						System.out.println("childCheck 파라미터 : " + text);
						dto.setChildCheck(text);
					}else if (item.getFieldName().equals("rooftopCheck")) {
						System.out.println("rooftopCheck 파라미터 : " + text);
						dto.setRooftopCheck(text);
					}else if (item.getFieldName().equals("groupCheck")) {
						System.out.println("groupCheck 파라미터 : " + text);
						dto.setGroupCheck(text);
					}
					
				} 
			else { // 파일받기
				// 파일등록을 했다면
					if (!item.getName().equals("")) {
					File uploadFile = new File(uploadPath + "/" + item.getName());
					item.write(uploadFile);// 요게 업로드 되는거 (파일객체로 담자)
					// 이름바꾸기 배운거
					String oriFileName = item.getName();
					String[] fileSplit = item.getName().split("\\.");
					String newFileName = System.nanoTime() + "." + fileSplit[1];
					File oriName = new File(uploadPath + "/" + oriFileName);
					File newName = new File(uploadPath + "/" + newFileName);
					oriName.renameTo(newName);
					System.out.println("기존파일명 : " + oriFileName + " / " + "바뀐파일명 : " + newFileName);
					// 바뀐이름 map에 담기
					map = new HashMap<String, Object>();
					map.put("newFileName", newFileName);
					map.put("oriFileName", oriFileName);
					// 파일 이름이 잘 들어갔다면
					if (map.get("newFileName") != null) {
						maparr.add(map);
						}
					System.out.println("업로드 성공 !");
				}
			}
			}

//			// map안에 데이터가 잘 있다면
//			if (map != null) {
//				dto.setMaparr(maparr);
//			}
//			dto.setFileIdxs(fileIdxs);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

}
