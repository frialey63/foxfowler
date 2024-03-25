      SUBROUTINE COMP(ILEN, REF, I, TST, J)

      DIMENSION REF(50), TST(50)

      MATCH = 0

      DO 1 L = 1, ILEN
      IF(REF(I + L - 1).EQ.TST(J + L - 1)) GO TO 2
      GO TO 3
    2 MATCH = MATCH + 1
    1 CONTINUE  

    3 ILEN = MATCH 
      
      RETURN

      END
