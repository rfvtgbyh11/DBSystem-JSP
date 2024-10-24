package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class UserDAO {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public class _ClassInfo {
        public String classNo;
        public String courseId;
        public String courseName;
        public String lecturer;
        public String per_no, per_max;
        public String classId;
        public String day[] = new String[2];
        public String begin[] = new String[2];
        public String end[] = new String[2];
        public String roomNum[] = new String[2];
        public String bldg[] = new String[2];

        public _ClassInfo(String a, String b, String c, String d, String e, String f, String g) {
            classNo = a;
            courseId = b;
            courseName = c;
            lecturer = d;
            per_no = e;
            per_max = f;
            classId = g;
        }

        public void setTime(String a, String b, String c, String d, String e, int period) {
            day[period] = a;
            begin[period] = b;
            end[period] = c;
            roomNum[period] = d;
            bldg[period] = e;
            return;
        }
    }

    public class StudentInfo {
        public int student_id;
        public String name;
        public String major_name;
        public String advisor_name;
        public String status;

        public StudentInfo(int student_id, String name, String major_name, String advisor_name, String status) {
            this.student_id = student_id;
            this.name = name;
            this.major_name = major_name;
            this.advisor_name = advisor_name;
            this.status = status;
        }
    }

    public class LecturerInfo {
        public String lecturer_id;
        public String name;

        public LecturerInfo(String lecturer_id, String name) {
            this.lecturer_id = lecturer_id;
            this.name = name;
        }
    }

    public class RoomInfo{
        public String room_id;
        public String building_name;
        public String room_num;

        public RoomInfo(String room_id, String building_name, String room_num) {
            this.room_id = room_id;
            this.building_name = building_name;
            this.room_num = room_num;
        }
    }

    public class CourseInfo{
        public String course_id;
        public String name;
        public String dev;

        public CourseInfo(String course_id, String name, String dev) {
            this.course_id = course_id;
            this.name = name;
            this.dev = dev;
        }
    }

    public UserDAO() {
        try {
            String jdbcUrl = "jdbc:mysql://localhost:3306/Proj1?serverTimezone=Asia/Seoul";
            String dbId = "root";
            String dbPass = "4197";

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int login(String userID, String userPassword) {
        try {
            pstmt = conn.prepareStatement("SELECT password FROM ADMIN WHERE admin_id = ?");
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) if (rs.getString(1).equals(userPassword)) return 1;

            pstmt = conn.prepareStatement("SELECT password FROM STUDENT WHERE student_id = ?");
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) if (rs.getString(1).equals(userPassword)) return 2;

            else return 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public String getStuName(String student_id) {
        try {
            pstmt = conn.prepareStatement("SELECT name FROM STUDENT WHERE student_id = ?");
            pstmt.setString(1, student_id);
            rs = pstmt.executeQuery();
            rs.next();
            return rs.getString(1);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public String getStuAdv(String student_id) {
        String temp;
        try {
            pstmt = conn.prepareStatement("SELECT advisor_id FROM STUDENT WHERE student_id = ?");
            pstmt.setString(1, student_id);
            rs = pstmt.executeQuery();
            rs.next();
            temp = rs.getString(1);

            pstmt = conn.prepareStatement("SELECT name FROM LECTURER WHERE lecturer_id = ?");
            pstmt.setString(1, temp);
            rs = pstmt.executeQuery();
            rs.next();
            return rs.getString(1);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public String getStuSt(String student_id) {
        try {
            pstmt = conn.prepareStatement("SELECT status FROM STUDENT WHERE student_id = ?");
            pstmt.setString(1, student_id);
            rs = pstmt.executeQuery();
            rs.next();
            return rs.getString(1);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public String getStuMaj(String student_id) {
        String temp;
        try {
            pstmt = conn.prepareStatement("SELECT major_id FROM STUDENT WHERE student_id = ?");
            pstmt.setString(1, student_id);
            rs = pstmt.executeQuery();
            rs.next();
            temp = rs.getString(1);

            pstmt = conn.prepareStatement("SELECT name FROM MAJOR WHERE major_id = ?");
            pstmt.setString(1, temp);
            rs = pstmt.executeQuery();
            rs.next();
            return rs.getString(1);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public int setStuPW(String userID, String old_PW, String new_PW) {
        try {
            pstmt = conn.prepareStatement("SELECT password FROM STUDENT WHERE student_id = ?");
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) if (rs.getString(1).equals(old_PW)) {
                pstmt = conn.prepareStatement("UPDATE STUDENT SET password = ? WHERE student_id = ?");
                pstmt.setString(1, new_PW);
                pstmt.setString(2, userID);
                pstmt.executeUpdate();
                return 0;
            }

            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int setStuSt(String userID, String PW, String status) {
        try {
            pstmt = conn.prepareStatement("SELECT password FROM STUDENT WHERE student_id = ?");
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) if (rs.getString(1).equals(PW)) {
                pstmt = conn.prepareStatement("UPDATE STUDENT SET status = ? WHERE student_id = ?");
                pstmt.setString(1, status);
                pstmt.setString(2, userID);
                pstmt.executeUpdate();
                return 0;
            }

            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int setStuSt_1(String userID, String status) {
        try {
            pstmt = conn.prepareStatement("UPDATE STUDENT SET status = ? WHERE student_id = ?");
            pstmt.setString(1, status);
            pstmt.setString(2, userID);
            pstmt.executeUpdate();
            return 0;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public int getStuCrd(String userID) {
        try {
            int credit = 0;
            pstmt = conn.prepareStatement("SELECT COURSE.credit FROM STUDENT " +
                    "join TAKES on STUDENT.student_id = takes.student_id " +
                    "join _CLASS on TAKES.class_id = _CLASS.class_id " +
                    "JOIN COURSE on _CLASS.course_id = COURSE.course_id " +
                    "WHERE STUDENT.student_id = ? AND _CLASS.SEMESTER = 20222");
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                credit = credit + rs.getInt(1);
            }
            return credit;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public List<_ClassInfo> _classInfo(String classId, String courseId, String className) {
        try {
            List<_ClassInfo> ret = new ArrayList();
            pstmt = conn.prepareStatement(
                    "SELECT C.class_no, CO.course_id, CO.name, LECTURER.name, C.person_num, C.person_max, C.class_id\n" +
                            "FROM _CLASS C JOIN LECTURER ON C.lecturer_id = LECTURER.lecturer_id\n" +
                            "JOIN COURSE CO ON C.course_id = CO.course_id\n" +
                            "WHERE C.class_no" + ((classId.length() != 0) ? (" = " + classId + "\n") : (" like '%'\n")) +
                            "AND CO.course_id" + ((courseId.length() != 0) ? (" = '" + courseId + "'\n") : (" like '%'\n")) +
                            "AND CO.name" + ((className.length() != 0) ? (" like '%" + className + "%'\n") : (" like '%'\n")) +
                            "AND C.semester = 20222\n" +
                            "ORDER BY C.class_id;"); // 과목들의 정보를 수업번호, 학수번호, 수업명(키워드) 검색으로 가져온다.
            rs = pstmt.executeQuery();
            while (rs.next()) { // 결과들을 정보들을 담은 배열에 저장
                ret.add(new _ClassInfo(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7)));
            }

            for (_ClassInfo _class : ret) {
                pstmt = conn.prepareStatement(
                        "SELECT _TIME.period, _TIME._day, _TIME._begin, _TIME._end, ROOM.room_num, BUILDING.name\n" +
                                "FROM _CLASS\n" +
                                "JOIN _TIME ON _CLASS.class_id = _TIME.class_id\n" +
                                "JOIN ROOM ON _TIME.room_id = ROOM.room_id\n" +
                                "JOIN BUILDING ON ROOM.building_id = BUILDING.building_id\n" +
                                "where _CLASS.class_id = ?;"); // class_id 기반으로 time 과 강의실 검색
                pstmt.setString(1, _class.classId);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    _class.setTime(rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(1) - 1);
                }
            }
            return ret;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public int takeCls(String classId, String userID, List<UserDAO._ClassInfo> list) {
        try {
            String temp = getGrade(userID, classId);
            int Crd = getStuCrd(userID);
            while (rs.next()) {
                temp = rs.getString(1);
                if (temp == "A+" || temp == "A0" || temp == "B+" || temp == "B0") return 1;
                else if (temp == "NA") return 5;
            } // 이전성적 B+ 이상 or 현재학기에 이미 수강신청

            pstmt = conn.prepareStatement("select person_num, person_max\n" +
                    "from _class where class_id = ?");
            pstmt.setString(1, classId);
            rs = pstmt.executeQuery();
            rs.next();
            if (rs.getInt(1) >= rs.getInt(2)) return 2; // 정원 초과


            pstmt = conn.prepareStatement(
                    "SELECT _TIME._day, _TIME._begin, _TIME._end\n" +
                            "FROM _CLASS\n" +
                            "JOIN _TIME ON _CLASS.class_id = _TIME.class_id\n" +
                            "where _CLASS.class_id = ?;"); // class_id 기반으로 time 검색
            pstmt.setString(1, classId);
            rs = pstmt.executeQuery();

            LocalTime timeCbeg;
            LocalTime timeCen;
            LocalTime[] timeNbeg = new LocalTime[2];
            LocalTime[] timeNen = new LocalTime[2];
            DateTimeFormatter format = DateTimeFormatter.ofPattern("HH:mm:ss");
            String[] day = new String[2];

            for (int i = 0; i < 2 && rs.next(); i++) {
                timeNbeg[i] = LocalTime.parse(rs.getString(2), format);
                timeNen[i] = LocalTime.parse(rs.getString(3), format);
                day[i] = rs.getString(1);
            }

            for (_ClassInfo _class : list) {
                for (int i = 0; i < 2; i++) {
                    timeCbeg = LocalTime.parse(_class.begin[i], format);
                    timeCen = LocalTime.parse(_class.end[i], format);
                    for (int j = 0; j < 2; j++) {
                        if (!(day[j].equals(_class.day[i]))) continue;
                        if (timeNen[j].isAfter(timeCbeg) && timeNen[j].isBefore(timeCen)) return 3; // 시간표 겹침
                        if (timeNbeg[j].isAfter(timeCbeg) && timeNbeg[j].isBefore(timeCen)) return 3;
                        if (timeNbeg[j].isAfter(timeCbeg) && timeNen[j].isBefore(timeCen)) return 3;
                        if (timeNbeg[j].isBefore(timeCbeg) && timeNen[j].isAfter(timeCen)) return 3;
                        if (timeNbeg[j].equals(timeCbeg) || timeNen[j].equals(timeCen)) return 3;
                    }
                }
            }

            pstmt = conn.prepareStatement("select credit from _class\n" +
                    "join course on _class.course_id = course.course_id\n" +
                    "where class_id = ?");
            pstmt.setString(1, classId);
            rs = pstmt.executeQuery();
            rs.next();
            if (Crd + rs.getInt(1) > 18) return 4; // 학점 초과

            pstmt = conn.prepareStatement("INSERT INTO TAKES(student_id, class_id) VALUES(?, ?)");
            pstmt.setString(1, userID);
            pstmt.setString(2, classId);
            pstmt.executeUpdate();

            pstmt = conn.prepareStatement("UPDATE _CLASS SET person_num = person_num + 1 WHERE class_id = ?");
            pstmt.setString(1, classId);
            pstmt.executeUpdate();
            return 0; // 수강신청 완료
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public int addWish(String classId, String userID) {
        try {
            String temp = getGrade(userID, classId);
            int Crd = getStuCrd(userID);
            while (rs.next()) {
                temp = rs.getString(1);
                if (temp == "A+" || temp == "A0" || temp == "B+" || temp == "B0") return 1;
            } // 이전성적 B+ 이상 or 현재학기에 이미 수강신청

            pstmt = conn.prepareStatement("INSERT INTO WISH(student_id, class_id) VALUES(?, ?)");
            pstmt.setString(1, userID);
            pstmt.setString(2, classId);
            pstmt.executeUpdate();
            return 0; // 수강신청 완료
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public int delWish(String classId, String userID) {
        try {
            pstmt = conn.prepareStatement("DELETE FROM WISH WHERE student_id = ? AND class_id = ?");
            pstmt.setString(1, userID);
            pstmt.setString(2, classId);
            pstmt.executeUpdate();
            return 0; // 수강신청 완료
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public String getGrade(String userID, String classId) {
        try {
            String temp;

            pstmt = conn.prepareStatement("select takes.grade from _class\n" +
                    "join takes on _class.class_id = takes.class_id\n" +
                    "where takes.student_id = ? and _class.course_id in (select course_id from _class where class_id = ?);");
            pstmt.setString(1, userID);
            pstmt.setString(2, classId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                if (rs.getString(1) == null) continue;
                return rs.getString(1);
            }
            return "NA";
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public int delCourse(String classId, String userID) {
        try {
            pstmt = conn.prepareStatement("DELETE FROM TAKES WHERE student_id = ? AND class_id = ?");
            pstmt.setString(1, userID);
            pstmt.setString(2, classId);
            pstmt.executeUpdate();

            pstmt = conn.prepareStatement("UPDATE _CLASS SET person_num = person_num - 1 WHERE class_id = ?");
            pstmt.setString(1, classId);
            pstmt.executeUpdate();
            return 0; // 수강신청 완료
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public List<_ClassInfo> wishInfo(String userID) {
        try {
            List<String> temp = new ArrayList();
            List<_ClassInfo> ret = new ArrayList();
            pstmt = conn.prepareStatement("SELECT W.class_id FROM WISH W JOIN _CLASS C ON W.class_id = C.class_id\n" +
                    "WHERE W.student_id = ? AND C.semester = 20222");
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            while (rs.next()) temp.add(rs.getString(1));

            for (String id : temp) {
                pstmt = conn.prepareStatement(
                        "SELECT C.class_no, CO.course_id, CO.name, LECTURER.name, C.person_num, C.person_max, C.class_id\n" +
                                "FROM _CLASS C JOIN LECTURER ON C.lecturer_id = LECTURER.lecturer_id\n" +
                                "JOIN COURSE CO ON C.course_id = CO.course_id\n" +
                                "WHERE C.class_id = ?");
                pstmt.setString(1, id);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    ret.add(new _ClassInfo(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7)));
                }
            }

            for (_ClassInfo _class : ret) {
                pstmt = conn.prepareStatement(
                        "SELECT _TIME.period, _TIME._day, _TIME._begin, _TIME._end, ROOM.room_num, BUILDING.name\n" +
                                "FROM _CLASS\n" +
                                "JOIN _TIME ON _CLASS.class_id = _TIME.class_id\n" +
                                "JOIN ROOM ON _TIME.room_id = ROOM.room_id\n" +
                                "JOIN BUILDING ON ROOM.building_id = BUILDING.building_id\n" +
                                "where _CLASS.class_id = ?;"); // class_id 기반으로 time 과 강의실 검색
                pstmt.setString(1, _class.classId);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    _class.setTime(rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(1) - 1);
                }
            }
            return ret;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<_ClassInfo> courseInfo_1(String userID, boolean prev) {
        try {
            List<String> temp = new ArrayList();
            List<_ClassInfo> ret = new ArrayList();
            pstmt = conn.prepareStatement("SELECT T.class_id FROM TAKES T JOIN _CLASS C ON T.class_id = C.class_id\n" +
                    "WHERE T.student_id = ?" + (prev ? " AND C.semester != 20222" : " AND C.semester = 20222"));
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            while (rs.next()) temp.add(rs.getString(1));
            for (String i : temp)
                System.out.println(i);

            for (String id : temp) {
                pstmt = conn.prepareStatement(
                        "SELECT C.class_no, CO.course_id, CO.name, LECTURER.name, C.person_num, C.person_max, C.class_id\n" +
                                "FROM _CLASS C JOIN LECTURER ON C.lecturer_id = LECTURER.lecturer_id\n" +
                                "JOIN COURSE CO ON C.course_id = CO.course_id\n" +
                                "WHERE C.class_id = ?");
                pstmt.setString(1, id);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    ret.add(new _ClassInfo(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7)));
                }
            }

            for (_ClassInfo _class : ret) {
                pstmt = conn.prepareStatement(
                        "SELECT _TIME.period, _TIME._day, _TIME._begin, _TIME._end, ROOM.room_num, BUILDING.name\n" +
                                "FROM _CLASS\n" +
                                "JOIN _TIME ON _CLASS.class_id = _TIME.class_id\n" +
                                "JOIN ROOM ON _TIME.room_id = ROOM.room_id\n" +
                                "JOIN BUILDING ON ROOM.building_id = BUILDING.building_id\n" +
                                "where _CLASS.class_id = ?;"); // class_id 기반으로 time 과 강의실 검색
                pstmt.setString(1, _class.classId);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    _class.setTime(rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(1) - 1);
                }
            }
            return ret;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<_ClassInfo> courseInfo(String userID) {
        return this.courseInfo_1(userID, false);
    }

    public String[] timeFind(List<_ClassInfo> list, String day, int hour, int min) {
        for (_ClassInfo _class : list) {
            for (int i = 0; i < 2; i++) {
                if (_class.day[i].equals(day) && (_class.begin[i] != null) && Integer.parseInt(_class.begin[i].substring(0, 2)) == hour && Integer.parseInt(_class.begin[i].substring(3, 5)) == min) {
                    return new String[]{String.valueOf(Integer.parseInt(_class.end[i].substring(0, 2)) * 2 + Integer.parseInt(_class.end[i].substring(3, 5)) / 30 - hour * 2 - min / 30), _class.courseName};
                }
            }
        }
        return null;
    }

    public List<StudentInfo> getstuInfo(String sid, String name, String major) {
        try {
            List<StudentInfo> ret = new ArrayList();
            pstmt = conn.prepareStatement("select S.student_id, S.name, M.name, L.name, S.status from Student S\n" +
                    "join Major M on S.major_id = M.major_id\n" +
                    "join Lecturer L on S.advisor_id = L.lecturer_id\n" +
                    "where S.student_id" + (sid.length() == 0 ? " like '%" + sid + "%'\n" : "'%'\n") +
                    "or S.name" + (name.length() == 0 ? " like '%" + name + "%'\n" : "'%'\n") +
                    "or M.name" + (major.length() == 0 ? " like '%" + major + "%'\n" : "'%';"));
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ret.add(new StudentInfo(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5)));
            }
            return ret;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<LecturerInfo> getLecInfo() {
        try {
            List<LecturerInfo> ret = new ArrayList();
            pstmt = conn.prepareStatement("select lecturer_id, name from lecturer");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ret.add(new LecturerInfo(rs.getString(1), rs.getString(2)));
            }
            return ret;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<RoomInfo> getRoomInfo() {
        try {
            List<RoomInfo> ret = new ArrayList();
            pstmt = conn.prepareStatement("select R.room_id, B.name, R.room_num from Room R\n" +
                    "join building B on R.building_id = B.building_id");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ret.add(new RoomInfo(rs.getString(1), rs.getString(2), rs.getString(3)));
            }
            return ret;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean isRoomFull(String room1, String room2, String person_max){
        try{
            pstmt = conn.prepareStatement("Select room_max from room where room_id = ? or room_id = ?");
            pstmt.setString(1, room1);
            pstmt.setString(2, room2);
            rs = pstmt.executeQuery();
            while (rs.next()){
                if (Integer.parseInt(person_max) > rs.getInt(1)) return true; // 강의실 공간부족
            }
            return false;
        }catch(Exception e){
            e.printStackTrace();
            return true;
        }
    }

    public boolean isValidCId(String course_id){
        try{
            pstmt = conn.prepareStatement("select course_id from course");
            rs = pstmt.executeQuery();
            while (rs.next()){
                if (rs.getString(1).equals(course_id)) return true;
            }
            return false;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public int addClass(String class_no, String course_id, String person_max, String lecturer_id, String prd1_day, String prd1_begin, String prd1_end, String prd1_room, String prd2_day, String prd2_begin, String prd2_end, String prd2_room) {
        try {
            if (isRoomFull(prd1_room, prd2_room, person_max)) return 1; // 공간 부족
            if (!isValidCId(course_id)) return 2; // 유효하지 않은 학수번호

            String class_id = null;
            pstmt = conn.prepareStatement("insert into _Class(class_no, person_num, person_max, semester, course_id, lecturer_id)\n" +
                    "values(?, 0, ?, 20222, ?, ?)");
            pstmt.setString(1, class_no);
            pstmt.setString(2, person_max);
            pstmt.setString(3, course_id);
            pstmt.setString(4, lecturer_id);
            pstmt.executeUpdate();

            pstmt = conn.prepareStatement("select LAST_INSERT_ID()");
            rs = pstmt.executeQuery();
            rs.next(); class_id = rs.getString(1);

            if (prd1_day.equals("온라인") || prd1_day.equals("토") || Integer.parseInt(prd1_begin.substring(0, 2)) >= 18){
                pstmt = conn.prepareStatement("insert into _Time(class_id, period)\n" +
                        "values(?, 1)");
                pstmt.setString(1, class_id);
                pstmt.executeUpdate();
            } else {
                pstmt = conn.prepareStatement("insert into _Time(class_id, period, _day, _begin, _end, room_id)\n" +
                        "values(?, 1, ?, ?, ?, ?)");
                pstmt.setString(1, class_id);
                pstmt.setString(2, prd1_day);
                pstmt.setString(3, prd1_begin);
                pstmt.setString(4, prd1_end);
                pstmt.setString(5, prd1_room);
                pstmt.executeUpdate();
            }

            if (prd2_day.equals("온라인") || prd2_day.equals("토") || Integer.parseInt(prd2_begin.substring(0, 2)) >= 18){
                pstmt = conn.prepareStatement("insert into _Time(class_id, period)\n" +
                        "values(?, 2)");
                pstmt.setString(2, class_id);
                pstmt.executeUpdate();
            } else {
                pstmt = conn.prepareStatement("insert into _Time(class_id, period, _day, _begin, _end, room_id)\n" +
                        "values(?, 2, ?, ?, ?, ?)");
                pstmt.setString(1, class_id);
                pstmt.setString(2, prd2_day);
                pstmt.setString(3, prd2_begin);
                pstmt.setString(4, prd2_end);
                pstmt.setString(5, prd2_room);
                pstmt.executeUpdate();
            }

            return 0;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public int updateClass(String class_id, String class_no, String course_id, String person_max, String lecturer_id, String prd1_day, String prd1_begin, String prd1_end, String prd1_room, String prd2_day, String prd2_begin, String prd2_end, String prd2_room) {
        try {
            if (isRoomFull(prd1_room, prd2_room, person_max)) return 1; // 공간 부족
            if (!isValidCId(course_id)) return 2; // 유효하지 않은 학수번호

            pstmt = conn.prepareStatement("update _Class\n" + // _Class 수정
                    "set class_no = ?, person_max = ?, course_id = ?, lecturer_id = ?\n" +
                    "where class_id = ?");
            pstmt.setString(1, class_no);
            pstmt.setString(2, person_max);
            pstmt.setString(3, course_id);
            pstmt.setString(4, lecturer_id);
            pstmt.setString(5, class_id);
            pstmt.executeUpdate();

            pstmt = conn.prepareStatement("delete from _Time where class_id = ?"); // 연결되어 있던 _Time id 삭제
            pstmt.setString(1, class_id);
            pstmt.executeUpdate();

            if (prd1_day.equals("온라인") || prd1_day.equals("토") || Integer.parseInt(prd1_begin.substring(0, 2)) >= 18){ // _Time id 다시 만듦
                pstmt = conn.prepareStatement("insert into _Time(class_id, period)\n" +
                        "values(?, 1)");
                pstmt.setString(1, class_id);
                pstmt.executeUpdate();
            } else {
                pstmt = conn.prepareStatement("insert into _Time(class_id, period, _day, _begin, _end, room_id)\n" +
                        "values(?, 1, ?, ?, ?, ?)");
                pstmt.setString(1, class_id);
                pstmt.setString(2, prd1_day);
                pstmt.setString(3, prd1_begin);
                pstmt.setString(4, prd1_end);
                pstmt.setString(5, prd1_room);
                pstmt.executeUpdate();
            }

            if (prd2_day.equals("온라인") || prd2_day.equals("토") || Integer.parseInt(prd2_begin.substring(0, 2)) >= 18){
                pstmt = conn.prepareStatement("insert into _Time(class_id, period)\n" +
                        "values(?, 2)");
                pstmt.setString(2, class_id);
                pstmt.executeUpdate();
            } else {
                pstmt = conn.prepareStatement("insert into _Time(class_id, period, _day, _begin, _end, room_id)\n" +
                        "values(?, 2, ?, ?, ?, ?)");
                pstmt.setString(1, class_id);
                pstmt.setString(2, prd2_day);
                pstmt.setString(3, prd2_begin);
                pstmt.setString(4, prd2_end);
                pstmt.setString(5, prd2_room);
                pstmt.executeUpdate();
            }

            return 0;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public int deleteClass(String class_id){
        try{
            pstmt = conn.prepareStatement("delete from Wish where class_id = ?"); // 연결되어 있던 Wish 삭제
            pstmt.setString(1, class_id);
            pstmt.executeUpdate();

            pstmt = conn.prepareStatement("delete from Takes where class_id = ?"); // 연결되어 있던 Takes 삭제
            pstmt.setString(1, class_id);
            pstmt.executeUpdate();

            pstmt = conn.prepareStatement("delete from _Time where class_id = ?"); // 연결되어 있던 _Time 삭제
            pstmt.setString(1, class_id);
            pstmt.executeUpdate();

            pstmt = conn.prepareStatement("delete from _Class where class_id = ?"); // _Class 삭제
            pstmt.setString(1, class_id);
            pstmt.executeUpdate();

            return 0;
        } catch (Exception e){
            e.printStackTrace();
            return -1;
        }
    }

    public List<CourseInfo> olap() {
        try {
            List<String> idList = new ArrayList();
            List<CourseInfo> ret = new ArrayList();

            pstmt = conn.prepareStatement("select student_id from student;");
            rs = pstmt.executeQuery();
            while (rs.next()){
                idList.add(rs.getString(1));
            }

            for (String id : idList){
                pstmt = conn.prepareStatement("update student set avg = (select avg(grade) from takes where student_id = ?)\n" +
                        "where student_id = ?");
                pstmt.setString(1, id);
                pstmt.setString(2, id);
                pstmt.executeUpdate();
            }

            idList.clear();
            pstmt = conn.prepareStatement("select takes_id from takes;");
            rs = pstmt.executeQuery();
            while (rs.next()){
                idList.add(rs.getString(1));
            }

            for (String id : idList){
                pstmt = conn.prepareStatement("update takes set dev = (select ret \n" +
                        "from (select student.avg as ret from takes \n" +
                        "join student on takes.student_id = student.student_id \n" +
                        "where takes_id = ?) A) - grade where takes_id = ?;");
                pstmt.setString(1, id);
                pstmt.setString(2, id);
                pstmt.executeUpdate();
            }

            idList.clear();
            pstmt = conn.prepareStatement("select course_id from course;");
            rs = pstmt.executeQuery();
            while (rs.next()){
                idList.add(rs.getString(1));
            }

            for (String id : idList){
                pstmt = conn.prepareStatement("update course set dev = (select ret from (select avg(takes.dev)\n" +
                        "as ret from takes join _class on takes.class_id = _class.class_id\n" +
                        "join course on _class.course_id = course.course_id\n" +
                        "where course.course_id = ?) A) where course_id = ?;");
                pstmt.setString(1, id);
                pstmt.setString(2, id);
                pstmt.executeUpdate();
            }

            pstmt = conn.prepareStatement("select course_id, name, dev from course order by dev desc limit 10;");
            rs = pstmt.executeQuery();
            while (rs.next()){
                ret.add(new CourseInfo(rs.getString(1), rs.getString(2), rs.getString(3)));
            }

            return ret;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
