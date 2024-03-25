      SUBROUTINE DATECHECK (DAY,AMONTH, IFLAG)

      INTEGER DAY
      DIMENSION AMONTH(3), REF (36)

C     "MONTH NAME LIST"
      DATA REF(1),REF(2),REF(3)/1HJ,1HA,1HN/
      DATA REF(4),REF(5),REF(6)/1HF,1HE,1HB/
      DATA REF(7),REF(8),REF(9)/1HM,1HA,1HR/
      DATA REF(10),REF(11), REF(12)/1HA,1HP,1HR/
      DATA REF(13), REF(14),REF(15)/1HM,1HA,1HY/
      DATA REF(16),REF(17),REF(18)/1HJ,1HU,1HN/
      DATA REF(19),REF(20), REF(21)/1HJ,1HU,1HL/
      DATA REF(22), REF (23), REF(24)/1HA, 1HU, 1HG/
      DATA REF(25),REF(26), REF(27)/1HS,1HE,1HP/
      DATA REF(28),REF(29),REF(30)/1HO,1HC,1HT/
      DATA REF(31),REF(32),REF(33)/1HN,1H0,1HV/
      DATA REF(34),REF(35),REF(36)/1HD,1HE,1HC/

      IFLAG = 0

C     "TEST MONTH"
      DO 90 N=1,12
      DO 91 M=1,3
      L = 3*(N-1)+M
      I = 1
      CALL COMP (I,AMONTH(M), 1, REF (L),1)
      IF(I.NE.1) GO TO 90
   91 CONTINUE

C     "CORRECT MONTH"
      GO TO 92
   90 CONTINUE

C     "INCORRECT MONTH"
      WRITE (1,93)
      GO TO 95

C     "WHICH MONTH IS IT?"
   92 IF (N.EQ.2) GO TO 96
      IF(N.EQ.4.OR.N.EQ.6) GO TO 105
      IF (N.EQ.9.OR.N.EQ.11) GO TO 105
      IF (DAY.GE.1.AND.DAY.LE.31) GO TO 102

C     "DAY NOT WITHIN REQUIRED RANGE"
   99 WRITE (1,97)
      GO TO 95
  105 IF (DAY.GE.1.AND.DAY.LE.30) GO TO 102
      GO TO 99
   96 IF (DAY.GE.1.AND.DAY.LE.28) GO TO 102
      IF (DAY.EQ.29) GO TO 98
      GO TO 99

C     "FEBRUARY 29TH CASE"
   98 WRITE (1,100)
  104 READ (3,101) ANS
      CALL FOURCHECK(ANS,IRESLT)
      IF (IRESLT.EQ.0) GO TO 104
      I = 4
      CALL COMP (I,ANS,1,4HYES ,1)
      IF(I.EQ.4) GO TO 102
      I = 4
      CALL COMP(I,ANS, 1,4HNO  ,1)
      IF(I.EQ.4) GO TO 99
      WRITE (1,103)
      GO TO 104

C     "VALID DAY AND MONTH"
  102 IFLAG = 1

   95 RETURN

   93 FORMAT (1H ,18HMONTH IS INVALID -,28H PLEASE RETYPE COMPLETE DATE)
   97 FORMAT (1H ,16HDAY IS INVALID -,28H PLEASE RETYPE COMPLETE DATE)
  100 FORMAT (1H , 20HIS THIS A LEAP YEAR?)
  101 FORMAT (A4)
  103 FORMAT (1H ,18HINCORRECT ANSWER -,22H PLEASE TYPE YES OR NO)

      END

