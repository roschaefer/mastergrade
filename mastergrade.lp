%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% course template: course(N, G, P, W, M).                                    %%
%% N = unique name of the course                                              %% 
%% G = grade*10, 1.0 encoded as 10                                            %%
%% P = available ects credit points, e.g. it's possible to use only 3         %%
%%     instead of 6 lp, therefore (3;6) or just 3                             %%
%% W = possible weight, always either 1 or 3                                  %%
%% M = assigned module: itse, samt, bpet, ist, osis or hct                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% List of passed courses                                                     %%
%% Needs to be updated for every student individually.                        %%
%% You can speed up the process if you put in some common knowledge:          %%
%% In any case, it's reasonable to assign your best grades to "itse" with     %%
%% all ects credit points and factor 3. ITSE is the only compulsory module.   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% slight optimization here, helpful to reduce the so called 'grounding'
course( "AAA" , 10 , 3 , 3 , itse).
course( "BBB" , 10 , 3 , 3 , itse).
course( "CCC" , 10 , 6 , 3 , itse).
course( "DDD" , 10 , 6 , 3 , itse).


0 { course( "EEE" , 23 , (3;6) , (1;3) , (itse;bpet;ist))  } 1.
0 { course( "FFF" , 37 , (3;6) , (1;3) , (itse;osis;samt)) } 1.
0 { course( "GGG" , 20 , 3     , (1;3) , (bpet;osis))      } 1.
0 { course( "HHH" , 40 , 3     , (1;3) , (itse;osis;samt)) } 1.
0 { course( "III" , 30 , 3     , (1;3) , (itse;osis;samt)) } 1.
0 { course( "JJJ" , 27 , (3;6) , (1;3) , (bpet;osis))      } 1.
0 { course( "KKK" , 20 , 3     , (1;3) , (ist;osis;samt))  } 1.
0 { course( "LLL" , 23 , (3;6) , (1;3) , (itse;osis;samt)) } 1.
0 { course( "MMM" , 23 , (3;6) , (1;3) , (itse;osis;samt)) } 1.
0 { course( "NNN" , 17 , 3     , (1;3) , (ist;osis;samt))  } 1.
0 { course( "OOO" , 13 , (3;6) , (1;3) , (itse;osis;samt)) } 1.
0 { course( "PPP" , 33 , (3;6) , (1;3) , (itse;osis;samt)) } 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% choose first and second major                                              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
1 {major_one((samt;osis;bpet;ist;hct)) } 1.
1 {major_two((samt;osis;bpet;ist;hct)) } 1.
:- major_one(M), major_two(M).

%% avoid more than the required modules
major_one(M); major_two(M); M == itse :- course(_,_,_,_,M).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% count credits according to curriculum                                      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
credits_itse(C,3) :- C = #sum{ P,N : course(N,_,P,3,itse) }.
credits_itse(C,1) :- C = #sum{ P,N : course(N,_,P,1,itse) }.
:- credits_itse(C,3), C != 18.
:- credits_itse(C,1), C != 6.

credits_major_one(C,3) :- C = #sum{ P,N : course(N,_,P,3,M) }, major_one(M).
credits_major_one(C,1) :- C = #sum{ P,N : course(N,_,P,1,M) }, major_one(M).
:- credits_major_one(C,3), C != 18.
:- credits_major_one(C,1), C != 6.

credits_major_two(C,3) :- C = #sum{ P,N : course(N,_,P,3,M) }, major_two(M).
credits_major_two(C,1) :- C = #sum{ P,N : course(N,_,P,1,M) }, major_two(M).
:- credits_major_two(C,3), C != 12.
:- credits_major_two(C,1), C != 3.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% calculate mastergrade                                                      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k_total(K):- K = #sum{G*P*W, N: course(N,G,P,W,_) }.
mastergrade(G) :- G=(K/159), k_total(K).
#minimize {G : mastergrade(G)}.

%% show only courses and the resulting mastergrade
#show course/5.
#show mastergrade/1.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
