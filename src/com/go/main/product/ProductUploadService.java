package com.go.main.product;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ProductUploadService {

	private HttpServletRequest req = null;

	public ProductUploadService(HttpServletRequest req) {
		this.req = req;
	}

	public ProductDTO PhotoUpload() {
		// 프로젝트 내 업로드 폴더 경로 얻기
		String uploadImgPath = req.getSession().getServletContext().getRealPath("uploadImg");
		String uploadImgPath2 = uploadImgPath.substring(0, uploadImgPath.indexOf("\\.metadata") + 1);
		System.out.println(uploadImgPath2);
		String uploadPath = uploadImgPath2 + "Project\\WebContent\\uploadImg";
		
		int maxSize = 10 * 1024 * 1024;// 2. 용량제한(10MB)
		ProductDTO dto = new ProductDTO();

		try {
			File dir = new File(uploadPath);
			if (!dir.exists()) {
				dir.mkdir();
			}
			MultipartRequest multi = new MultipartRequest(req, uploadPath, maxSize, "UTF-8",
					new DefaultFileRenamePolicy());
			dto = new ProductDTO();
			String productName = multi.getParameter("productName");
			String categoryName = multi.getParameter("categoryName");
			int productQuantity = Integer.parseInt(multi.getParameter("productQuantity"));
			int Price = Integer.parseInt(multi.getParameter("Price"));
			String explanation = multi.getParameter("explanation");
			String selCheck = multi.getParameter("selCheck");
			String oriFileName = multi.getFilesystemName("photo");

			dto.setProductName(productName);
			dto.setCategoryName(categoryName);
			dto.setProductQuantity(productQuantity);
			dto.setPrice(Price);
			dto.setExplanation(explanation);
			dto.setSelCheck(selCheck);

			if (oriFileName != null) {
				// adb.jpg => .을 기준으로 나누어서 썼다.(split)
				// adb.jpg =>
				String ext = oriFileName.substring(oriFileName.lastIndexOf("."));// .이 발견되는것부터
				String newFileName = System.currentTimeMillis() + ext;
				File oldname = new File(uploadPath +"\\"+ oriFileName);
				File newname = new File(uploadPath +"\\"+ newFileName);
				oldname.renameTo(newname);

				dto.setOriFileName(oriFileName);
				dto.setNewFileName(newFileName);

			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return dto;
	}

}
