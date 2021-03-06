% Generated by ADiMat 0.6.0-4867
% Copyright 2009-2013 Johannes Willkomm, Fachgebiet Scientific Computing,
% TU Darmstadt, 64289 Darmstadt, Germany
% Copyright 2001-2008 Andre Vehreschild, Institute for Scientific Computing,
% RWTH Aachen University, 52056 Aachen, Germany.
% Visit us on the web at http://www.adimat.de
% Report bugs to adimat-users@lists.sc.informatik.tu-darmstadt.de
%
%
%                             DISCLAIMER
%
% ADiMat was prepared as part of an employment at the Institute
% for Scientific Computing, RWTH Aachen University, Germany and is
% provided AS IS. NEITHER THE AUTHOR(S), THE GOVERNMENT OF THE FEDERAL
% REPUBLIC OF GERMANY NOR ANY AGENCY THEREOF, NOR THE RWTH AACHEN UNIVERSITY,
% INCLUDING ANY OF THEIR EMPLOYEES OR OFFICERS, MAKES ANY WARRANTY,
% EXPRESS OR IMPLIED, OR ASSUMES ANY LEGAL LIABILITY OR RESPONSIBILITY
% FOR THE ACCURACY, COMPLETENESS, OR USEFULNESS OF ANY INFORMATION OR
% PROCESS DISCLOSED, OR REPRESENTS THAT ITS USE WOULD NOT INFRINGE
% PRIVATELY OWNED RIGHTS.
%
% Global flags were:
% FORWARDMODE -- Apply the forward mode to the files.
% NOOPEROPTIM -- Do not use optimized operators. I.e.:
%		 g_a*b*g_c -/-> mtimes3(g_a, b, g_c)
% NOLOCALCSE  -- Do not use local common subexpression elimination when
%		 canonicalizing the code.
% NOGLOBALCSE -- Prevents the application of global common subexpression
%		 elimination after canonicalizing the code.
% NOPRESCALARFOLDING -- Switch off folding of scalar constants before
%		 augmentation.
% NOPOSTSCALARFOLDING -- Switch off folding of scalar constants after
%		 augmentation.
% NOCONSTFOLDMULT0 -- Switch off folding of product with one factor
%		 being zero: b*0=0.
% FUNCMODE    -- Inputfile is a function (This flag can not be set explicitly).
% NOTMPCLEAR  -- Suppress generation of clear g_* instructions.
% UNBOUND_ERROR	-- Stop with error if unbound identifiers found (default).
% VERBOSITYLEVEL=4

function [g_U, U]= g_adimat_chol(g_A, A)
   % CHOLESKY_FACTOR computes the Cholesky factor of a matrix.
   %
   % Given a symmetric positive definite matrix A, this function computes the
   % upper triangular matrix U such that U'*U = A. Since we are trying to
   % mimic a Fortran program, this Matlab implementation works on a scalar
   % level, avoiding all vector-like operations.
   %
   % From an algorithmic point of view, this function produces the output U
   % from using the upper triangular part of the input A. The lower tringular
   % part of A is never used. That is, using automatic or numerical
   % differentiation, the derivatives wrt all entries of the lower triangular
   % part will be zero. 
   
   % Author: D. Fabregat Traver, RWTH Aachen University
   % Date: 03/08/12
   % History: 
   % 1) Comment added by Martin Buecker, 03/19/12
   % 2) Re-vectorized, second parameter added by Johannes Willkomm, 06/17/12
   
   n= size(A, 1); 
   for i= 1: n
      g_tmp_A_00000= g_A(i, i);
      tmp_A_00000= A(i, i);
      A(i, i)= sqrt(tmp_A_00000); 
      g_A(i, i)= g_tmp_A_00000./ (2.* A(i, i));
      tmp_adimat_chol_00001= i+ 1;
      tmp_adimat_chol_00002= tmp_adimat_chol_00001: n;
      g_tmp_A_00001= g_A(i, tmp_adimat_chol_00002);
      tmp_A_00001= A(i, tmp_adimat_chol_00002);
      g_tmp_A_00002= g_A(i, i);
      tmp_A_00002= A(i, i);
      g_A(i, i+ 1: n)= (g_tmp_A_00001.* tmp_A_00002- tmp_A_00001.* g_tmp_A_00002)./ tmp_A_00002.^ 2;
      A(i, i+ 1: n)= tmp_A_00001./ tmp_A_00002; 
      tmp_adimat_chol_00003= i+ 1;
      for j= tmp_adimat_chol_00003: n
         k= i+ 1: j; 
         g_tmp_A_00003= g_A(k, j);
         tmp_A_00003= A(k, j);
         g_tmp_A_00004= g_A(i, k);
         tmp_A_00004= A(i, k);
         g_tmp_A_00005= g_A(i, j);
         tmp_A_00005= A(i, j);
         g_tmp_adimat_chol_00004= g_tmp_A_00004.* tmp_A_00005+ tmp_A_00004.* g_tmp_A_00005;
         tmp_adimat_chol_00004= tmp_A_00004.* tmp_A_00005;
         g_A(k, j)= g_tmp_A_00003.' - g_tmp_adimat_chol_00004;
         A(k, j)= tmp_A_00003.' - tmp_adimat_chol_00004; 
         tmp_adimat_chol_00003= i+ 1;
      end
   end
   g_U= call(@triu, g_A);
   U= triu(A); 
   
end


% $Id: adimat_chol.m 3739 2013-06-12 16:49:42Z willkomm $
