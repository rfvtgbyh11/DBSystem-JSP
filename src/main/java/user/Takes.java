package user;

public class Takes {
    int takes_id; // PK, auto_increment
    int student_id; // FK
    int class_id; // FK
    String grade;
    Double dev;

    public int getTakes_id() {
        return takes_id;
    }

    public void setTakes_id(int takes_id) {
        this.takes_id = takes_id;
    }

    public int getStudent_id() {
        return student_id;
    }

    public void setStudent_id(int student_id) {
        this.student_id = student_id;
    }

    public int getClass_id() {
        return class_id;
    }

    public void setClass_id(int class_id) {
        this.class_id = class_id;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public Double getDev() {
        return dev;
    }

    public void setDev(Double dev) {
        this.dev = dev;
    }
}
