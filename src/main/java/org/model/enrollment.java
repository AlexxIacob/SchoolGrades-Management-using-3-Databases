    package org.model;

    import jakarta.persistence.*;

    import java.io.Serializable;


    @Entity
    @Table(name="enrollments")
    public class enrollment implements Serializable {

        @Id
        @GeneratedValue(strategy= GenerationType.IDENTITY)
        private Long id;

        @Column(name="student_id", nullable=false)
        private Long studentId;

        @Column(name="course_id", nullable=false)
        private Long courseId;

        public Long getId() {
            return id;
        }

        public void setId(Long id) {
            this.id = id;
        }

        public Long getStudentId() {
            return studentId;
        }

        public void setStudentId(Long studentId) {
            this.studentId = studentId;
        }

        public Long getCourseId() {
            return courseId;
        }

        public void setCourseId(Long courseId) {
            this.courseId = courseId;
        }

        public enrollment(Long studentId, Long courseId) {
            this.studentId = studentId;
            this.courseId = courseId;
        }

        public enrollment() {}
    }
