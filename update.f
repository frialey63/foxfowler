      PROGRAM UPDATE

C     ASHMOLE SCHOOL PROJECT P.PARLETT 18 FEB

      EXTERNAL FLOAT, DAY, DIGITS
      INTEGER ATEMPT
      COMMON ATEMPT

      DIMENSION BANKYR(2), BRNAME (3), ANAME(7),
     &BALMTH(3), TRANMH(3), TRANDE(7), EOF(2), CSNAME(7)
      DIMENSION REPLY(2), X(2), Y(2)
      INTEGER ACCTNO, CODENO, SHEETN, BALDT, TRANDT
      DATA X(1), X(2)/ 4HCRED, 4HIT  /
      DATA Y(1), Y(2)/ 4HDEBI, 4HT   /
      DATA EOF(1), EOF(2)/ 4HZZZZ, 4HZZZZ/

      CALL USERCHECK

      WRITE(6,1)

C     THE FOUND (AKA F) FLAG 
      J = 0

      WRITE(6,2)
  500 READ(5,3) CSNAME
      DO 501 JFIELD=1,7
          CALL FOURCHECK (CSNAME(JFIELD), IRESLT)
          IF (IRESLT.EQ.0) GO TO 500
  501 CONTINUE
      WRITE(6,4)
  510 ATEMPT = 0
      CALL FTRAP (DIGITS)
      READ(5,5) ACCTNO
      CALL FRESET
      IF (ATEMPT.GT.0) GO TO 510

C     "UPDATE COPY"
   19 READ(4,6) BANKYR
      DO 80 N=1,2
          I = 4
          CALL COMP(I, BANKYR(N), 1, EOF(N), 1)
          IF (I.NE.4) GO TO 81
   80 CONTINUE
      GO TO 14

   81 WRITE(2,75) BANKYR
      READ(4,7) BRNAME, ANAME, CODENO, SHEETN, BALFWD, BALDT, BALMTH
      WRITE(2,200) BRNAME, ANAME, CODENO, SHEETN, BALFWD, BALDT, BALMTH
      DO 190 M=1,7
          I = 4
          CALL COMP (I, CSNAME(M), 1, ANAME(M), 1)
          IF (I.NE.4) GO TO 13
  190 CONTINUE
      IF (CODENO.EQ.ACCTNO) GO TO 20
      WRITE(6,18)
      STOP

   13 READ(4,10) TRANDT
      WRITE(2,74) TRANDT
      IF (TRANDT.EQ.99) GO TO 19
      READ(4,11) TRANMH, TRANDE, DEBS, CREDS
      WRITE(2,12) TRANMH, TRANDE, DEBS, CREDS
      GO TO 13

C     "END OF FILE OLD"
   14 WRITE(2,75) BANKYR
      IF (J.NE.0) STOP
      WRITE(6,15) CSNAME, ACCTNO
      STOP

   20 J = 1
   27 READ(4,10) TRANDT
      IF (TRANDT.EQ.99) GO TO 35
      WRITE(2,74) TRANDT
      READ(4,11) TRANMH, TRANDE, DEBS, CREDS
      WRITE(2,12) TRANMH, TRANDE, DEBS, CREDS
      GO TO 27

C     "UPDATE"
   48 WRITE(6,29)
   32 READ(5,30) ANS
      CALL FOURCHECK(ANS, IRESLT)
      IF (IRESLT.EQ.0) GO TO 32
      I = 4
      CALL COMP (I, ANS, 1, 4HYES , 1)
      IF (I.EQ.4) GO TO 35
      I = 4
      CALL COMP(I, ANS, 1, 4HNO  , 1)
      IF (I.EQ.4) GO TO 33
      WRITE(6,31)
      GO TO 32

C     "UPDATING FINISHED"
   33 TRANDT = 99
      WRITE(2,74) TRANDT
      GO TO 19

C     "UPDATING REQUESTS"
   35 WRITE(6,36)
      WRITE(6,502)
  503 ATEMPT = 0
      CALL FTRAP(DAY)
      READ(5,37) TRANDT, TRANMH
      CALL FRESET
      IF (ATEMPT.GT.0) GO TO 503
      CALL DATECHECK(TRANDT, TRANMH, JFLAG)
      IF (JFLAG.EQ.0) GO TO 503
      WRITE(6,38)
  504 READ(5,39) TRANDE
      DO 505 JFIELD=1,7
          CALL FOURCHECK (TRANDE(JFIELD), IRESLT)
          IF (IRESLT.EQ.0) GO TO 504
  505 CONTINUE
      WRITE(6,40)
   43 READ(5,41) REPLY
      DO 506 JFIELD=1,2
          CALL FOURCHECK (REPLY(JFIELD), IRESLT)
          IF (IRESLT.EQ.0) GO TO 43
  506 CONTINUE
      DO 60 K=1,2
          I = 4
          CALL COMP(I, REPLY(K), 1, X(K), 1)
          IF (I.NE.4) GO TO 61
   60 CONTINUE
      GO TO 49
   61 DO 62 L=1,2
          I = 4
          CALL COMP (I, REPLY(L), 1, Y(L), 1)
          IF (I.NE.4) GO TO 63
   62 CONTINUE
      GO TO 44
   63 WRITE(6,42)
      GO TO 43
   44 WRITE(6,45)
  512 ATEMPT = 0
      CALL FTRAP(FLOAT)
      READ(5,46) DEBS
      CALL FRESET
      IF (ATEMPT.GT.0) GO TO 512
      CREDS = -1.0
      GO TO 65
   49 WRITE(6,50)
  513 ATEMPT = 0
      CALL FTRAP(FLOAT)
      READ(5,51) CREDS
      CALL FRESET
      IF (ATEMPT.GT.0) GO TO 513
      DEBS = -1.0
      GO TO 65
   65 WRITE(2,74) TRANDT
      WRITE(2,12) TRANMH, TRANDE, DEBS, CREDS
      GO TO 48

      STOP
   
    1 FORMAT(1H /1H /1H , 18HRECORD UPDATE MODE)
    2 FORMAT(1H /1H /1H /1H , 27HPLEASE TYPE CUSTOMER'S NAME)
    3 FORMAT(7A4)
    4 FORMAT(1H , 30HPLEASE TYPE ACCOUNT CODENUMBER)
    5 FORMAT(I10)
    6 FORMAT(2A4)
    7 FORMAT(3A4, 7A4, I10, I4, F11.0, I2, 3A1)
   10 FORMAT(I2)
   11 FORMAT(3A1, 7A4, 2F10.0)
   12 FORMAT(1H , 3A1, 7A4, 2F10.2)
   15 FORMAT(1H , 15HERROR-CUSTOMER , 7A4, 9H ACCOUNT ,
     &I10, 13H DO NOT EXIST)
   18 FORMAT(1H , 31HERROR-CODENO DOESN'T MATCH NAME)
   29 FORMAT(1H , 21HANY MORE TRANSACTIONS, 11H-YES OR NO?)
   30 FORMAT(A4)
   31 FORMAT(1H , 12HERROR-RETYPE)
   36 FORMAT(1H /1H /1H , 19HPLEASE TYPE DATE OF, 12H TRANSACTION)
   37 FORMAT(I2, 1X, 3A1)
   38 FORMAT(1H , 35HPLEASE TYPE TRANSACTION INFORMATION)
   39 FORMAT(7A4)
   40 FORMAT(1H , 21HIS THIS TRANSACTION A, 19H DEBIT OR A CREDIT?)
   41 FORMAT(2A4)
   42 FORMAT(1H , 12HERROR-RETYPE)
   45 FORMAT(1H , 27HPLEASE TYPE AMOUNT OF DEBIT)
   46 FORMAT(F10.0)
   50 FORMAT(1H , 28HPLEASE TYPE AMOUNT OF CREDIT)
   51 FORMAT(F10.0)
   74 FORMAT(1H , I2)
   75 FORMAT(1H , 2A4)
  200 FORMAT(1H , 3A4, 7A4, I10, I4, F11.2, I2, 3A1)
  502 FORMAT(1H , 39HAS TWO DIGITS A SPACE AND THREE LETTERS)

      END
