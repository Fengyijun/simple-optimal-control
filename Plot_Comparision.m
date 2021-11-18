%---------------------------------------------%
%--------------- Plot Comparision ------------%
%---------------------------------------------%

function Plot_Comparision(output_net,output_GPOPS)
    t_net = output_net.result.solution.phase.time;
    state_net = output_net.result.solution.phase.state;
    control_net = output_net.result.solution.phase.control;

    t_GPOPS = output_GPOPS.result.solution.phase.time;
    state_GPOPS = output_GPOPS.result.solution.phase.state;
    control_GPOPS = output_GPOPS.result.solution.phase.control;
    
    figure(1);
    plot(state_net(:,1),state_net(:,2),'linewidth',2);
    hold on;
    plot(state_GPOPS(:,1),state_GPOPS(:,2),'--','linewidth',2);
    xlabel('x(m)'),ylabel('y(m)');
    legend('net','GPOPS');
    
    figure(2);
    subplot(2,1,1);
    plot(t_net,state_net(:,3),'linewidth',2);
    hold on;
    plot(t_GPOPS,state_GPOPS(:,3),'--','linewidth',2);
    xlabel('t(s)'),ylabel('Vx(m/s)');
    legend('net','GPOPS');
    subplot(2,1,2);
    plot(t_net,state_net(:,4),'linewidth',2);
    hold on;
    plot(t_GPOPS,state_GPOPS(:,4),'--','linewidth',2);
    xlabel('t(s)'),ylabel('Vy(m/s)');
    
    figure(3)
    subplot(2,1,1);
    plot(t_net,control_net(:,1),'linewidth',2);
    hold on;
    plot(t_GPOPS,control_GPOPS(:,1),'--','linewidth',2);
    xlabel('t(s)'),ylabel('ax(m/s^2)');
    legend('net','GPOPS');
    subplot(2,1,2);
    plot(t_net,control_net(:,2),'linewidth',2);
    hold on;
    plot(t_GPOPS,control_GPOPS(:,2),'--','linewidth',2);
    xlabel('t(s)'),ylabel('ay(m/s^2)');    
end