
--OTP Generation:

--OTP Details Table

create table OTP_detail(
    mobilenumber number,
    otp number,
    otpgenerartiontime varchar2(50),
    otpexpirytime varchar2(50)
)

---OTP GENERATION PROCEDURE

create or replace procedure OTP_GENERATION(Phone_num in NUMBER,OTP OUT NUMBER)
AS
BEGIN

SELECT trunc(dbms_random.value(100000,999999)) INTO  OTP FROM DUAL;


insert into otp_detail values(Phone_num,OTP,systimestamp,SYSTIMESTAMP + INTERVAL '1' MINUTE);

END;/

----OTP GENERATION PROCEDURE CALL(EXECUTE)
DECLARE 
OTP NUMBER;
BEGIN
OTP_GENERATION(9793945969,OTP);
DBMS_OUTPUT.PUT_LINE('OTP :'|| OTP);
END;/

---OTP VALIDATION Procedure

CREATE OR REPLACE PROCEDURE OTP_VALIDATION(P_PHONE IN NUMBER,OTP_num IN NUMBER,MESSAGE OUT VARCHAR2)
AS
l_count number;
begin
select count(1) into l_count
 from otp_detail 
 where mobilenumber=P_PHONE 
 and otp=OTP_num and 
 systimestamp between  otpgenerartiontime and otpexpirytime;

 if  l_count=1 then
     MESSAGE := 'OTP APPLIED SUCCESSFULLY';
 ELSE
      MESSAGE := 'OTP IS INVALID';
 END IF;
 END;/

--OTP VALIDATION PROCEDURE CALL(Execute)
DECLARE
MESSAGE VARCHAR2(50);
BEGIN
OTP_VALIDATION(9793945969,397556,MESSAGE);
DBMS_OUTPUT.PUT_LINE(MESSAGE);
END;/