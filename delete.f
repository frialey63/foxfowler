      PROGRAM DELETE

C     ASHMOLE SCHOOL PROJECT P.PARLETT 19 FEB
C     PROGRAM WK19 06

C     "INITIALISE ARRAYS AND SPECIAL VARIABLES"
      EXTERNAL DIGITS
      INTEGER ATEMPT
      COMMON ATEMPT
      INTEGER ACCTNO
      INTEGER CODENO, SHEETN, BALDT, TRANDT, F
      DIMENSION BANKYR(2), BRNAME(3), ANAME    (7),
     &BALMTH(3), TRANMH (3), TRANDE (7),
     &EOF (2), CSNAME (7)
      DATA EOF(1),EOF(2)/4HZZZZ,4HZZZZ/

C     "CHECK USER"
      CALL USERCHECK
C     "VALID USER"

      WRITE (1,1)
      F = 0

C     "REQUEST CUSTOMER DETAILS"
      WRITE (1,2)
  500 READ (3,3) CSNAME
      DO 501 N=1,7
      CALL FOURCHECK(CSNAME(N), IRESLT)
      IF(IRESLT.EQ.0) GO TO 500
  501 CONTINUE
      WRITE (1,4)
  510 ATEMPT = 0
      CALL FTRAP (DIGITS)
      READ (3,5) ACCTNO
      CALL FRESET
      IF(ATEMPT.GT.0) GO TO 510

C     "FIND CUSTOMER"
   11 READ (4,6) BANKYR
      DO 50 N=1,2
      I = 4
      CALL COMP(I,BANKYR(N), 1,EOF(N),1)
      IF(I.NE.4) GO TO 51
   50 CONTINUE
      GO TO 15
   51 READ (4,52) BRNAME, ANAME    , CODENO,
     &SHEETN, BALFWD, BALDT, BALMTH
      DO 53 M=1,7
      I = 4
      CALL COMP(I,ANAME    (M), 1, CSNAME (M), 1)
      IF(I.NE.4) GO TO 54
   53 CONTINUE
      IF(CODENO.EQ.ACCTNO) GO TO 22
      WRITE (1,21)
      STOP
   54 WRITE (2,55) BANKYR
      WRITE (2,56) BRNAME, ANAME    , CODENO,
     &SHEETN, BALFWD, BALDT, BALMTH
   14 READ (4,10) TRANDT
      WRITE (2,60) TRANDT
      IF(TRANDT.EQ.99) GO TO 11
      READ (4,12) TRANMH, TRANDE, DEBS, CREDS
      WRITE (2,13) TRANMH, TRANDE, DEBS, CREDS
      GO TO 14

C     "END OF FILE OLD"
   15 IF (F.EQ.1) GO TO 17
      WRITE (1,16) CSNAME, ACCTNO
      STOP
   17 WRITE (1,18) CODENO, ANAME    
      STOP

C     "CHECK IF THE ACCOUNT HAS ANY MONEY IN IT"
   22 TOTAL = BALFWD
   26 READ (4,10) TRANDT
      IF(TRANDT.EQ.99) GO TO 28
      READ (4,12) TRANMH, TRANDE, DEBS, CREDS
      IF (DEBS.EQ .- 1.0) GO TO 27
      TOTAL = TOTAL - DEBS
      GO TO 26
   27 TOTAL = TOTAL + CREDS
      GO TO 26
   28 IF (TOTAL.EQ.0.0) GO TO 32
      IF(TOTAL.GT.0.0) GO TO 30
      WRITE (1,29)
      STOP
   30 F = 1
      WRITE (1,31)
      STOP
   32 F = 1
      GO TO 11
      STOP

    1 FORMAT (1H /1H /1H /1H ,
     &20HRECORD DELETION MODE/1H /1H )
    2 FORMAT (1H ,27HPLEASE TYPE CUSTOMER'S NAME)
    3 FORMAT (7A4)
    4 FORMAT (1H ,30HPLEASE TYPE ACCOUNT CODENUMBER)
    5 FORMAT (I10)
    6 FORMAT (2A4)
   10 FORMAT (I2)
   12 FORMAT (3A1,7A4,2F10.0)
   13 FORMAT (1H ,3A1,7A4,2F10.2)
   16 FORMAT (1H ,15HERROR-CUSTOMER ,7A4,
     &16H ACCOUNT NUMBER ,I10,12H NOT ON FILE)
   18 FORMAT (1H ,18HRECORD CODENUMBER , I10,
     &15H CUSTOMER NAME ,7A4,
     &22H DELETED FROM NEW FILE)
   21 FORMAT (1H ,
     &24HERROR-ACCOUNT CODENUMBER,
     &30H DOESN'T MATCH CUSTOMER'S NAME)
   29 FORMAT (1H ,21HACCOUNT IN RED IT CAN,
     &30H ONLY BE DELETED WHEN REQUIRED,
     &20H AMOUNT IS DEPOSITED)
   31 FORMAT (1H ,28HACCOUNT IN BLACK IT CAN ONLY,
     &36H BE DELETED WHEN EXCESS IS WITHDRAWN)
   52 FORMAT (3A4,7A4,I10,I4,F11.0,I2,3A1)
   55 FORMAT (1H ,2A4)
   56 FORMAT (1H ,3A4,7A4,I10,I4,F11.2,I2,3A1)
   60 FORMAT (1H ,I2)

      END
