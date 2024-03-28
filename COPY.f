      SUBROUTINE COPY(ILEN, DST, I, SRC, J)

      INTEGER DST, SRC

      IDST = DST
      ISRC = SRC

      DO 1 L = 1, ILEN

      IF(L.EQ.1) GO TO 10
      IF(L.EQ.2) GO TO 20
      IF(L.EQ.3) GO TO 30
      IF(L.EQ.4) GO TO 40

   10 IDST = IAND(Z'FFFFFF00', IDST)
      ISRC = IAND(Z'000000FF', SRC)
      GO TO 2
   20 IDST = IAND(Z'FFFF00FF', IDST)
      ISRC = IAND(Z'0000FF00', SRC)
      GO TO 2
   30 IDST = IAND(Z'FF00FFFF', IDST)
      ISRC = IAND(Z'00FF0000', SRC)
      GO TO 2
   40 IDST = IAND(Z'00FFFFFF', IDST)
      ISRC = IAND(Z'FF000000', SRC)
      GO TO 2

    2 IDST = IOR(IDST, ISRC)

    1 CONTINUE  

      DST = IDST

      RETURN

      END
