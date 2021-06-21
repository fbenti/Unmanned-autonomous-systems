function par = line_fit(x,y)
par = polyfit(x,y,1);
y_est = polyval(par,x);
scatter(x,y)
hold on
plot(x,y_est,'r--','LineWidth',2)

disp(['Equation is y = ' num2str(par(1)) '*x + ' num2str(par(2))])
end