load sinal.txt;
h1 = 1/11 * [1 1 1 1 1 1 1 1 1 1 1];
h2 = 1/14 * [1 1 1 1 2 2 2 1 1 1 1];
h3 = 1/9 * [1 1 2 2 -3 3 -3 2 2 1 1];

subplot(411); 
plot(sinal); 

subplot(412); 
plot(conv(sinal,h1)); 

subplot(413);
plot(conv(sinal,h2)); 

subplot(414);
plot(conv(sinal,h3));
