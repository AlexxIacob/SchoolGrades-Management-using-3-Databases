package org.ejbService;

import org.model.grade;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class GradeService {

    @PersistenceContext(unitName="PU_Oracle")
    private EntityManager em;

    public grade create(grade g){ em.persist(g); return g; }
    public grade update(grade g){ return em.merge(g); }
    public void delete(Long id){
        grade g = em.find(grade.class, id);
        if(g != null) em.remove(g);
    }
    public grade find(Long id){ return em.find(grade.class, id); }
    public List<grade> findByStudent(Long studentId){
        return em.createQuery("SELECT g FROM grade g WHERE g.studentId = :sid", grade.class)
                .setParameter("sid", studentId).getResultList();
    }
    public Double calcMediaStudent(Long studentId){
        return em.createQuery("SELECT AVG(g.grade) FROM grade g WHERE g.studentId = :sid", Double.class)
                .setParameter("sid", studentId).getSingleResult();
    }
}
