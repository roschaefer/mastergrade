%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% course template: course(N, G, P, W, M).                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
0 { course("AAA", 10 , 3     , (1;3) , (itse;osis;samt)) } 1.
0 { course("BBB", 10 , 3     , (1;3) , (itse;osis;samt)) } 1.
0 { course("CCC", 23 , (3;6) , (1;3) , (itse;bpet;ist))  } 1.
0 { course("DDD", 10 , (3;6) , (1;3) , (itse;samt))      } 1.
0 { course("EEE", 37 , (3;6) , (1;3) , (itse;osis;samt)) } 1.
0 { course("FFF", 20 , 3     , (1;3) , (bpet;osis))      } 1.
0 { course("GGG", 40 , 3     , (1;3) , (itse;osis;samt)) } 1.
0 { course("HHH", 30 , 3     , (1;3) , (itse;osis;samt)) } 1.
0 { course("III", 27 , (3;6) , (1;3) , (bpet;osis))      } 1.
0 { course("JJJ", 20 , 3     , (1;3) , (ist;osis;samt))  } 1.
0 { course("KKK", 10 , (3;6) , (1;3) , (itse;osis;samt)) } 1.
0 { course("LLL", 23 , (3;6) , (1;3) , (itse;osis;samt)) } 1.
0 { course("MMM", 23 , (3;6) , (1;3) , (itse;osis;samt)) } 1.
0 { course("NNN", 17 , 3     , (1;3) , (ist;osis;samt))  } 1.
0 { course("OOO", 13 , (3;6) , (1;3) , (itse;osis;samt)) } 1.
0 { course("PPP", 33 , (3;6) , (1;3) , (itse;osis;samt)) } 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% choose first and second major                                              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
1 {major_one((samt;osis;bpet;ist)) } 1.
1 {major_two((samt;osis;bpet;ist)) } 1.
:- major_one(M), major_two(M).

% avoid more than the required modules
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
