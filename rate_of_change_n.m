function DX = rate_of_change_n(t,X,GM,n)

% This function returns the time differential of X in DX, at time t.
% DX has the same general format as X, however it contains the derivatives 
% of the respectove values in X.

Y=zeros(n,6); %set a dummy Matrix Y to be of the same format as X in the main function


counter=0;
for i=1:n   %fill Y with the corresponding X values.
    for j=1:6
        counter=counter+1;
        Y(i,j)=X(counter);
    end
end

   
DX=zeros(n,6); %initialise DX for speed.
a=zeros(1,n); %initialise a for speed.
mu=0; %initlaise mu
c_sqr=(3*10^8)^2; %set constant that is useful later

for i=1:n %for each body
    for j=1:n   %and each body
        if j==1 && i~=1  %if body j is the Sun
           r = sqrt((Y(i,1)-Y(j,1))^2+(Y(i,2)-Y(j,2))^2+(Y(i,3)-Y(j,3))^2); %this is the distance between two bodies, i and j.
            
           DX(i,1) = Y(i,4); %derivative of positon is velocity, but we already have our velocity values in Y.
           DX(i,2) = Y(i,5);
           DX(i,3) = Y(i,6);
           
           mu=GM(i)+GM(j);
           a(i)=(mu*r)/(2*mu-r*(DX(i,1)^2+DX(i,2)^2+DX(i,3)^2));  %this calculates the semi-major axis of the orbit by conservation of energy.
           
           
           
           DX(i,4) = DX(i,4)+((-GM(j)*(Y(i,1)-Y(j,1))/r^3)*(1-(9*GM(j))/(c_sqr*a(i)))+((6*GM(j))/(c_sqr*abs(r))));  %calculate the accelaration on body i due to body j, when the loop moves on to a new body acting on i, it should add the previous value to the running total.
           DX(i,5) = DX(i,5)+((-GM(j)*(Y(i,2)-Y(j,2))/r^3)*(1-(9*GM(j))/(c_sqr*a(i)))+((6*GM(j))/(c_sqr*abs(r))));  %this includes relativistic corrections as given by "Numerical Integration for the real time production of fundamental ephemerides over a wide time span" by Aldo Vitagliano
           DX(i,6) = DX(i,6)+((-GM(j)*(Y(i,3)-Y(j,3))/r^3)*(1-(9*GM(j))/(c_sqr*a(i)))+((6*GM(j))/(c_sqr*abs(r))));
        
       
        elseif i~=j %if bodies aren't the same
            
            r = sqrt((Y(i,1)-Y(j,1))^2+(Y(i,2)-Y(j,2))^2+(Y(i,3)-Y(j,3))^2); %this is the distance between two bodies, i and j.
            
           DX(i,1) = Y(i,4); %derivative of positon is velocity, but we already have our velocity values in Y.
           DX(i,2) = Y(i,5);
           DX(i,3) = Y(i,6);
           
           DX(i,4) = DX(i,4)+((-GM(j)*(Y(i,1)-Y(j,1))/r^3));  %calculate the accelaration on body i due to body j, when the loop moves on to a new body acting on i, it should add the previous value to the running total.
           DX(i,5) = DX(i,5)+((-GM(j)*(Y(i,2)-Y(j,2))/r^3));  %relativistic corrections only apply if the body acting on the considered body is the Sun.
           DX(i,6) = DX(i,6)+((-GM(j)*(Y(i,3)-Y(j,3))/r^3));
        end
        
    end
end

DX=reshape(DX',[numel(DX),1]); %finally we reshape DX to a column vector so it works with ode45
end