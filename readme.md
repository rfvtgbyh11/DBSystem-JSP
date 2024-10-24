# SCHEMA & Site Design & SQL

# SCHEMA 디자인

SCHMA의 디자인은 다음과 같다.

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598.png)

## 사이트 디자인

페이지의 UI는 동영상으로 대체 가능하므로 생략한다.

## INPUT 데이터 설명

student)

student_id (학번), password (로그인 비밀번호), name,

advisor_id (지도교수) , major_id (전공), status(재학/휴학/자퇴) 가 들어있는 data set을 만들었다.

takes)

해당 Table에는 지금까지 수강했던 과목 + 이번학기에 수강할 과목이 들어간다. 그 둘의 구분은 join 되는 _class의 semester로 구분 가능하다.

takes_id는 auto_increment로 처리하였고, student_id (학생), _*class_*id(과목), grade (지난학기의 경우 학점, 이번학기의 경우 null) 3가지 정보만 input하였다.

major)

major_id 는 auto_increment, 전공만 input 하였다.

lecturer)

lecturer_id (교수 사번), name, major_id (전공)

course)

course_id (학수번호), name(과목 이름), credit(과목 학점), major_id(전공)

_class)

class_id 는 auto_increment, class_no (학수번호), person_num(현재인원), person_max( 최대인원), semester( 학기:20222), course_id (과목, 과목이름과 학점을 알기위해 거의 항상 join하여 사용하였다) , lecturer_id(강사)

wish)

dataset을 따로 input하지는 않았다.

_time)

class_id(수업 1개당 최대 2개의 time 생길수 있음), period(1 or 2), begin, end, room_id(해당 시간의 방번호)

room)

building_id, room_num(방번호), room_max(허용인원)

building)

name

admin)

ID, PW(관리자 계정)

## 구현 설명

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%201.png)

학생 창의 페이지 이동방식이다.

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%202.png)

post 방식으로 데이터를 받아 login_action으로 넘겨준다.

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%203.png)

login_action에서는 데이터를 UserDAO 객체를 이용하여 처리한다.

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%204.png)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%205.png)

student_main에서는 학생 데이터들을 받아 나타내고 수정할수 있는 post 버튼을 만들어놓는다.

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%206.png)

수강신청 페이지는 List(수업 Structure) 꼴로 받아온 데이터를 for문을 이용해 리스트로 만들었다.

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%207.png)

ClassInfo에 day부터 크기 2짜리 배열을 놓은 이유는 2개의 time table과 join하는것을 반영하기 위해서이다.

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%208.png)

다음과 같이 검색을 바탕으로 20222 학기의 자료에서 sql쿼리를 수행하고 join할 time을 class_id 를 이용하여 찾는다.

그러면 _ClassInfo가 완성된다.

수강신청 페이지 말고 희망수업 페이지와 수강내역 페이지도 비슷한 방식을 사용한다.

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%209.png)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2010.png)

수강신청 메소드는 우선 같은 과목의 과거학기 성적 & 이번학기 성적을 검사하여 take 테이블에 데이터가 이미 있으면 오류를 반환한다.

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2011.png)

시간이 겹치는지는 수강신청한 시간들과 대조해봐서 확인한다.

수강신청한 시간의 시작, 끝, 수강신청하려고 하는 시간의 시작, 끝을 비교하면 겹치는지 알 수 있다.

이 때 비교를 수월하게 하기 위해 LocalTime 자료형을 빌려왔다.

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2012.png)

과목을 신청했을때 18학점 초과되는 경우 학점 초과 에러를 만들어낸다.

이전에 상술했던 것중 어느것도 해당하지 않으면 TAKES가 UPDATE되고 CLASS의 현재인원이 1 늘어나면서 수강신청이 완료된다.

희망추가도 비슷한 방식을 사용한다.

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2013.png)

희망내역과 수강내역은 검색없이 학번만을 보고 찾아내야 하므로 TAKES 테이블의 student_id 항목을 이용한다. class_id 목록을 뽑아내 모든 정보를 얻으면 된다. return value는 마찬가지로 List(_ClassInfo)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2014.png)

표를 만들어서 for문을 사용하는 것도 같다. 아래에는 버튼을 만들어 get 방식으로 class_id를 주고받아 수강신청 / 취소, 희망신청 / 취소를 할수 있도록 한다.

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2015.png)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2016.png)

시간표는 각 시간을 나타내는 table을 만든다. 그 시간에 해당하는 과목이 있는지 courselist에서 찾아보고 있으면 그 칸을 강의시간만큼 칠한다. 18시 이후는 칠하지 않는다.

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2017.png)

 관리자 창의 페이지 이동방식이다.

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2018.png)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2019.png)

수강신청처럼 표를 만들어 목록을 나열한다. StudentInfo structure를 사용한다.

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2020.png)

Admincourse도 수강신청 페이지와 비슷하지만 과목 추가, 수정, 삭제 그리고 OLAP 링크가 들어있다.

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2021.png)

addClass, updateClass는 모든 과목에 필요한 데이터를 받는다.

개설 가능한지 체크(공간 체크, 학수번호 체크는 Foreign key integrity때문에 해야된다고 판단) 하고 가능하면 해당 데이터를 모두 집어넣어 _Class를 만들고 이어지는 _Time을 최대 2개까지 만든다. 18시 이후 과목이거나 토요일이거나 온라인 강의로 체크되었을 경우 time의 시간, 공간은 null이다.

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2022.png)

delete할 때는 class_id를 갖는 모든 table의 해당 데이터를 삭제(Foreign key integrity) 하고 _Class를 삭제한다.

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2023.png)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2024.png)

olap는 우선 student의 avg column에 각 학생의 평균을 계산하여 update한다.

그 후 그것을 기반으로 학생의 takes 안에 있는 grade와 avg를 이용해 편차 dev를 takes에 작성하고,

course에 dev의 평균을 과목별로 묶어 저장한다.

course 테이블에 dev 작성이 끝났으면 정렬하여 출력하면 된다.

[https://www.notion.so](https://www.notion.so)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2025.png)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2026.png)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2027.png)

(재학상태 변경)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2028.png)

(수강신청 페이지)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2029.png)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2030.png)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2031.png)

(에러메세지)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2032.png)

(희망 내역)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2033.png)

수강내역

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2034.png)

시간표

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2035.png)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2036.png)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2037.png)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2038.png)

(학생 정보 조회 & 시간표, 학점 조회 & 재학상태변경)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2039.png)

과목 조회 페이지

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2040.png)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2041.png)

최대 인원 제한

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2042.png)

학수번호 제한

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2043.png)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2044.png)

과목이 추가된 모습

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2045.png)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2046.png)

과목 수정

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2047.png)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2048.png)

과목 삭제

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2049.png)

과목 통계(학점편차)

![캡처.PNG](SCHEMA%20&%20Site%20Design%20&%20SQL%20b91a18b3c0d540509fe6042e9f621420/%25EC%25BA%25A1%25EC%25B2%2598%2050.png)

로그아웃