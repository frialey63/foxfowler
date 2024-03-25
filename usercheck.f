      SUBROUTINE USERCHECK

      WRITE (1,99)

C     "GIVE USER THREE ATTEMPTS"
      DO 100 ITEMPT=1,3

C     "READ PASSWORD AND VALIDATE"
  500 READ (3,101) PASSWD
      CALL FOURCHECK(PASSWD,IRESLT)
      IF(IRESLT.EQ.0) GO TO 500

C     "CHECK PASSWORD"
      J = 4
      CALL COMP(J,PASSWD,1,4HFOX ,1)
      IF (J.EQ.4) GO TO 102

C     "A WRONG PASSWORD"
      WRITE (1,103) PASSWD
      IF (ITEMPT.EQ.3) GO TO 100
      WRITE (1,104)
  100 CONTINUE

C     "USER HAS GIVEN THREE WRONG PASSWORDS"
      WRITE (1,105)
      STOP
      GO TO 107

C     "VALID USER"
  102 WRITE (1,106)

  107 RETURN

   99 FORMAT (1H /1H /1H /1H , 28HPLEASE TYPE PROGRAM PASSWORD)
  101 FORMAT (A4)
  103 FORMAT (1H ,A4, 28H IS NOT THE CORRECT PASSWORD/1H )
  104 FORMAT (1H , 30HPLEASE RETYPE PROGRAM PASSWORD)
  105 FORMAT (1H ,16HNOT A VALID USER)
  106 FORMAT (1H /1H /1H /1H ,10X,23HFOX, FOWLER AND COMPANY/
     &1H ,10X,24HPERSONAL ACCOUNTS SYSTEM)

      END
