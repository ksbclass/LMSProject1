package controller.board;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


@WebServlet(urlPatterns = {"/post/uploadImage", "/notice/uploadImage"})
@MultipartConfig
public class UploadImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "dist/assets/upload";

    public UploadImageServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("file");
        String fileName = getFileName(filePart);

        if (fileName == null || fileName.isEmpty()) {
            response.setContentType("text/plain; charset=UTF-8");
            response.getWriter().write("파일 업로드 실패");
            return;
        }

        String savedFileName = UUID.randomUUID().toString() + getFileExtension(fileName);

        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String filePath = uploadPath + File.separator + savedFileName;
        filePart.write(filePath);

        String fileUrl = request.getContextPath() + "/" + UPLOAD_DIR + "/" + savedFileName;
        response.setContentType("text/plain; charset=UTF-8");
        response.getWriter().write(fileUrl);
    }

    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    private String getFileExtension(String fileName) {
        if (fileName == null || fileName.lastIndexOf(".") == -1) {
            return "";
        }
        return fileName.substring(fileName.lastIndexOf("."));
    }
}