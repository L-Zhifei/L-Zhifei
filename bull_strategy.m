function simObj = bull_strategy(simObj,lambda)
    % Only buy large porfolio strategy
    if nargin<2
        lambda = 0.5;
    end
    simObj.reset(); % reset simulation environment
    % ilambda = 1/lambda;
    for i=1:simObj.T
        deductor = 1;
       if (i == 1)
         w_const = simObj.s_cur;
           w_const = w_const./sum(w_const); % initial price weighted portfolio vector
        simObj.step(w_const);
       else
           s_inc = (simObj.s_cur-simObj.s_hist( :,i-deductor))./simObj.s_hist( :,i-deductor); % create a matrix of price increment
           s_quit=s_inc <= 0; % find stocks with decreasing or unchanged prices and form a logistic matrix
           s_inc = s_inc.*s_quit; % get new increment matrix with only positive increments
           w_const = s_inc;
           w_const = w_const./sum(w_const) % price increment weighted portfolio vector
         simObj.step(w_const);
       end
    end
end 
 
       
   