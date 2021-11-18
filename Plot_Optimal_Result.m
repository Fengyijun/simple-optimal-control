%------------------------------------------------%
%--------------- Plot Optimal Result ------------%
%------------------------------------------------%

function Plot_Optimal_Result(output)
    t = output.result.solution.phase.time;
    state = output.result.solution.phase.state;
    control = output.result.solution.phase.control;
    
    figure;
    subplot(1,3,1);
    plot(state(:,1),state(:,2),'linewidth',2);
    xlabel('x(m)'),ylabel('y(m)');
    subplot(1,3,2);
    plot(t,state(:,3),'linewidth',2);
    hold on;
    plot(t,state(:,4),'linewidth',2);
    xlabel('t(s)'),ylabel('V(m/s)');
    legend('Vx','Vy');
    subplot(1,3,3);
    plot(t,control(:,1),'linewidth',2);
    hold on;
    plot(t,control(:,2),'linewidth',2);
    xlabel('t(s)'),ylabel('acceration(m/s)');
    legend('ax','ay');
end