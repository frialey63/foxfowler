      SUBROUTINE COPY(ILEN, DST, I, SRC, J)

      DIMENSION DST(50), SRC(50)

      DO 1 L = 1, ILEN
      DST(I + L - 1) = SRC(J + L - 1)
    1 CONTINUE  

      RETURN

      END
