      SUBROUTINE CTRSM( SIDE, UPLO, TRANSA, DIAG, M, N, ALPHA, A, LDA,
     $                  B, LDB )
*
*  -- Automatically Tuned Linear Algebra Software (ATLAS)
*     (C) Copyright 2000 All Rights Reserved
*
*  -- ATLAS routine -- F77 Interface -- Version 3.2 -- December 25, 2000
*
*  -- Suggestions,  comments,  bugs reports should be sent to the follo-
*     wing e-mail address: atlas@cs.utk.edu
*
*  Author         : Antoine P. Petitet
*  University of Tennessee - Innovative Computing Laboratory
*  Knoxville TN, 37996-1301, USA.
*
*  ---------------------------------------------------------------------
*
*  -- Copyright notice and Licensing terms:
*
*  Redistribution  and  use in  source and binary forms, with or without
*  modification, are  permitted provided  that the following  conditions
*  are met:
*
*  1. Redistributions  of  source  code  must retain the above copyright
*     notice, this list of conditions and the following disclaimer.
*  2. Redistributions in binary form must reproduce  the above copyright
*     notice,  this list of conditions, and the  following disclaimer in
*     the documentation and/or other materials provided with the distri-
*     bution.
*  3. The name of the University,  the ATLAS group,  or the names of its
*     contributors  may not be used to endorse or promote products deri-
*     ved from this software without specific written permission.
*
*  -- Disclaimer:
*
*  THIS  SOFTWARE  IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
*  ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,  INCLUDING,  BUT NOT
*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
*  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE UNIVERSITY
*  OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,  INDIRECT, INCIDENTAL, SPE-
*  CIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
*  TO,  PROCUREMENT  OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
*  OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEO-
*  RY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT  (IN-
*  CLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
*  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
*  ---------------------------------------------------------------------
*
*     .. Scalar Arguments ..
      CHARACTER*1        SIDE, UPLO, TRANSA, DIAG
      INTEGER            M, N, LDA, LDB
      COMPLEX            ALPHA
*     ..
*     .. Array Arguments ..
      COMPLEX            A( LDA, * ), B( LDB, * )
*     ..
*
*  Purpose
*  =======
*
*  CTRSM  solves one of the matrix equations
*
*     op( A ) * X = alpha * B,   or  X * op( A ) = alpha * B,
*
*  where alpha is a scalar, X and B are m by n matrices, A is a unit, or
*  non-unit, upper or lower triangular matrix and op( A ) is one of
*
*     op( A ) = A   or   op( A ) = A'   or   op( A ) = conjg( A' ).
*
*  The matrix X is overwritten on B.
*
*  Arguments
*  =========
*
*  SIDE    (input)                       CHARACTER*1
*          On entry, SIDE  specifies whether op( A ) appears on the left
*          or right of X as follows:
*
*             SIDE = 'L' or 'l'   op( A ) * X = alpha * B,
*
*             SIDE = 'R' or 'r'   X * op( A ) = alpha * B.
*
*          Unchanged on exit.
*
*  UPLO    (input)                       CHARACTER*1
*          On entry, UPLO  specifies whether  the  matrix is an upper or
*          lower triangular matrix as follows:
*
*              UPLO = 'U' or 'u'   A is an upper triangular matrix.
*
*              UPLO = 'L' or 'l'   A is a lower triangular matrix.
*
*          Unchanged on exit.
*
*  TRANSA  (input)                       CHARACTER*1
*          On entry, TRANSA  specifies the form of op( A ) to be used in
*          the matrix multiplication as follows:
*
*             TRANSA = 'N' or 'n'  op( A ) = A,
*
*             TRANSA = 'T' or 't'  op( A ) = A',
*
*             TRANSA = 'C' or 'c'  op( A ) = conjg( A' ).
*
*          Unchanged on exit.
*
*  DIAG    (input)                       CHARACTER*1
*          On entry, DIAG specifies whether or not A is unit triangu-
*          lar as follows:
*
*             DIAG = 'U' or 'u'   A is assumed to be unit triangular.
*
*             DIAG = 'N' or 'n'   A is not assumed to be unit
*                                 triangular.
*
*          Unchanged on exit.
*
*  M       (input)                       INTEGER
*          On entry,  M  specifies the number of rows of  the  matrix B.
*          M  must be at least zero. Unchanged on exit.
*
*  N       (input)                       INTEGER
*          On entry, N  specifies the number of columns of the matrix B.
*          N  must be at least zero. Unchanged on exit.
*
*  ALPHA   (input)                       COMPLEX
*          On entry,  ALPHA  specifies  the scalar  alpha. When ALPHA is
*          supplied as zero then the elements of the matrix B need   not
*          be set on input. Unchanged on exit.
*
*  A       (input)                       COMPLEX array
*          On entry, A is an array of DIMENSION ( LDA, k ), where k is m
*          when  SIDE = 'L' or 'l'  and  is  n  when  SIDE = 'R' or 'r'.
*          Before  entry  with  UPLO = 'U' or 'u',  the  leading  k by k
*          upper  triangular part of the array  A must contain the upper
*          triangular  matrix  and the strictly lower triangular part of
*          A  is  not  referenced. Before entry with  UPLO = 'L' or 'l',
*          the leading k by k lower triangular part of the array  A must
*          contain  the  lower  triangular matrix and the strictly upper
*          triangular part of A is not referenced.
*          Note  that when  DIAG = 'U' or 'u',  the diagonal elements of
*          A  are  not referenced either,  but are assumed to be  unity.
*          Unchanged on exit.
*
*  LDA     (input)                       INTEGER
*          On entry,  LDA specifies the first dimension of A as declared
*          in the  calling (sub) program.  When  SIDE = 'L' or 'l'  then
*          LDA  must  be at least  max( 1, m ),  when  SIDE = 'R' or 'r'
*          then LDA must be at least max( 1, n ). Unchanged on exit.
*
*  B       (input/output)                COMPLEX array
*          On entry, B is an array of DIMENSION (LDB, n).  Before entry,
*          the leading  m by n  part of the array B must contain the ma-
*          trix B, except when beta is zero, in which case B need not be
*          set on entry. On exit, the array B is overwritten by the m by
*          n solution matrix.
*
*  LDB     (input)                       INTEGER
*          On entry,  LDB specifies the first dimension of B as declared
*          in   the  calling  (sub)  program.   LDB  must  be  at  least
*          max( 1, m ). Unchanged on exit.
*
*  Further Details
*  ===============
*
*  For further information on the Level 1 BLAS specification, see:
*
*  ``A Proposal for Standard Linear Algebra Subprograms''  by R. Hanson,
*  F. Krogh and C. Lawson, ACM SIGNUM Newsl., 8(16), 1973,
*
*  ``Basic Linear Algebra Subprograms for Fortran Usage''  by C. Lawson,
*  R. Hanson, D. Kincaid and F. Krogh,  ACM Transactions on Mathematical
*  Software, 5(3) pp 308-323, 1979.
*
*  For further information on the Level 2 BLAS specification, see:
*
*  ``An  Extended Set of  FORTRAN  Basic Linear Algebra Subprograms'' by
*  J. Dongarra,  J. Du Croz,  S. Hammarling and R. Hanson,  ACM Transac-
*  tions on Mathematical Software, 14(1) pp 1-17, 1988.
*
*  ``Algorithm 656: An extended Set of Basic Linear Algebra Subprograms:
*  Model Implementation and Test Programs''  by J. Dongarra, J. Du Croz,
*  S. Hammarling and R. Hanson,  ACM  Transactions on Mathematical Soft-
*  ware, 14(1) pp 18-32, 1988.
*
*  For further information on the Level 3 BLAS specification, see:
*
*  ``A Set of Level 3 Basic Linear Algebra Subprograms'' by J. Dongarra,
*  J. Du Croz, I. Duff and S. Hammarling, ACM Transactions on Mathemati-
*  cal Software, 16(1), pp 1-17, 1990.
*
*  =====================================================================
*
*     .. Parameters ..
      INTEGER            ILEFT, IRIGHT
      PARAMETER          ( ILEFT = 141, IRIGHT = 142 )
      INTEGER            ILOWER, IUPPER
      PARAMETER          ( IUPPER = 121, ILOWER = 122 )
      INTEGER            ICOTRAN, INOTRAN, ITRAN
      PARAMETER          ( INOTRAN = 111, ITRAN = 112, ICOTRAN = 113 )
      INTEGER            INONUNIT, IUNIT
      PARAMETER          ( INONUNIT = 131, IUNIT = 132 )
*     ..
*     .. Local Scalars ..
      INTEGER            IDIAG, INFO, ISIDE, IUPLO, ITRANS, NROWA
*     ..
*     .. External Subroutines ..
      EXTERNAL           ATL_F77WRAP_CTRSM, XERBLA
*     ..
*     .. External Functions ..
      EXTERNAL           LSAME
      LOGICAL            LSAME
*     ..
*     .. Intrinsic Functions ..
      INTRINSIC          MAX
*     ..
*     .. Executable Statements ..
*
      INFO = 0
*
      IF(      LSAME( SIDE  , 'L' ) ) THEN
         ISIDE = ILEFT
         NROWA = M
      ELSE IF( LSAME( SIDE  , 'R' ) ) THEN
         ISIDE = IRIGHT
         NROWA = N
      ELSE
         ISIDE = ILEFT
         NROWA = 0
         INFO  = 1
      END IF
*
      IF(      LSAME( UPLO  , 'U' ) ) THEN
         IUPLO = IUPPER
      ELSE IF( LSAME( UPLO  , 'L' ) ) THEN
         IUPLO = ILOWER
      ELSE IF( INFO.EQ.0 ) THEN
         IUPLO = IUPPER
         INFO  = 2
      END IF
*
      IF(      LSAME( TRANSA, 'N' ) ) THEN
         ITRANS = INOTRAN
      ELSE IF( LSAME( TRANSA, 'T' ) ) THEN
         ITRANS = ITRAN
      ELSE IF( LSAME( TRANSA, 'C' ) ) THEN
         ITRANS = ICOTRAN
      ELSE IF( INFO.EQ.0 ) THEN
         ITRANS = INOTRAN
         INFO   = 3
      END IF
*
      IF(      LSAME( DIAG  , 'N' ) ) THEN
         IDIAG = INONUNIT
      ELSE IF( LSAME( DIAG  , 'U' ) ) THEN
         IDIAG = IUNIT
      ELSE IF( INFO.EQ.0 ) THEN
         INFO  = 4
      END IF
*
      IF( INFO.EQ.0 ) THEN
         IF(      M  .LT.0               ) THEN
            INFO = 5
         ELSE IF( N  .LT.0               ) THEN
            INFO = 6
         ELSE IF( LDA.LT.MAX( 1, NROWA ) ) THEN
            INFO = 9
         ELSE IF( LDB.LT.MAX( 1, M     ) ) THEN
            INFO = 11
         END IF
      END IF
*
      IF( INFO.NE.0 ) THEN
         CALL XERBLA( 'CTRSM ', INFO )
         RETURN
      END IF
*
      CALL ATL_F77WRAP_CTRSM( ISIDE, IUPLO, ITRANS, IDIAG, M, N,
     $                        ALPHA, A, LDA, B, LDB )
*
      RETURN
*
*     End of CTRSM
*
      END
