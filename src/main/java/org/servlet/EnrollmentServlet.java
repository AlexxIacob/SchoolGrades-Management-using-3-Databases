package org.servlet;

import jakarta.servlet.annotation.WebServlet;
import org.ejbService.EnrollmentService;
import org.model.enrollment;
import jakarta.ejb.EJB;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.json.Json;
import jakarta.json.JsonObject;
import jakarta.json.JsonReader;

import java.io.IOException;
import java.util.List;

@WebServlet("/enrollments")
public class EnrollmentServlet extends HttpServlet {

    @EJB
    private EnrollmentService enrollmentService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        String studentIdStr = req.getParameter("studentId");

        if(studentIdStr == null) {
            resp.getWriter().write("{\"error\":\"Missing studentId parameter\"}");
            return;
        }

        try {
            Long studentId = Long.parseLong(studentIdStr);
            List<enrollment> enrollments = enrollmentService.findByStudent(studentId);

            jakarta.json.JsonArrayBuilder arr = Json.createArrayBuilder();
            for(enrollment e : enrollments) {
                jakarta.json.JsonObjectBuilder obj = Json.createObjectBuilder();
                obj.add("id", e.getId());
                obj.add("studentId", e.getStudentId());
                obj.add("courseId", e.getCourseId());
                arr.add(obj);
            }

            resp.getWriter().write(arr.build().toString());
        } catch(NumberFormatException ex) {
            resp.getWriter().write("{\"error\":\"Invalid studentId\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");

        try (JsonReader reader = Json.createReader(req.getInputStream())) {
            JsonObject json = reader.readObject();

            if(!json.containsKey("studentId") || !json.containsKey("courseId")) {
                resp.getWriter().write("{\"error\":\"Missing studentId or courseId\"}");
                return;
            }

            Long studentId = json.getJsonNumber("studentId").longValue();
            Long courseId = json.getJsonNumber("courseId").longValue();

            enrollment e = new enrollment(studentId, courseId);
            enrollmentService.create(e);

            resp.getWriter().write("{\"success\":true,\"id\":" + e.getId() + "}");

        } catch(Exception ex) {
            resp.getWriter().write("{\"error\":\"" + ex.getMessage() + "\"}");
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");

        try (JsonReader reader = Json.createReader(req.getInputStream())) {
            JsonObject json = reader.readObject();

            if(!json.containsKey("id") || !json.containsKey("studentId") || !json.containsKey("courseId")) {
                resp.getWriter().write("{\"error\":\"Missing id, studentId or courseId\"}");
                return;
            }

            Long id = json.getJsonNumber("id").longValue();
            Long studentId = json.getJsonNumber("studentId").longValue();
            Long courseId = json.getJsonNumber("courseId").longValue();

            enrollment e = enrollmentService.find(id);
            if(e == null) {
                resp.getWriter().write("{\"error\":\"Enrollment not found\"}");
                return;
            }

            e.setStudentId(studentId);
            e.setCourseId(courseId);
            enrollmentService.update(e);

            resp.getWriter().write("{\"success\":true,\"message\":\"Enrollment updated\"}");

        } catch(Exception ex) {
            resp.getWriter().write("{\"error\":\"" + ex.getMessage() + "\"}");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        String idStr = req.getParameter("id");

        if(idStr == null) {
            resp.getWriter().write("{\"error\":\"Missing id parameter\"}");
            return;
        }

        try {
            Long id = Long.parseLong(idStr);
            enrollmentService.delete(id);
            resp.getWriter().write("{\"success\":true,\"message\":\"Enrollment deleted\"}");
        } catch(NumberFormatException ex) {
            resp.getWriter().write("{\"error\":\"Invalid id\"}");
        }
    }
}
