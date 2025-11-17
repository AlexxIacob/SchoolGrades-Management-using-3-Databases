<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestionare Cursuri - Studenți - Note</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }

        .breadcrumb {
            background: #f8f9fa;
            padding: 15px 30px;
            border-bottom: 2px solid #e9ecef;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 14px;
        }

        .breadcrumb span {
            color: #6c757d;
        }

        .breadcrumb .active {
            color: #667eea;
            font-weight: bold;
        }

        .breadcrumb button {
            background: none;
            border: none;
            color: #667eea;
            cursor: pointer;
            text-decoration: underline;
            font-size: 14px;
            padding: 0;
        }

        .breadcrumb button:hover {
            color: #764ba2;
        }

        .content {
            padding: 30px;
            min-height: 400px;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .section-title {
            font-size: 1.8em;
            color: #333;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title .icon {
            font-size: 1.2em;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-success {
            background: #28a745;
            color: white;
        }

        .btn-success:hover {
            background: #218838;
        }

        .btn-danger {
            background: #dc3545;
            color: white;
        }

        .btn-danger:hover {
            background: #c82333;
        }

        .btn-warning {
            background: #ffc107;
            color: #212529;
        }

        .btn-warning:hover {
            background: #e0a800;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        .btn-sm {
            padding: 6px 12px;
            font-size: 12px;
        }

        .loading {
            text-align: center;
            padding: 50px;
            color: #6c757d;
            font-size: 1.2em;
        }

        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .success {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .card {
            background: white;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 25px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .card.clickable {
            cursor: pointer;
        }

        .card.clickable:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
            border-color: #667eea;
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
        }

        .card-title {
            font-size: 1.3em;
            color: #333;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .card-subtitle {
            color: #6c757d;
            font-size: 0.95em;
            margin-bottom: 5px;
        }

        .card-id {
            color: #999;
            font-size: 0.85em;
            margin-bottom: 15px;
        }

        .card-actions {
            display: flex;
            gap: 8px;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #e9ecef;
        }

        .grades-list {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-top: 20px;
        }

        .grade-item {
            background: white;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-left: 4px solid #667eea;
        }

        .grade-item:last-child {
            margin-bottom: 0;
        }

        .grade-info {
            flex: 1;
        }

        .grade-value {
            font-size: 2em;
            font-weight: bold;
            color: #667eea;
            min-width: 80px;
            text-align: center;
        }

        .grade-value.good {
            color: #28a745;
        }

        .grade-value.warning {
            color: #ffc107;
        }

        .grade-value.bad {
            color: #dc3545;
        }

        .grade-actions {
            display: flex;
            gap: 8px;
            margin-left: 15px;
        }

        .average-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            border-radius: 12px;
            text-align: center;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        }

        .average-card h3 {
            font-size: 1.2em;
            margin-bottom: 15px;
            opacity: 0.9;
        }

        .average-value {
            font-size: 4em;
            font-weight: bold;
            margin: 10px 0;
        }

        .no-data {
            text-align: center;
            padding: 50px;
            color: #6c757d;
            font-size: 1.1em;
        }

        .no-data .icon {
            font-size: 3em;
            margin-bottom: 20px;
            opacity: 0.3;
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            animation: fadeIn 0.3s;
        }

        .modal.active {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: white;
            padding: 30px;
            border-radius: 15px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideIn 0.3s;
        }

        .modal-header {
            font-size: 1.5em;
            margin-bottom: 20px;
            color: #333;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
        }

        .modal-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 25px;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideIn {
            from { transform: translateY(-50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        @media (max-width: 768px) {
            .card-grid {
                grid-template-columns: 1fr;
            }

            .header h1 {
                font-size: 1.8em;
            }

            .section-title {
                font-size: 1.4em;
            }

            .section-header {
                flex-direction: column;
                align-items: stretch;
            }

            .card-actions {
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>School Management</h1>
        <p>Courses · Students · Grades</p>
    </div>

    <div class="breadcrumb" id="breadcrumb">
        <span class="active">Courses</span>
    </div>

    <div class="content" id="content">
        <div class="loading">Loading courses</div>
    </div>
</div>


<div id="modal" class="modal">
    <div class="modal-content">
        <div class="modal-header" id="modalHeader">Modal</div>
        <div id="modalBody"></div>
    </div>
</div>

<script>
    const baseUrl = '<%= request.getContextPath() %>';
    let currentView = 'courses';
    let currentCourse = null;
    let currentStudent = null;

    window.addEventListener('DOMContentLoaded', function() {
        loadCourses();
    });

    function updateBreadcrumb() {
        const breadcrumb = document.getElementById('breadcrumb');
        let html = '';

        if (currentView === 'courses') {
            html = '<span class="active">Courses</span>';
        } else if (currentView === 'students') {
            html = '<button onclick="loadCourses()">Courses</button> <span>›</span> <span class="active">' + currentCourse.name + '</span>';
        } else if (currentView === 'grades') {
            html = '<button onclick="loadCourses()">Courses</button> <span>›</span> <button onclick="loadStudents(' + currentCourse.id + ')">' + currentCourse.name + '</button> <span>›</span> <span class="active">' + currentStudent.name + '</span>';
        }

        breadcrumb.innerHTML = html;
    }


    function loadCourses() {
        currentView = 'courses';
        currentCourse = null;
        currentStudent = null;
        updateBreadcrumb();

        const content = document.getElementById('content');
        content.innerHTML = '<div class="loading">Loading courses</div>';

        fetch(baseUrl + '/courses')
            .then(response => response.json())
            .then(courses => {
                let html = `
                <div class="section-header">
                    <div class="section-title"><span class="icon"></span> All courses</div>
                    <button class="btn btn-primary" id="addCourseBtn">➕ Add course</button>
                </div>
            `;

                if (courses.length === 0) {
                    html += '<div class="no-data"><div class="icon"></div><p>There are no courses</p></div>';
                } else {
                    html += '<div class="card-grid">';
                    courses.forEach(course => {
                        html += `
                        <div class="card">
                            <div class="card-clickable" style="cursor:pointer;">
                                <div class="card-title"></div>
                                <div class="card-id">ID: ${course.id}</div>
                            </div>
                            <div class="card-actions">
                                <button class="btn btn-warning btn-sm edit-btn">✏️ Edit</button>
                                <button class="btn btn-danger btn-sm delete-btn">🗑️ Delete</button>
                            </div>
                        </div>
                    `;
                    });
                    html += '</div>';
                }

                content.innerHTML = html;


                document.getElementById('addCourseBtn').addEventListener('click', showAddCourseModal);

                const cards = content.querySelectorAll('.card');
                cards.forEach((card, index) => {
                    const course = courses[index];

                    card.querySelector('.card-clickable').querySelector('.card-title').textContent = course.name;
                    card.querySelector('.card-clickable').addEventListener('click', () => loadStudents(course.id));

                    card.querySelector('.edit-btn').addEventListener('click', () => showEditCourseModal(course.id, course.name));
                    card.querySelector('.delete-btn').addEventListener('click', () => deleteCourse(course.id, course.name));
                });
            })
            .catch(error => {
                content.innerHTML = '<div class="error">Erorr ' + error.message + '</div>';
            });
    }


    function showAddCourseModal() {
        showModal('➕ Add new course', `
                <div class="form-group">
                    <label for="courseName">Course name:</label>
                    <input type="text" id="courseName" placeholder="Ex: Databases" required>
                </div>
                <div class="modal-actions">
                    <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                    <button class="btn btn-success" onclick="addCourse()">Add</button>
                </div>
            `);
    }

    function showEditCourseModal(id, name) {
        showModal('Edit course', `
                <div class="form-group">
                    <label for="courseName">Course name:</label>
                    <input type="text" id="courseName" value="${name}" required>
                </div>
                <div class="modal-actions">
                    <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                    <button class="btn btn-success" onclick="updateCourse(${id})">Save</button>
                </div>
            `);
    }

    function addCourse() {
        const name = document.getElementById('courseName').value.trim();
        if (!name) {
            alert('Add course name');
            return;
        }

        fetch(baseUrl + '/courses', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ name: name })
        })
            .then(response => response.json())
            .then(data => {
                closeModal();
                showSuccess('Course added succesfully');
                loadCourses();
            })
            .catch(error => showError('Error ' + error.message));
    }

    function updateCourse(id) {
        const name = document.getElementById('courseName').value.trim();
        if (!name) {
            alert('Add course name');
            return;
        }

        fetch(baseUrl + '/courses', {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ id: id, name: name })
        })
            .then(response => response.json())
            .then(data => {
                closeModal();
                showSuccess('Course updated succesfully');
                loadCourses();
            })
            .catch(error => showError('Error ' + error.message));
    }

    function deleteCourse(id, name) {
        if (!confirm(`Are you sure you want to delete course "${name}"?`)) return;

        fetch(baseUrl + '/courses?id=' + id, { method: 'DELETE' })
            .then(response => response.json())
            .then(data => {
                showSuccess('Course succesfully deleted');
                loadCourses();
            })
            .catch(error => showError('Error ' + error.message));
    }


    function loadStudents(courseId) {
        const content = document.getElementById('content');
        content.innerHTML = '<div class="loading">Loading studens</div>';


        fetch(baseUrl + '/courses?id=' + courseId)
            .then(response => response.json())
            .then(course => {
                currentCourse = course;
                currentView = 'students';
                updateBreadcrumb();


                return fetch(baseUrl + '/enrollments?courseId=' + courseId);
            })
            .then(res => res.json())
            .then(enrollments => {


                const studentIds = enrollments.map(e => e.studentId);


                return fetch(baseUrl + '/students')
                    .then(res => res.json())
                    .then(allStudents => {
                        const students = allStudents.filter(s => studentIds.includes(s.id));


                        let html = `
                        <div class="section-header">
                            <div class="section-title">
                                <span class="icon">👥</span> Students - ${currentCourse.name}
                            </div>
                            <button class="btn btn-primary" id="addStudentBtn">➕ Add student</button>
                        </div>
                    `;

                        if (students.length === 0) {
                            html += `
                            <div class="no-data">
                                <div class="icon">👥</div>
                                <p>No students at this course</p>
                            </div>
                        `;
                        } else {
                            html += '<div class="card-grid">';
                            students.forEach(student => {
                                html += `
                                <div class="card">
                                    <div class="card-clickable" style="cursor:pointer;">
                                        <div class="card-title">${student.name}</div>
                                        <div class="card-subtitle">📧 ${student.email}</div>
                                    </div>
                                    <div class="card-actions">
                                        <button class="btn btn-warning btn-sm edit-btn">Edit</button>
                                        <button class="btn btn-danger btn-sm delete-btn">Delete</button>
                                    </div>
                                </div>
                            `;
                            });
                            html += '</div>';
                        }

                        content.innerHTML = html;


                        document.getElementById('addStudentBtn')
                            .addEventListener('click', showAddStudentModal);


                        const cards = content.querySelectorAll('.card');
                        cards.forEach((card, index) => {
                            const student = students[index];

                            card.querySelector('.card-clickable')
                                .addEventListener('click', () => loadGrades(student.id));

                            card.querySelector('.edit-btn')
                                .addEventListener('click', () => showEditStudentModal(student.id, student.name, student.email));

                            card.querySelector('.delete-btn')
                                .addEventListener('click', () => deleteStudent(student.id, student.name));
                        });
                    });
            })
            .catch(error => {
                content.innerHTML = '<div class="error">Eroare: ' + error.message + '</div>';
            });
    }



    function showAddStudentModal() {
        showModal('Add new students', `
                <div class="form-group">
                    <label for="studentName">Student name</label>
                    <input type="text" id="studentName" placeholder="Ex: Ion Popescu" required>
                </div>
                <div class="form-group">
                    <label for="studentEmail">Email:</label>
                    <input type="email" id="studentEmail" placeholder="Ex: ion.popescu@email.com" required>
                </div>
                <div class="modal-actions">
                    <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                    <button class="btn btn-success" onclick="addStudent()">Add</button>
                </div>
            `);
    }

    function showEditStudentModal(id, name, email) {
        showModal('Edit student', `
                <div class="form-group">
                    <label for="studentName">Student name</label>
                    <input type="text" id="studentName" value="${name}" required>
                </div>
                <div class="form-group">
                    <label for="studentEmail">Email:</label>
                    <input type="email" id="studentEmail" value="${email}" required>
                </div>
                <div class="modal-actions">
                    <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                    <button class="btn btn-success" onclick="updateStudent(${id})">Save</button>
                </div>
            `);
    }

    function addStudent() {
        const name = document.getElementById('studentName').value.trim();
        const email = document.getElementById('studentEmail').value.trim();

        if (!name || !email) {
            alert('Comeplte everything');
            return;
        }


        fetch(baseUrl + '/students', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ name, email })
        })
            .then(res => {
                if (!res.ok) {
                    throw new Error('Error');
                }
                return res.json();
            })
            .then(created => {
                if (!created.id) {
                    alert("Error");
                    return;
                }

                const newStudentId = created.id;


                return fetch(baseUrl + '/enrollments', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        studentId: newStudentId,
                        courseId: currentCourse.id
                    })
                });
            })
            .then(res => {
                if (!res.ok) {
                    throw new Error('Error');
                }
                return res.json();
            })
            .then(enr => {
                if (enr.error) {
                    alert("Student created but couldnt re assigned to course");
                    return;
                }

                closeModal();
                showSuccess('Student added succesfully');

                loadStudents(currentCourse.id);
            })
            .catch(err => {
                alert("Eroare: " + err.message);
            });
    }


    function updateStudent(id) {
        const name = document.getElementById('studentName').value.trim();
        const email = document.getElementById('studentEmail').value.trim();

        if (!name || !email) {
            alert('Complete everything');
            return;
        }

        fetch(baseUrl + '/students', {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ id: id, name: name, email: email })
        })
            .then(response => response.json())
            .then(data => {
                closeModal();
                showSuccess('Student updated succesfully');
                loadStudents(currentCourse.id);
            })
            .catch(error => showError('Error ' + error.message));
    }

    function deleteStudent(id, name) {
        if (!confirm(`Are you sure you want to delete "${name}"?`)) return;

        fetch(baseUrl + '/students?id=' + id, { method: 'DELETE' })
            .then(response => response.json())
            .then(data => {
                showSuccess('Student deleted succesfully');
                loadStudents(currentCourse.id);
            })
            .catch(error => showError('Error ' + error.message));
    }


    function loadGrades(studentId) {
        const content = document.getElementById('content');
        content.innerHTML = '<div class="loading">Loading grades</div>';

        fetch(baseUrl + '/students?id=' + studentId)
            .then(response => response.json())
            .then(student => {
                currentStudent = student;
                currentView = 'grades';
                updateBreadcrumb();

                return fetch(baseUrl + '/grades?studentId=' + studentId);
            })
            .then(response => response.json())
            .then(grades => {
                const courseGrades = grades.filter(g => g.courseId === currentCourse.id);

                let html = `
                        <div class="section-header">
                            <div class="section-title"><span class="icon"></span> Grades - ${escapeHtml(currentStudent.name)}</div>
                            <button class="btn btn-primary" onclick="showAddGradeModal()">
                                Add grade
                            </button>
                        </div>
                    `;

                if (courseGrades.length === 0) {
                    html += '<div class="no-data"><div class="icon"></div><p>Studentul doesnt have any grades yet</p></div>';
                } else {
                    const sum = courseGrades.reduce((acc, g) => acc + g.grade, 0);
                    const average = (sum / courseGrades.length).toFixed(2);

                    html += `
                            <div class="average-card">
                                <h3>Average at ${escapeHtml(currentCourse.name)}</h3>
                                <div class="average-value">${average}</div>
                                <p>${courseGrades.length} ${courseGrades.length == 1 ? 'grade' : 'note'}</p>
                            </div>
                            <div class="grades-list">
                        `;

                    courseGrades.forEach((grade, index) => {
                        let gradeClass = '';
                        if (grade.grade >= 9) gradeClass = 'good';
                        else if (grade.grade >= 7) gradeClass = 'warning';
                        else if (grade.grade < 5) gradeClass = 'bad';

                        html += `
                                <div class="grade-item">
                                    <div class="grade-info">
                                        <strong>Grade ${index + 1}</strong>
                                        <div class="card-id">ID: ${grade.id}</div>
                                    </div>
                                    <div class="grade-value ${gradeClass}">${grade.grade.toFixed(2)}</div>
                                    <div class="grade-actions">
                                        <button class="btn btn-warning btn-sm" onclick="showEditGradeModal(${grade.id}, ${grade.grade})">
                                            Edit
                                        </button>
                                        <button class="btn btn-danger btn-sm" onclick="deleteGrade(${grade.id})">
                                            Delete
                                        </button>
                                    </div>
                                </div>
                            `;
                    });

                    html += '</div>';
                }

                content.innerHTML = html;
            })
            .catch(error => {
                content.innerHTML = '<div class="error">Error ' + error.message + '</div>';
            });
    }

    function showAddGradeModal() {
        showModal('➕ Add new grade', `
                <div class="form-group">
                    <label for="gradeValue">Grade (1-10):</label>
                    <input type="number" id="gradeValue" min="1" max="10" step="0.01" placeholder="Ex: 9" required>
                </div>
                <div class="modal-actions">
                    <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                    <button class="btn btn-success" onclick="addGrade()">Add</button>
                </div>
            `);
    }

    function showEditGradeModal(id, gradeValue) {
        showModal('Edit grade', `
                <div class="form-group">
                    <label for="gradeValue">Grade (1-10):</label>
                    <input type="number" id="gradeValue" min="1" max="10" step="0.01" value="${gradeValue}" required>
                </div>
                <div class="modal-actions">
                    <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                    <button class="btn btn-success" onclick="updateGrade(${id})">Save</button>
                </div>
            `);
    }

    function addGrade() {
        const gradeValue = parseFloat(document.getElementById('gradeValue').value);

        if (isNaN(gradeValue) || gradeValue < 1 || gradeValue > 10) {
            alert('Grades must be between 1 and 10');
            return;
        }

        fetch(baseUrl + '/grades', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                studentId: currentStudent.id,
                courseId: currentCourse.id,
                grade: gradeValue
            })
        })
            .then(response => response.json())
            .then(data => {
                closeModal();
                showSuccess('Grade added succesfully');
                loadGrades(currentStudent.id);
            })
            .catch(error => showError('Error ' + error.message));
    }

    function updateGrade(id) {
        const gradeValue = parseFloat(document.getElementById('gradeValue').value);

        if (isNaN(gradeValue) || gradeValue < 1 || gradeValue > 10) {
            alert('Grades must be between 1 and 10');
            return;
        }

        fetch(baseUrl + '/grades', {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ id: id, grade: gradeValue })
        })
            .then(response => response.json())
            .then(data => {
                closeModal();
                showSuccess('Grade updated succesfully');
                loadGrades(currentStudent.id);
            })
            .catch(error => showError('Error ' + error.message));
    }

    function deleteGrade(id) {
        if (!confirm('Are you sure you want to delete this grade ?')) return;

        fetch(baseUrl + '/grades?id=' + id, { method: 'DELETE' })
            .then(response => response.json())
            .then(data => {
                showSuccess('Grade deleted succesfully');
                loadGrades(currentStudent.id);
            })
            .catch(error => showError('Error: ' + error.message));
    }


    function showModal(title, body) {
        document.getElementById('modalHeader').innerHTML = title;
        document.getElementById('modalBody').innerHTML = body;
        document.getElementById('modal').classList.add('active');
    }

    function closeModal() {
        document.getElementById('modal').classList.remove('active');
    }


    window.onclick = function(event) {
        const modal = document.getElementById('modal');
        if (event.target === modal) {
            closeModal();
        }
    }


    function showSuccess(message) {
        const content = document.getElementById('content');
        const successDiv = document.createElement('div');
        successDiv.className = 'success';
        successDiv.textContent = message;
        content.insertBefore(successDiv, content.firstChild);

        setTimeout(() => successDiv.remove(), 3000);
    }

    function showError(message) {
        const content = document.getElementById('content');
        const errorDiv = document.createElement('div');
        errorDiv.className = 'error';
        errorDiv.textContent = message;
        content.insertBefore(errorDiv, content.firstChild);

        setTimeout(() => errorDiv.remove(), 5000);
    }

    function escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }
    </script>