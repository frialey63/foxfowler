      PROGRAM BALANCE
      
C     ASHMOLE SCHOOL PROJECT P.PARLETT 18 FEB
C      PROGRAM WK19 05

C     1 INITIALISE ARRAYS AND SPECIAL VARIABLES
      EXTERNAL DIGITS
      DIMENSION BANKYR(2), BRNAME (3), ANAME (7),
     &BALMTH(3), TRANMH(3), TRANDE(7), EOF (2), CSNAME(7)
      INTEGER ATEMPT
      COMMON ATEMPT
      INTEGER CODENO, SHEETN, BALDT, TRANDT, ACCT
      DATA EOF(1),EOF(2)/4HZZZZ,4HZZZZ/

C     "CHECK THE USER"
      CALL USERCHECK
C     "VALID USER"

      WRITE (6,1)
C     2 REQUEST AND CHECK DETAILS OF CUSTOMER ACCOUNT"
      WRITE (6,2)
  500 READ (5,3) CSNAME
      DO 501 JFIELD=1,7
      CALL FOURCHECK(CSNAME( JFIELD), IRESLT)
      IF (IRESLT.EQ.0) GO TO 500
  501 CONTINUE
      WRITE (6,4)
  510 ATEMPT = 0
      CALL FTRAP (DIGITS)
      READ (5,5) ACCTNO
      CALL FRESET
      IF(ATEMPT.GT.0) GO TO 510

C     3 FIND CUSTOMER
   12 READ (4,6) BANKYR
C     "CHECK FOR END OF FILE"
      DO 40 N=1,2
      I = 4
      CALL COMP(I,BANKYR(N), 1,EOF(N),1)
      IF(I.NE.4) GO TO 41
   40 CONTINUE
      GO TO 13
   41 READ (4,7) BRNAME, ANAME, CODENO,
     &SHEETN, BALFWD, BALDT, BALMTH
      DO 42 M=1,7
      I = 4
      CALL COMP(I,ANAME(M), 1, CSNAME(M),1)
      IF(I.NE.4) GO TO 11
   42 CONTINUE
      IF (CODENO.EQ.ACCTNO) GO TO 18
      WRITE (6,17)
      STOP
   11 READ (4,9) TRANDT
      IF(TRANDT.EQ.99) GO TO 12
      READ (4,10) TRANMH, TRANDE, DEBS, CREDS
      GO TO 11
C     "END OF FILE OLD"
   13 WRITE (6,14) CSNAME, ACCTNO
      STOP
      
C     4 CORRECT RECORD FOUND
C     "OUTPUT A BALANCE"
   18 WRITE (6,19)
      WRITE (6,20) ANAME, CODENO, BANKYR, BRNAME
      WRITE (6,520) SHEETN
C     "WORK OUT PRESENT AND PREVIOUS BALANCES FOR OUTPUT"
      TOTAL = BALFWD
   24 READ (4,9) TRANDT
      IF(TRANDT.EQ.99) GO TO 26
      READ (4,10) TRANMH, TRANDE, DEBS, CREDS
      IF (DEBS.EQ .- 1.0) GO TO 25
      TOTAL = TOTAL - DEBS
      GO TO 24
   25 TOTAL = TOTAL + CREDS
      GO TO 24
   26 WRITE (6,27) BALFWD, TOTAL

C   5 BALANCE OUTPUT COMPLETED
      STOP
      
    1 FORMAT (1H /1H /1H /1H ,20HACCOUNT BALANCE MODE/1H /1H )
    2 FORMAT (1H ,27HPLEASE TYPE CUSTOMER'S NAME)
    3 FORMAT (7A4)
    4 FORMAT (1H ,30HPLEASE TYPE ACCOUNT CODENUMBER)
    5 FORMAT (I10)
    6 FORMAT (2A4)
    7 FORMAT (3A4,7A4,I10,I4,F11.0,I2,3A1)
    9 FORMAT (I2)
   10 FORMAT (3A1,7A4,2F10.0)
   14 FORMAT (1H ,15HERROR-CUSTOMER ,7A4/1H ,
     &16H ACCOUNT NUMBER , I10,12H NOT ON FILE)
   17 FORMAT (1H ,24HERROR-ACCOUNT CODENUMBER,
     &30H DOESN'T MATCH CUSTOMER'S NAME)
   19 FORMAT (1H /1H /1H /1H /1H /1H ,23X,23HDEPOSIT ACCOUNT BALANCE)
   20 FORMAT (1H /1H ,10X,7A4,26H ESQ. IN ACCOUNT WITH FOX, /1H ,39X,
     &28HFOWLER AND COMPANY (TAUNTON)/1H /1H ,
     &10X,I10/1H /1H /10X,5HYEAR , 2A4,18X,3A4,7H BRANCH)
   27 FORMAT (1H /1H ,10X,30HBALANCE AT LAST STATEMENT WAS ,
     &F11.2/1H /1H ,10X,19HPRESENT BALANCE IS ,F11.2)
  520 FORMAT (1H /1H ,10X,24HNEXT STATEMENT SHEET IS ,I4)

      END
