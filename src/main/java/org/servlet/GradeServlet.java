package org.servlet;

import org.ejbService.GradeService;
import org.model.grade;
import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.json.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/grades")
public class GradeServlet extends HttpServlet {

    @EJB
    private GradeService gradeService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String studentId = req.getParameter("studentId");
        resp.setContentType("application/json");
        if(studentId != null){
            List<grade> grades = gradeService.findByStudent(Long.valueOf(studentId));
            JsonArrayBuilder arr = Json.createArrayBuilder();
            for(grade g : grades){
                arr.add(Json.createObjectBuilder()
                        .add("id", g.getId())
                        .add("studentId", g.getStudentId())
                        .add("courseId", g.getCourseId())
                        .add("grade", g.getGrade()));
            }
            resp.getWriter().write(arr.build().toString());
        } else {
            resp.getWriter().write("{\"error\":\"Missing studentId\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");

        JsonObject json = Json.createReader(req.getInputStream()).readObject();

        // Validare câmpuri
        if (!json.containsKey("studentId") || !json.containsKey("courseId") || !json.containsKey("grade")) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"error\":\"Missing studentId, courseId or grade\"}");
            return;
        }

        try {
            long studentId = json.getJsonNumber("studentId").longValue();
            long courseId = json.getJsonNumber("courseId").longValue();
            double gradeValue = json.getJsonNumber("grade").doubleValue();

            grade g = new grade();
            g.setStudentId(studentId);
            g.setCourseId(courseId);
            g.setGrade(gradeValue);

            gradeService.create(g);

            resp.getWriter().write("{\"message\":\"Grade created\",\"id\":" + g.getId() + "}");
        } catch (NullPointerException | ClassCastException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"error\":\"Invalid number format for studentId, courseId or grade\"}");
        }
    }


    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        JsonObject json = Json.createReader(req.getInputStream()).readObject();
        Long id = json.getJsonNumber("id").longValue();
        grade g = gradeService.find(id);
        if(g == null){
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            resp.getWriter().write("{\"error\":\"Grade not found\"}");
            return;
        }
        g.setGrade(json.getJsonNumber("grade").doubleValue());
        gradeService.update(g);
        resp.getWriter().write("{\"message\":\"Grade updated\"}");
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idParam = req.getParameter("id");
        if(idParam == null){
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"error\":\"Missing id\"}");
            return;
        }
        gradeService.delete(Long.valueOf(idParam));
        resp.getWriter().write("{\"message\":\"Grade deleted\"}");
    }
}
