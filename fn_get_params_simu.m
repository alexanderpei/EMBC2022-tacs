function P = fn_get_params_simu(numExp, N)

% Returns the params (P) for some experiment number (num_exp)

% Model params
% if numExp == 1
% 
%     P.Af = [ 0 5  ;
%              0 0 ];
%     
%     P.Ab = [ 0 0  ;
%              20 0 ]; 
% 
%     P.Al = [ 0 0  ;
%              0 0 ];
% 
%     
% elseif numExp == 2
% 
%     P.Af = [ 0 50  ;
%              0 0 ];
%     
%     P.Ab = [ 0 0  ;
%              50 0 ]; 
% 
%     P.Al = [ 0 0  ;
%              0 0 ]; 
% 
% elseif numExp == 3
% 
%         P.Af = [ 0 5  ;
%              0 0 ];
%     
%     P.Ab = [ 0 0  ;
%              20 0 ]; 
% 
%     P.Al = [ 0 0  ;
%              0 0 ];
% 
%     
% end

P.Af = [ 0 5  ;
    0 0 ];

P.Ab = [ 0 0  ;
    20 0 ];

P.Al = [ 0 0  ;
    0 0 ];
    
P.He  = [3.25 ; 3.25];
P.Hi  = [29.3 ; 29.3];
P.py  = [0; 0];
P.Te  = [10 ; 10]/1000;
P.Ti  = [15 ; 15]/1000;
P.d   = [10]/1000;

P.g1  = 50;
P.g2  = 40;
P.g3  = 12;
P.g4  = 12;

P.e0  = 2.5;
P.v0  = 0;
P.r   = 0.56;

P.C   = 1000;

P.sp  = 0.05;

P.seed = randi(100000, [1 2]);

