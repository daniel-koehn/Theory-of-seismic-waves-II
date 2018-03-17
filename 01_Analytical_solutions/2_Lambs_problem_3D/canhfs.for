      PROGRAM CANHFS  

C===================================================================================
C 1. VARIABLE INITIALIZATION 
C===================================================================================
      PARAMETER (NFIN=2,NFPR=3,NFOU=4,NDDD=12,NDCM=10,NDNR=36,NDNT=1030)
      
      REAL*4 P(NDDD),DP(NDDD),S(NDDD),DS(NDDD),
     1     RED(NDNR),TID(NDNR),G(NDCM,NDNT)
      
      COMPLEX SA,SA2,SB,SB2,EA,EB,EAB,RR,CA,CR,CI,C1,C2,C3,C4,C5
      
      CHARACTER*80 ALPN, FYLE
      
      PARAMETER (PI=3.14159265358979, CR=(1.0,0.0), CI=(0.0,1.0),
     1     EPS=1.0E-6, NOR=19, DDS=0.15, DRS=0.02)

C===================================================================================
C 2. FORMATING 
C===================================================================================
10    FORMAT (A) 
12    FORMAT (' INPUT FILE NAME  = ',$)
14    FORMAT (' OUTPUT FILE NAME = ',$)
16    FORMAT (1H ,A)  
20    FORMAT (8F10.4) 
44    FORMAT (5E16.7) ! 5 times E14.7   7 points after . each field have 14 places
      
C===================================================================================
C 3. OPEN FILES 
C===================================================================================
      !PRINT 12 
      !READ 10, FYLE
      !OPEN (NFIN, FILE="input.txt", STATUS='OLD', FORM='FORMATTED')
      OPEN (NFIN, FILE="input.txt")
      !PRINT 14
      !READ 10, FYLE
      OPEN (NFOU, FILE="output.txt")
      
C===================================================================================
C 4. READ FROM INPUT 
C===================================================================================
      READ (NFIN,*) VP,VS,RHO,NT,DT,H,R,T
    
C===================================================================================
C 5. SET PARAMETERS AND VARIABLES 
C=================================================================================== 
      NG = 5       	    ! NG      
      VPI = 1.0/VP**2       ! (1/alpha)^2 
      VSI = 1.0/VS**2       ! (1/beta)^2
      VI = SQRT(VSI - VPI)  ! (1/beta^2 - 1/alpha^2)^1/2, appears in p_2                           
      !R = RED(1)            ! R = x_1 
      !T = TID(1)            ! t_i
      RS = SQRT(R*R + H*H)  ! r = (R^2 + H^2)^1/2 
      STH = R/RS     	    ! sin_th = R/RS
      CTH = H/RS      	    ! cos_th = H/R
      SC = 1.0/(RS*PI*PI) * VSI/RHO  ! 1/(pi^2 * r * mu) coeficient in integrals   

C===================================================================================
C 6. MAIN LOOP: OVER nt (Number of points in t)  
C===================================================================================         
      DO 600 I=1, NT                      
         DO 150 J=1, NG ! LOOP OVER NG=5
            P(J) = 0.0    ! Initialize P_1x12 with zeros for each nt 
            S(J) = 0.0    ! Initialize S_1x12 with zeros for each nt
150      CONTINUE 
                  
      TP = RS/VP    ! r/alpha, p arrival time     
      IF (T .GT. TP) THEN ! compute integrals for t > t_p, IMPORTANT !!!!
	!===================================================================================
	! Settings for alpha wave Integral   
	!===================================================================================                      
         TR = T/RS            ! t/r
         TA2 = TR*TR - VPI    ! (t/r)^2 - (1/alpha)^2
         TA = SQRT(TA2)       ! ((t/r)^2 - (1/alpha)^2)^1/2 Upper limit in integral (26)
         TL = SQRT(TA)        ! ((t/r)^2 - (1/alpha)^2)^1/4 Upper limit in integral (134)

         DI = 0.0	      ! Set nu = 0 for each nt
	!===================================================================================
	! Integral for alpha wave for each nt  
	!===================================================================================  
	! LOOP 1: IF BLOCK AND GO TO, Integral in alpha!!!        
200      DD = 0.15      ! Loop tag      Why this value, while nu < t_uplim                        
         D1 = TL - DI	! ((t/r)^2 - (1/alpha)^2)^1/4 - nu               
         IF (D1 .LT. DD) THEN
            DD = D1
         END IF         
      
         CALL ROMS (K, NG, DI, P, DP, DD, EPS, NOR)

	! LOOP 1.1: IF BLOCK AND GO TO, Integral in alpha!!!
210      CONTINUE      ! Loop tag               
         DL = TA - DI*DI                   ! p = ((t/r)^2 - (1/alpha)^2)^1/2 - nu^2 substitution to remove singularity
	 DL2 = DL*DL                       ! p^2 
	 CL = 2.0/SQRT(TA + DL)	   	   ! 2 * (2*((t/r)^2 - (1/alpha)^2)^1/2 - nu^2)^1/2 Coeficient in integral (134)   
	 D1 = -TR*STH                      ! -t/r * sin_th
	 D2 = SQRT(ABS(TA2 - DL2))*CTH     ! ((t/r)^2 - (1/alpha)^2 - p^2)^1/2 * cos_th
	 SA = CMPLX(D1, D2)                ! q = -t/r * sin_th + i((t/r)^2 - (1/alpha)^2 - p^2)^1/2 * cos_th Equation (31)
	 SA2 = SA*SA 			   ! q^2
	 C4 = SA2 + DL2		   	   ! q^2 + p^2
	 C1 = SA2 - DL2		           ! q^2 - p^2
	 EA = CSQRT(VPI - C1)		   ! eta_alpha = ((1/alpha)^2 - q^2 + p^2)^1/2 Equation (21)
	 EB = CSQRT(VSI - C1)		   ! eta_beta = ((1/beta)^2 - q^2 + p^2)^1/2 Equation (23)
	 EAB = EA*EB 			   ! eta_alpha * eta_beta
	 C2 = EB*EB - C1 		   ! gamma = eta_beta^2 + p^2 - q^2 Equation (29)
	 C5 = C1 - 2.0*EA*EA 		   ! q^2 - p^2 - 2*eta_alpha^2
	 RR = 1.0/(C2*C2 + 4.0*EAB*C1)	   ! sigma^-1 = 1/(gamma^2 + 4*eta_alpha * eta_beta * (q^2 - p^2)) Equation (30)
               
         ! Assembly M_ij			 
         DP(1) = REAL(2.0*CL*EAB*SA2*RR)	! REAL(eta_alpha * sigma^-1 * CL * (2.0 * eta_beta * q^2))		M_??	
         DP(2) = REAL(2.0*CL*EAB*DL2*RR)	! REAL(eta_alpha * sigma^-1 * CL * (2.0 * eta_beta * p^2))		M_?? 	
         DP(3) = REAL(CL*SA*EA*C2*RR)		! REAL(eta_alpha * sigma^-1 * CL * (q * gamma))				M_?? 			
         DP(4) = REAL(2.0*CL*SA*EA*EAB*RR)	! REAL(eta_alpha * sigma^-1 * CL * (2.0 * q * eta_alpha * eta_beta))	M_??
         DP(5) = REAL(CL*EA*EA*C2*RR)		! REAL(eta_alpha * sigma^-1 * CL * (eta_alpha * gamma))			M_33
               
         CALL ROMS1(K, NG, DI, P, DP, DD, EPS, NOR)

         ! The following block replaces GO TO (210,230,220), K
         IF (K .EQ. 1) THEN
            GO TO 210     
            ! END LOOP 1.1------------------------------------------ Integral in alpha!!!
         ELSE IF (K .EQ. 2) THEN
            GO TO 220
         ELSE IF (K .EQ. 3) THEN
            GO TO 220
         END IF 

220      CONTINUE
!230      CONTINUE
               
         IF (DI .LT. TL)  GO TO 200	! nu < t_uplim
         ! END LOOP 1------------------------------------------Integral in alpha!!! 
!***

	!===================================================================================
	! Settings for beta wave Integral   
	!===================================================================================                      
         TB2 = TR*TR - VSI   ! (t/r)^2 - (1/beta)^2   
         DRD = -1000.0 
         D2 = VS/VP

	!*************************************NASTY               
         IF (STH .LE. D2)  GO TO 290  ! sin_th <= beta/alpha condition (27), (28)  
  
         IF (TB2 .GT. 0.0)  GO TO 291 ! (t/r)^2 - (1/beta)^2 > 0 
            D1 = R/VP + H*VI	! t_2 = R/alpha + xs_3*(1/beta^2 - 1/alpha^2)^1/2 ; sin_th > beta/alpha Eq. 28 
       
         IF (T .LE. D1) THEN	! Do not compute integrals if t <= t_2, IMPORTANT !!!!
	    GO TO 480
         END IF 

         TB = -SQRT(ABS(TB2))     ! -((t/r)^2 - (1/beta)^2)^1/2 Upper limit in integral (26) for beta
         TL = -SQRT(ABS(TB))	  ! -((t/r)^2 - (1/beta)^2)^1/4 Upper limit in integral (134) for beta  
         GO TO 294
 
290      IF (TB2 .LE. 0.0) THEN	! (t/r)^2 - (1/beta)^2 > 0 
	    GO TO 480
	 END IF 

291      TB = SQRT(TB2)		! ((t/r)^2 - (1/beta)^2)^1/2 Upper limit in integral (26) for beta
         TL = SQRT(TB)		! ((t/r)^2 - (1/beta)^2)^1/4 Upper limit in integral (134) for beta 

         DI = 0.0	! Set nu = 0
         C3 = CR 
         KFL = 3 
         !DRR = (DQR + VSI*CT2)/(1.0 - CT2)
         !     
         !IF (DRR .GT. 0.0)  THEN
         !   DRD = SQRT(TB - SQRT(DRR)) - DRS
         !END IF
       
         IF (STH .LE. D2)  GO TO 300	! sin_th <= beta/alpha condition (27), (28) 
294      D1 = SQRT(((TR - VI*CTH)/STH)**2 - VPI) 
         DI = -SQRT(D1 - TB)	! p_2 = -SQRT(SQRT(((TR - VI*CTH)/STH)**2 - VPI) - TB) with variable change
         C3 = -CI
         KFL = 1
	!*************************************NASTY

	!===================================================================================
	! Integral for beta wave  
	!=================================================================================== 
	! LOOP 2: IF BLOCK AND GO TO
	!        START LOOP 2------------------------------------
300      DD = DDS      ! Loop tag
                  
       ! The following block replaces GO TO (302,304,306,301), KFL
         IF (KFL .EQ. 1) THEN
            D1 = DI + DD
            IF (D1 .GT. 0.0) THEN                
               DD = -DI
               KFL = 2
            END IF 
            GO TO 306
         ELSE IF (KFL .EQ. 2) THEN
            C3 = CR
            KFL = 3
            GO TO 306
         ELSE IF (KFL .EQ. 3) THEN
            GO TO 306
         ELSE IF (KFL .EQ. 4) THEN
            DD = DRS + DRS
            KFL = 3
            GO TO 306
         END IF
                                            
306      D1 = TL - DI                     
         IF (D1 .LT. DD) THEN
            DD = D1
         END IF
       
         IF (DI .LT. DRD)  THEN 
            D1 = DI + DD               
            IF (D1 .GE. DRD) THEN 
               DD = DRD - DI 
               KFL = 4
            END IF
         END IF
      
         CALL ROMS (K, NG, DI, S, DS, DD, EPS, NOR)
               
         ! START LOOP 2.1------------------------------------               
310      CONTINUE      ! Loop tag 
         DL = TB - DI*ABS(DI)		! p = ((t/r)^2 - (1/alpha)^2)^1/2 - nu^2 substitution to remove singularity, abs!!!!!!!!
         DL2 = DL*DL			! p^2                    
       
         ! Implement this conditional !!!!!
         IF (TL .LT. 0.0) THEN	! if ((t/r)^2 - (1/beta)^2)^1/4 < 0  
            CL = 2.0/SQRT(TB + DL + 2.0*(TB/DI)**2)  
         ELSE 
            CL = 2.0/SQRT(TB + DL)! if ((t/r)^2 - (1/beta)^2)^1/4 >= 0 
         END IF
       
         D1 = -TR*STH				! -t/r * sin_th
         D2 = SQRT(ABS(TB2 - DL2))*CTH		! ((t/r)^2 - (1/beta)^2 - p^2)^1/2 * cos_th 
         SB = D1*CR + D2*CI*C3 			! q = -t/r * sin_th + i((t/r)^2 - (1/beta)^2 - p^2)^1/2 * cos_th Equation (32)
         SB2 = SB*SB 				! q^2
         C4 = SB2 + DL2				! q^2 + p^2
         C1 = SB2 - DL2				! q^2 - p^2				
         EA = CSQRT(VPI - C1)			! eta_alpha = ((1/alpha)^2 - q^2 + p^2)^1/2 Equation (21)
         EB = CSQRT(VSI - C1)			! eta_beta = ((1/beta)^2 - q^2 + p^2)^1/2 Equation (23)
         EAB = EA*EB 				! eta_alpha * eta_beta
         C2 = EB*EB - C1			! gamma = eta_beta^2 + p^2 - q^2 Equation (29) 
         C5 = C2 - 4.0*EAB 			! gamma - 4*eta_alpha*eta_beta
         RR = 1.0/(C3*(C2*C2 + 4.0*EAB*C1))	! sigma^-1 = 1/(gamma^2 + 4*eta_alpha * eta_beta * (q^2 - p^2)) Equation (30)
               
         ! Assembly N_ij	 
         DS(1) = REAL(CL*(DL2*C5 + EB*EB*C2)*RR)! REAL(sigma^-1 * eta_beta * CL * (p^2*(gamma - 4*eta_alpha*eta_beta)/eta_beta + eta_beta*gamma))
         DS(2) = REAL(CL*(SB2*C5 - EB*EB*C2)*RR)! REAL(sigma^-1 * eta_beta * CL * (q^2*(gamma - 4*eta_alpha*eta_beta)/eta_beta - eta_beta*gamma))
         DS(3) = REAL(-2.0*CL*SB*EB*EAB*RR)	! REAL(sigma^-1 * eta_beta * CL * (2 * -q * gamma))
         DS(4) = REAL(-CL*SB*EB*C2*RR)		! REAL(sigma^-1 * eta_beta * CL * (-q * gamma))
         DS(5) = REAL(2.0*CL*EAB*C1*RR)		! REAL(sigma^-1 * eta_beta * CL * (2 * eta_alpha * (q^2 - p^2)))F
               
         CALL ROMS1(K, NG, DI, S, DS, DD, EPS, NOR)

         ! The following block replaces GO TO (310,330,320), K
         IF (K .EQ. 1) THEN
            GO TO 310
            ! END LOOP 2.1------------------------------------------
         ELSE IF (K .EQ. 2) THEN
            GO TO 330
         ELSE IF (K .EQ. 3) THEN
            GO TO 320
         END IF                
320      CONTINUE 
330      CONTINUE
               
         IF (DI .LT. TL)  GO TO 300
         ! END LOOP 2------------------------------------------

!***       
480   END IF
            
      DO 490 J=1, NG
         D1 = SC*(P(J) + S(J))  ! Assemby of integral, NG = 5 
         G(J,I) = D1	! I from main loop
490   CONTINUE

      T = T + DT
600   CONTINUE
               
      ! LOOP OVER NT (Number of points in t) to write resuls
      DO 800 I=1, NT 
         WRITE (NFOU,44) (G(J,I),J=1,NG)  !Write results to output
800   CONTINUE

      CLOSE (UNIT=NFPR)
      CLOSE (UNIT=NFOU)
      STOP
      END    
C###################################################################################




      
C===================================================================================
C SUBROUTINE ROMS, Romberg's scheme to compute integrals
c	K	: !!! 	
c	NY	: Number of entries in G, determines the number of integrals to compute 
c	X	: Integration variable, nu 
c	Y	: Output value of integral 
c	YDOT	: Integrand
C	DX	: differential dnu 
C	EPS 	: Error !!!
C	NOR	: Order 19 !!! 
C===================================================================================      
      SUBROUTINE ROMS (K, NY, X, Y, YDOT, DX, EPS, NOR)
      DIMENSION N(21),AA(20,20),BB(20,20),C(20),V(20),W(20),Y(20), 
     1          YDOT(20)
      DATA MNOR,ISN,N(1),N(2),N(3)/20,1,1,2,3/	! Declare and initialize 

      IF (ISN .NE. 0) THEN       
         DO 90 I=4, MNOR, 2
            N(I) = N(I - 2) + N(I - 2)
            N(I+1) = N(I - 1) + N(I - 1)
90       CONTINUE      
         ISN = 0 
      END IF
      
      NN = NOR 
      NM = NOR - 1
      XX = X + DX 
      XMI = AMIN1(X, XX) 
      XMA = AMAX1(X, XX) 
      E = XMA - XMI 
      IR = 0
      
      IF (EPS .LT. 0.0) THEN
         IR = 1
      END IF

      ERR = ABS(EPS)
      KI = 1
      K = 1
      
      RETURN
      !------------------------------------------------------------------
      
      ENTRY ROMS1 (K, NY, X, Y, YDOT, DX, EPS, NOR)
      ! The following block replaces GO TO (110,130,140,150), KI
      IF (KI .EQ. 1) THEN
         IF (E .EQ. 0.0) THEN
            K = 2
         ELSE
            DO 122 J=1, NY
               C(J) = YDOT(J)
 122        CONTINUE
            X = X + DX
            KI = 2
         END IF             
         GO TO 400
      ELSE IF (KI .EQ. 2) THEN
         GO TO 130
      ELSE IF (KI .EQ. 3) THEN
	 GO TO 140
      ELSE IF (KI .EQ. 4) THEN
         GO TO 150
      END IF
!-130------------------------------------------------------------------ 
130      DO 134 J=1, NY 
            DB = 0.5*(C(J) + YDOT(J)) 
            V(J) = E*DB 
            DO 133 I=1, NN 
               BB(I,J) = DB
133         CONTINUE
134      CONTINUE
         M = 0 
138      M = M + 1 
         M1 = M + 1
         M2 = M + 2
         NC = N(M1)
         NC1 = NC - 1
         FNC = FLOAT(NC) 
         H = E/FNC 
         X = XMI + H 
         KI = 3
         GO TO 400
!-140------------------------------------------------------------------      
140   DO 142 J=1, NY 
         C(J) = YDOT(J)
142   CONTINUE
      KEO = 1 
      IF (MOD(M1,2) .NE. 0) THEN
         KEO = 2
      END IF      
      I = 1 
      IF (M .EQ. 2) THEN
         I = 0
      END IF
      ! INIT LOOP 3------------------------------------
145   I = I + 2 
      IF (I .GT. NC1)  GO TO 160
         ! The following block replaces GO TO (148,147), KEO
         IF (KEO .EQ. 1) THEN
            GO TO 148
         ELSE IF (KEO .EQ. 2) THEN
            GO TO 147
         END IF            
147    IF (MOD(I,3) .EQ. 0)  GO TO 145
       ! END LOOP 3------------------------------------       
148   X = XMI + FLOAT(I)*H
      KI = 4
      GO TO 400
!-150------------------------------------------------------------------      
150   DO 152 J=1, NY 
         C(J) = C(J) + YDOT(J)
152   CONTINUE  
      GO TO 145   ! NASTY LOOP
         
160   DO 182 J=1, NY        
         ! The following block replaces GO TO (161,170),  KEO 
         IF (KEO .EQ. 1) THEN
            GO TO 161
         ELSE IF (KEO .EQ. 2) THEN
            GO TO 170
         END IF 

161      DO 162 I=M2, NN
            BB(I,J) = BB(I,J) + C(J)
162      CONTINUE 

         BB(M,J) = BB(M,J) + C(J)
         GO TO 180
 
170      DO 172 I=M, NN, 2 
            BB(I,J) = BB(I,J) + C(J)
172      CONTINUE

180      AA(M,J) = 0.0 
         C(J) = H*BB(M,J)
         W(J) = C(J) 
182   CONTINUE
            
      DO 280 I=1, M
         MI = M - I
         D = FNC/FLOAT(N(MI + 1))
         D = D*D - 1.0 
         ERS = 0.0 
         DO 200 J=1, NY 
            H = C(J)
            DD = (H - V(J))/D + H 
            V(J) = AA(I,J)
            AA(I,J) = DD
            C(J) = DD 
            DE = ABS(DD - H)

            IF (DD .NE. 0.0) THEN 
               IF (IR .EQ. 1) THEN
		  DE = DE/ABS(DD) 
	       END IF
               ERS = AMAX1(ERS, DE) 
	    END IF
200	 CONTINUE

         IF (ERS .LE. ERR) THEN
	    GO TO 320
	 END IF
280   CONTINUE
      
      DO 302 J=1, NY 
         V(J) = W(J)
302   CONTINUE 
        
      IF (M .LT. NM)  GO TO 138  ! NASTY LOOP

      K = 3 
      GO TO 340
 
320   K = 2 
      M = I 

340   DO 342 J=1, NY 
         Y(J) = Y(J) + SIGN(1.0, DX)*AA(M,J)
342   CONTINUE

      X = XX
      GO TO 400
!------------------------------------------------------------------

400   RETURN
C---------------------------------------------------------------------      
      END
