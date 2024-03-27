      PROGRAM TEST_COMP

      INTEGER PASSWD

      DIMENSION CH(3), CF(3)
      DATA CH(1),CH(2),CH(3)/1HA,1HB,1HC/
      DATA CF(1),CF(2),CF(3)/1HA,1HB,1HC/

      READ(5, 2) PASSWD
      WRITE(6, 2) PASSWD

      I = 1
      CALL COMP(I, PASSWD, 2, CF(2), 1)
      WRITE(6, 1) I

      STOP
      
    1 FORMAT(4HI = , I2)  
    2 FORMAT(A4)
      END
