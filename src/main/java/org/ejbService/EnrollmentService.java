package org.ejbService;

import org.model.enrollment;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class EnrollmentService {

    @PersistenceContext(unitName = "PU_Oracle")
    private EntityManager em;

    public enrollment create(enrollment enrollment) {
        em.persist(enrollment);
        return enrollment;
    }

    public enrollment update(enrollment enrollment) {
        return em.merge(enrollment);
    }

    public void delete(Long id) {
        enrollment e = em.find(enrollment.class, id);
        if (e != null) {
            em.remove(e);
        }
    }

    public enrollment find(Long id) {
        return em.find(enrollment.class, id);
    }

    public List<enrollment> findByStudent(Long studentId) {
        return em.createQuery("SELECT e FROM enrollment e WHERE e.studentId = :studentId", enrollment.class)
                .setParameter("studentId", studentId)
                .getResultList();
    }
}
