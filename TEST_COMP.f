      PROGRAM TEST_COMP

      DIMENSION CH(3), CF(3)
      DATA CH(1), CH(2), CH(3)/1HA, 2HAB, 3HABC/
      DATA CF(1), CF(2), CF(3)/1HA, 1HB, 1HC/

      INTEGER PASSWD

      READ(5, 2) PASSWD
      I = 3
      CALL COMP(I, PASSWD, 1, CH(3), 1)
      WRITE(6, 1) I
      STOP
      
    1 FORMAT(4HI = , I2)  
    2 FORMAT(A4)

      END
