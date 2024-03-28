      SUBROUTINE COMP(ILEN, REF, I, TST, J)

      INTEGER REF, TST

      MATCH = 0

      DO 1 L = 1, ILEN

      IREF = ISHFT(REF, -8 * (I + L - 2))
      IREF = IAND(Z'000000FF', IREF)

      ITST = ISHFT(TST, -8 * (J + L - 2))
      ITST = IAND(Z'000000FF', ITST)

      IF(IREF.EQ.ITST) GO TO 2
      GO TO 3
    2 MATCH = MATCH + 1
    1 CONTINUE  

    3 ILEN = MATCH 
      
      RETURN

      END
