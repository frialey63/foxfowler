      SUBROUTINE YEARCHECK (WORD, IFLAG)
      
C     "REFERENCE CHARACTERS"
      DIMENSION CH(12)
      DATA  CH(1), CH(2), CH(3)/1H1,1H2,1H3/
      DATA  CH(4), CH(5), CH(6)/1H4,1H5,1H6/
      DATA  CH(7), CH(8), CH(9)/1H7,1H8,1H9/
      DATA CH(10),CH(11),CH(12)/1H0,1H ,1H//

      IFLAG = 0

C     "CHECK EACH LETTER OF WORD FOR VALIDITY"
      DO 1 K=1,4
          DO 2 L=1,12
              I = 1
              CALL COMP(I, WORD, K, CH(L), 1)
              IF (I.EQ.1) GO TO 1
    2     CONTINUE
C         "INVALID CHARACTER FOUND"
          GO TO 3
    1     CONTINUE

C     "COMPLETE WORD IS VALID"
      IFLAG = 1
      GO TO 5
    3 WRITE (6,4)

    5 RETURN

    4 FORMAT(1H , 8HERROR - , 24HCHARACTERS FOR BANK YEAR,
     &31H MUST BE EITHER DIGITS, SPACES /1H , 10HOR SLASHES/
     &1H , 13HPLEASE RETYPE)

      END
