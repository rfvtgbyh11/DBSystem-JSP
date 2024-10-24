package user;

public class _Time {
    int time_id; // PK
    int class_id;
    int period;
    int _day;
    int _begin;
    int _end;
    int room_id;

    public int getTime_id() {
        return time_id;
    }

    public void setTime_id(int time_id) {
        this.time_id = time_id;
    }

    public int getClass_id() {
        return class_id;
    }

    public void setClass_id(int class_id) {
        this.class_id = class_id;
    }

    public int getPeriod() {
        return period;
    }

    public void setPeriod(int period) {
        this.period = period;
    }

    public int get_day() {
        return _day;
    }

    public void set_day(int _day) {
        this._day = _day;
    }

    public int get_begin() {
        return _begin;
    }

    public void set_begin(int _begin) {
        this._begin = _begin;
    }

    public int get_end() {
        return _end;
    }

    public void set_end(int _end) {
        this._end = _end;
    }

    public int getRoom_id() {
        return room_id;
    }

    public void setRoom_id(int room_id) {
        this.room_id = room_id;
    }
}
