% generate (num_of_pairs) state-action pairs from an optimal sample 
function pairs = Generate_SAPairs_From_Sample(output,num_of_pairs)
    t = output.result.solution.phase.time;
    state = output.result.solution.phase.state;
    control = output.result.solution.phase.control;
    
    pairs = [];
    for i=1:num_of_pairs
        t_ = t(1) + (t(end)-t(1))*rand;
        state_ = interp1(t,state,t_,'spline');
        control_ = interp1(t,control,t_);
        SApair = [state_, control_];
        pairs = [pairs;SApair];
    end
end